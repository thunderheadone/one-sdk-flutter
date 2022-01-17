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
import com.thunderhead.mobile.responsetypes.OneResponse;

import java.net.URI;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutionException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** OnePlugin */
public class OnePlugin implements MethodCallHandler, FlutterPlugin {
  protected static final String LOG_TAG = "OnePlugin";
  private MethodChannel methodChannel;

  /** Plugin registration. */
  /** We are keeping the registerWith() method to remain compatible with apps that don’t use the v2 Android embedding */
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
    result.success(true);
  }

  private void setLogLevel(MethodCall call, final Result result) {
    OneLoggingConfiguration oneLoggingConfiguration;
    final Map<String, Boolean> arguments = call.arguments();
    Boolean enabled = arguments.get("logLevel");

    if (enabled == null) {
      enabled = true;
    }

    if (enabled) {
      oneLoggingConfiguration = OneLoggingConfiguration.builder()
              .log(OneLogLevel.VERBOSE)
              .log(OneLogLevel.DEBUG)
              .log(OneLogComponent.ANY)
              .build();
    } else {
      oneLoggingConfiguration = OneLoggingConfiguration.builder()
              .log(OneLogLevel.WARN)
              .log(OneLogLevel.ERROR)
              .log(OneLogComponent.ANY)
              .build();
    }

    One.setLoggingConfiguration(oneLoggingConfiguration);
    result.success("Set Thunderhead LogLevel: " + (enabled ? "Enabled" : "Disabled"));
  }

  private void sendInteraction(String interactionPath, HashMap properties, final Result result) throws ExecutionException {
    final OneRequest sendInteractionRequest = new OneRequest.Builder()
            .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
            .properties(properties)
            .build();

//    Thread thread = new Thread() {
//      public void run(){
//
//      }
//    };
//    thread.start();

    try {
      OneResponse response = null;
//      response = One.sendInteractionLegacySupport(true, sendInteractionRequest).get(10, TimeUnit.SECONDS);
      response = One.sendInteractionLegacySupport(true, sendInteractionRequest).join();
      One.processResponse(response);
      result.success(new HashMap<String, Object>());
//      result.success(response);
    } catch (Throwable error) {
      result.error(Integer.toString(error.hashCode()), error.getLocalizedMessage(), error);
      Log.e(LOG_TAG, "Execution Exception Error: " +  error.getLocalizedMessage());
      error.printStackTrace();
    }
  }

  private void sendResponseCode(String responseCode, String interactionPath, final Result result) {
    final OneResponseCodeRequest responseCodeRequest = new OneResponseCodeRequest.Builder()
    .responseCode(new OneResponseCode(responseCode))
    .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
    .build();

    try {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        One.sendResponseCode(responseCodeRequest);
      } else {
        One.sendResponseCodeLegacySupport(responseCodeRequest);
      }
    } catch (ExecutionException e) {
      e.printStackTrace();
    }
  }

  private void optOut(MethodCall call, final Result result) {
    OneOptOutConfiguration optOutConfiguration;
    Set<OneOptInOptions> optInOptions = EnumSet.noneOf(OneOptInOptions.class);

    final HashMap<String, Object> arguments = call.arguments();
    Boolean optOut = (Boolean) arguments.get("optOut");
    List<String> options = (List<String>) arguments.get("options");

    if (optOut == null) {
      optOut = false;
    }

    if (options != null) {
      for (String optOutOption : options) {
        if (optOutOption == "cityCountryDetection") {
          optInOptions.add(OneOptInOptions.CITY_COUNTRY_DETECTION);
        }
      }
    }

    optOutConfiguration = new OneOptOutConfiguration.Builder()
            .optOut(optOut)
            .optInOptions(optInOptions)
            .build();
    One.setOptOutConfiguration(optOutConfiguration);

    result.success("Set Thunderhead OptOut: " + (optOut ? "Opted out" : "Opted in"));
  }

}
