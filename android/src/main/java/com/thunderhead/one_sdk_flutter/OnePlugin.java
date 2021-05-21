package com.thunderhead.one_sdk_flutter;

import android.util.Log;

import com.thunderhead.One;
import com.thunderhead.OneLogLevel;
import com.thunderhead.OneModes;
import com.thunderhead.android.api.configuration.OneConfiguration;
import com.thunderhead.android.api.interactions.OneCall;
import com.thunderhead.android.api.interactions.OneCallback;
import com.thunderhead.android.api.interactions.OneInteractionPath;
import com.thunderhead.android.api.interactions.OneRequest;
import com.thunderhead.android.api.responsetypes.OneAPIError;
import com.thunderhead.android.api.responsetypes.OneResponse;
import com.thunderhead.android.api.responsetypes.OneSDKError;
import com.thunderhead.utils.ThunderheadLogger;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.FlutterPlugin;

/** OnePlugin */
public class OnePlugin implements MethodCallHandler, FlutterPlugin {
  protected static final String LOG_TAG = "OnePlugin";

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
    this.applicationContext = applicationContext;
    methodChannel = new MethodChannel(messenger, "one_sdk_flutter");
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    applicationContext = null;
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

    } else if (call.method.equals("setLogLevel")) {
      setLogLevel(call, result);
    } else if (call.method.equals("initializeOne")) {
      initializeOne(call, result);
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
            .mode(adminMode ? OneModes.ADMIN_MODE : OneModes.USER_MODE)
            .build();
    One.setConfiguration(oneConfiguration);
    result.success(true);
  }

  private void setLogLevel(MethodCall call, final Result result) {
    final Map<String, Boolean> arguments = call.arguments();
    Boolean allOrNone = arguments.get("logLevel");
    if (allOrNone == null) {
      allOrNone = true;
    }
    One.setLogLevel(allOrNone ? OneLogLevel.ALL : OneLogLevel.NONE);
    result.success("Set Thunderhead LogLevel: " + (allOrNone ? "Enabled" : "Disabled"));
  }

  private void sendInteraction(String interactionPath, HashMap properties, final Result result) {
    final OneRequest sendInteractionRequest = new OneRequest.Builder()
            .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
            .properties(properties)
            .build();

    final OneCall sendInteractionCall = One.sendInteraction(sendInteractionRequest);
    sendInteractionCall.enqueue(new OneCallback() {
      @Override
      public void onSuccess(final OneResponse response) {
        One.processResponse(response);
        result.success(response.getTid());
      }

      @Override
      public void onError(OneSDKError error) {
        result.error(Integer.toString(error.getSystemCode()), error.getLocalizedMessage(), error);
        Log.e(LOG_TAG, "SDK Error: " +  error.getErrorMessage());
      }

      @Override
      public void onFailure(OneAPIError error) {
        result.error(Integer.toString(error.getHttpStatusCode()), error.getLocalizedMessage(), error);
        Log.e(LOG_TAG, "Api Error: " +  error.getErrorMessage());
      }
    });
  }
}
