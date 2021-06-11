## Android Add Flutter to App Example 
An example app that adds the [flutter_module_example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_module_example) Flutter project to demonstrate how to add a Flutter module to an existing Android app with the Thunderhead ONE Flutter Plugin.

To get started and run this example app, [Flutter](https://flutter.dev/docs/get-started/install) installation is required.

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).

## Requirements
* Flutter Version: v1.22.0+ (stable). 
* *Note:* We are in the process of adding Flutter v2.0.0+. If you have already updated to Flutter v2.0.0 and require immediate support please reach out to us via our support portal.

## Table of Contents 
* [Getting Started](#getting-started)
    * [Initialize the Flutter Module](#initialize-the-flutter-module)
    * [Configure the ONE SDK](#configure-the-one-sdk)
        * [#1: Configure SDK in Flutter Module](#1-configure-sdk-in-flutter-module)
        * [#2: Configure SDK in Android](#2-configure-sdk-in-android)
    * [Run the Android app](#run-the-android-app)
* [Questions or need help](#questions-or-need-help)
    * [Thunderhead ONE Support](#thunderhead-one-support)
    * [Salesforce Interaction Studio Support](#salesforce-interaction-studio-support)

## Getting Started

### Initialize the Flutter Module
In Terminal, navigate to [`flutter_module_example`](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_module_example/) folder and run the following command:
```
$ flutter pub get
```

### Configure the ONE SDK 
Now, with the ability to integrate Flutter piecewise within a native app, you can now configure the SDK in two places. 

#### #1: Configure SDK in Flutter Module
Open the module's [`main.dart`](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_example/lib/main.dart#L48)
to initialize the SDK using the integration parameters specific to your ONE environment.

```java
  final String SITE_KEY = "ONE-XXXXXXXXXX-1022";
  final String TOUCHPOINT = "myAppsNameURI";
  final String API_KEY = "f713d44a-8af0-4e79-ba7e-xxxxxxxxx";
  final String SHARED_SECRET = "bb8bacb2-ffc2-4c52-aaf4-xxx";
  final String USER_ID = "yourUsername@yourCompanyName"; // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
  final String HOST = "https://xx.thunderhead.com";
```

#### #2: Configure SDK in Android
Open [`ThunderheadApplication.kt`](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/android-add-flutter-to-existing-app-example/app/src/main/java/com/thunderhead/addfluttertoexistingappexample/ThunderheadApplication.kt)
to initialize the SDK using the integration parameters specific to your ONE environment.

```kotlin
import com.thunderhead.android.api.oneConfigure
import com.thunderhead.OneModes;
// The rest of the imports

class ThunderheadApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        oneConfigure {
            siteKey = SITE_KEY
            apiKey = API_KEY
            sharedSecret = SHARED_SECRET
            userId = USER_ID
            host = URI(HOST)
            touchpoint = URI(TOUCHPOINT)
            mode = OneModes.USER_MODE
        }
    }
    
    companion object {
        const val SITE_KEY = "ONE-XXXXXXXXXX-1022"
        const val API_KEY = "f713d44a-8af0-4e79-ba7e-xxxxxxxxx"
        const val SHARED_SECRET = "bb8bacb2-ffc2-4c52-aaf4-xxx"
        const val USER_ID = "yourUsername@yourCompanyName" // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
        const val HOST = "https://xx.thunderhead.com"
        const val TOUCHPOINT = "myAppsNameURI"
    }
}
```

* The configuration parameters include:
    * `Site Key` (for your specific Space)
    * `Touchpoint URI`
        * The native Thunderhead SDK will automatically prefix the URI scheme (i.e. android:// and ios://) when it is omitted. 
            * i.e. “optimization-example”
        * If you want to configure under a single Touchpoint, you can explicitly prefix your URI scheme 
            * i.e. “ionic://optimization-example”
    * `API Key` & `Shared Secret` (required for OAuth 1.0 authentication)
    * `Username/User ID` (required for OAuth 1.0 authentication)
    * `Host name`. 
        * Typically, this is https://na5.thunderhead.com or https://eu2.thunderhead.com.
    * `Admin Mode`
        * Admin mode (adminMode = true) provides you with an interface that lets you add Interaction Points, Activity Capture Points, and Attribute Capture Points to native UI elements within the app.  However, hybrid apps do not support this feature because hybrid solutions typically use  non-native UI elements .  Only preview mode is supported to view your unpublished (In the Works) configuration before publishing it to your live environment.
            * The Admin mode build should only be distributed internally to business users involved in ONE setup. This is your internal dev build.
    * `User Mode` (adminMode = false) User mode build should be used for production builds, when you are satisfied that all insights are being tracked in Admin mode and internal QA requirements have been met.

* For more information, [Find the Information required when Integrating ONE with your Mobile App](https://na5.thunderhead.com/one/help/conversations/how-do-i/mobile/one_integrate_mobile_find_integration_info/)

### Run the Android app
Navigate to the example app folder and open `build.gradle` in Android Studio, then build and run the app.

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._

### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
