package com.thunderhead.one_sdk_flutter;

import android.content.Context;
import android.os.Build;
import android.util.Log;

import com.thunderhead.mobile.One;
import com.thunderhead.mobile.configuration.OneConfiguration;
import com.thunderhead.mobile.configuration.OneMode;
import com.thunderhead.mobile.interactions.OneInteractionPath;
import com.thunderhead.mobile.interactions.OneRequest;
import com.thunderhead.mobile.interactions.OneResponseCode;
import com.thunderhead.mobile.interactions.OneResponseCodeRequest;
import com.thunderhead.mobile.logging.OneLogComponent;
import com.thunderhead.mobile.logging.OneLogLevel;
import com.thunderhead.mobile.logging.OneLoggingConfiguration;
import com.thunderhead.mobile.optout.OneOptOutConfiguration;
import com.thunderhead.mobile.optout.OneOptInOptions;
import com.thunderhead.mobile.responsetypes.OneAPIError;
import com.thunderhead.mobile.responsetypes.OneResponse;
import com.thunderhead.mobile.responsetypes.OneSDKError;
import com.thunderhead.mobile.responsetypes.OptimizationPoint;

import java.net.URI;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * OnePlugin
 */
public class OnePlugin implements MethodCallHandler, FlutterPlugin {
    protected static final String LOG_TAG = "OnePlugin";
    private MethodChannel methodChannel;
    private final ExecutorService executor = Executors.newSingleThreadExecutor();

    /** Plugin registration. */
    /**
     * We are keeping the registerWith() method to remain compatible with apps that don’t use the v2 Android embedding
     */
    @SuppressWarnings("deprecation")
    public static void registerWith(Registrar registrar) {
        final OnePlugin instance = new OnePlugin();
        instance.onAttachedToEngine(registrar.context(), registrar.messenger());
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        methodChannel = new MethodChannel(messenger, "one_sdk_flutter");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        try {
            if (call.method.equals("getPlatformVersion")) {
                result.success("Android " + android.os.Build.VERSION.RELEASE);
            } else if (call.method.equals("sendInteraction")) {
                final Map<String, Object> arguments = call.arguments();
                String interactionPath = (String) arguments.get("interactionPath");
                HashMap<String, Object> properties = (HashMap) arguments.get("properties");
                try {
                    sendInteraction(interactionPath, properties, result);
                } catch (Exception e) {
                    result.error("Failed to send interaction", e.getLocalizedMessage(), e);
                }
            } else if (call.method.equals("sendResponseCode")) {
                final Map<String, String> arguments = call.arguments();
                String responseCode = (String) arguments.get("responseCode");
                String interactionPath = (String) arguments.get("interactionPath");
                sendResponseCode(responseCode, interactionPath, result);
            } else if (call.method.equals("setLogLevel")) {
                setLogLevel(call, result);
            } else if (call.method.equals("initializeOne")) {
                initializeOne(call, result);
            } else if (call.method.equals("optOut")) {
                optOut(call, result);
            } else {
                result.notImplemented();
            }
        } catch (Exception error) {
            Log.e(LOG_TAG, "[Thunderhead] Method Call Exception Error: " + error.getLocalizedMessage());
            result.error(Integer.toString(error.hashCode()), error.getLocalizedMessage(), error);
        }
    }

    private void initializeOne(MethodCall call, final Result result) {
        final Map<String, Object> arguments = call.arguments();
        String siteKey = (String) arguments.get("siteKey");
        String touchpointURI = (String) arguments.get("touchpoint");
        String apiKey = (String) arguments.get("apiKey");
        String sharedSecret = (String) arguments.get("sharedSecret");
        String userId = (String) arguments.get("userID");
        String host = (String) arguments.get("host");
        boolean adminMode = (Boolean) arguments.get("adminMode");

        final OneConfiguration oneConfiguration = new OneConfiguration.Builder()
                .siteKey(siteKey)
                .apiKey(apiKey)
                .sharedSecret(sharedSecret)
                .userId(userId)
                .host(URI.create(host))
                .touchpoint(URI.create(touchpointURI))
                .mode(adminMode ? OneMode.ADMIN : OneMode.USER)
                .build();
        One.setConfiguration(oneConfiguration);
        result.success(null);
    }

    private void setLogLevel(MethodCall call, final Result result) {
        final Map<String, Boolean> arguments = call.arguments();
        Boolean enabled = arguments.get("logLevel");

        if (enabled == null) {
            enabled = true;
        }

        OneLoggingConfiguration.Builder builder = OneLoggingConfiguration.builder().log(OneLogComponent.ANY);
        if (enabled) {
            builder.log(OneLogLevel.VERBOSE).log(OneLogLevel.DEBUG);
        } else {
            builder.log(OneLogLevel.WARN).log(OneLogLevel.ERROR);
        }

        One.setLoggingConfiguration(builder.build());
        result.success(null);
    }

    private void sendInteraction(final String interactionPath, final HashMap properties, final Result result) {
        final OneRequest sendInteractionRequest = new OneRequest.Builder()
                .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
                .properties(properties)
                .build();
        executor.submit(() -> {
            try {
                OneResponse response;
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    response = One.sendInteraction(true, sendInteractionRequest).join();
                } else {
                    response = One.sendInteractionLegacySupport(true, sendInteractionRequest).join();
                }
                One.processResponse(response);
                HashMap<String, Object> responseMap = responseObjectToHashMap(response);
                result.success(responseMap);
            } catch (ExecutionException error) {
                result.error(Integer.toString(error.hashCode()), error.getLocalizedMessage(), error);
                Log.e(LOG_TAG, "[Thunderhead] Send Interaction Completion Error: " + error.getCause());
            } catch (OneSDKError error) {
                result.error(Integer.toString(error.getSystemCode()), error.getLocalizedMessage(), error);
                Log.e(LOG_TAG, "[Thunderhead] Send Interaction SDK Error: " + error.getErrorMessage());
            } catch (OneAPIError error) {
                result.error(Integer.toString(error.getHttpStatusCode()), error.getLocalizedMessage(), error);
                Log.e(LOG_TAG, "[Thunderhead] Send Interaction Api Error: " + error.getErrorMessage());
            }
        });
    }

    private void sendResponseCode(final String responseCode, final String interactionPath, final Result result) {
        executor.submit(() -> {
            final OneResponseCodeRequest responseCodeRequest = new OneResponseCodeRequest.Builder()
                    .responseCode(new OneResponseCode(responseCode))
                    .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
                    .build();

            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    One.sendResponseCode(true, responseCodeRequest);
                } else {
                    One.sendResponseCodeLegacySupport(true, responseCodeRequest);
                }
                result.success(null);
            } catch (ExecutionException error) {
                result.error(Integer.toString(error.hashCode()), error.getLocalizedMessage(), error);
                Log.e(LOG_TAG, "[Thunderhead] Send Response Code Completion Error: " + error.getCause());
            } catch (OneSDKError error) {
                result.error(Integer.toString(error.getSystemCode()), error.getLocalizedMessage(), error);
                Log.e(LOG_TAG, "[Thunderhead] Send Response Code SDK Error: " + error.getErrorMessage());
            } catch (OneAPIError error) {
                result.error(Integer.toString(error.getHttpStatusCode()), error.getLocalizedMessage(), error);
                Log.e(LOG_TAG, "[Thunderhead] Send Response Code Api Error: " + error.getErrorMessage());
            }
        });
    }

    private void optOut(MethodCall call, final Result result) {
        OneOptOutConfiguration.Builder builder = new OneOptOutConfiguration.Builder();

        final HashMap<String, Object> arguments = call.arguments();
        Boolean optOut = (Boolean) arguments.get("optOut");

        if (optOut == null) {
            optOut = false;
        }

        //region Master switch
        if (optOut) {
            builder.optOut(true);
        } else {
            builder.optOut(false);
            List<String> options = (List<String>) arguments.get("options");
            EnumSet<OneOptInOptions> optInOptions = EnumSet.noneOf(OneOptInOptions.class);

            if (options != null && !options.isEmpty()) {
                for (String option : options) {
                    if (option.equals("cityCountryDetection")) {
                        optInOptions.add(OneOptInOptions.CITY_COUNTRY_DETECTION);
                    }
                }
                builder.optInOptions(optInOptions);
            }
        }
        //endregion
        One.setOptOutConfiguration(builder.build());
        result.success(null);
    }

    // Helper methods

    // Convert OneResponse Class to HashMap so Dart can read it.
    private HashMap<String, Object> responseObjectToHashMap(OneResponse response) {
        HashMap<String, Object> responseMap = new HashMap<>();
        responseMap.put("tid", response.getTid());
        responseMap.put("interactionPath", response.getInteractionPath().getValue().getPath());

        if (!response.getOptimizationPoints().isEmpty()) {
            List<HashMap<String, Object>> optimizationsList = new ArrayList<>();

            for (OptimizationPoint point : response.getOptimizationPoints()) {
                HashMap<String, Object> optimizationPointMap = new HashMap<>();

                optimizationPointMap.put("data", point.getData());
                optimizationPointMap.put("path", point.getPath());
                optimizationPointMap.put("responseId", point.getResponseId());
                optimizationPointMap.put("dataMimeType", point.getDataMimeType());
                optimizationPointMap.put("directives", point.getDirectives());
                optimizationPointMap.put("name", point.getName());
                optimizationPointMap.put("viewPointName", point.getViewPointName());
                optimizationPointMap.put("viewPointId", point.getViewPointId());
                optimizationsList.add(optimizationPointMap);
            }

            responseMap.put("optimizations", optimizationsList);
        }
        return responseMap;
    }
}
