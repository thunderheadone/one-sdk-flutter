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

/** OnePlugin */
public class OnePlugin implements MethodCallHandler {
  protected static final String LOG_TAG = "OnePlugin";

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "one_sdk_flutter");
    channel.setMethodCallHandler(new OnePlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);

    } else if (call.method.equals("sendInteraction")) {
      final Map<String, Object> arguments = call.arguments();
      String interactionPath = (String) arguments.get("interactionPath");
      try {
        sendInteraction(interactionPath, result);
      } catch (Exception e) {
        result.error("Failed to send interaction", e.getLocalizedMessage(), e);
      }

    } else if (call.method.equals("sendProperties")) {
      final Map<String, Object> arguments = call.arguments();
      String interactionPath = (String) arguments.get("interactionPath");
      HashMap<String, Object> properties = (HashMap) arguments.get("properties");
      try {
        sendProperties(interactionPath, properties, result);
      } catch (Exception e) {
        result.error("Failed to send interaction", e.getLocalizedMessage(), e);
      }

    } else if (call.method.equals("setLogLevel")) {
      final Map<String, Boolean> arguments = call.arguments();
      Boolean allOrNone = arguments.get("logLevel");
      if (allOrNone == null) {
        allOrNone = true;
      }
      One.setLogLevel(allOrNone ? OneLogLevel.ALL : OneLogLevel.NONE);
      Log.d(LOG_TAG, "Set Thunderhead LogLevel.");
      result.success("Set Thunderhead LogLevel.");
    } else if (call.method.equals("initializeOne")) {
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

      Log.d(LOG_TAG, "Configuring Thunderhead One Plugin");
      result.success("Configured Thunderhead One Plugin successfully.");

    } else {
      result.notImplemented();

    }
  }

  private void sendInteraction(String interactionPath, final Result result) {
    Log.d(LOG_TAG, "Send Interaction: " + interactionPath);

    final OneRequest sendInteractionRequest = new OneRequest.Builder()
            .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
            .build();
    final OneCall sendInteractionCall = One.sendInteraction(sendInteractionRequest);
    sendInteractionCall.enqueue(new OneCallback() {
      @Override
      public void onSuccess(OneResponse response) {
        One.processResponse(response);
        result.success(response.getHttpStatusCode());
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

  private void sendProperties(String interactionPath, HashMap properties, final Result result) {
    Log.d(LOG_TAG, "Send Interaction: " + interactionPath + " with properties: " + properties);

    final OneRequest sendInteractionRequest = new OneRequest.Builder()
            .interactionPath(new OneInteractionPath(URI.create(interactionPath)))
            .properties(properties)
            .build();

    final OneCall sendInteractionCall = One.sendInteraction(sendInteractionRequest);
    sendInteractionCall.enqueue(new OneCallback() {
      @Override
      public void onSuccess(OneResponse response) {
        One.processResponse(response);
        result.success(response.getHttpStatusCode());
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
