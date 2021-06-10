## Flutter Module Example 

This example project is a duplicate of [flutter_example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_example) but configured as a Flutter module for integration with [android-add-flutter-to-existing-app-example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/android-add-flutter-to-existing-app-example) and [ios-add-flutter-to-existing-app-example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/ios-add-flutter-to-existing-app-example) native example apps.  

### Configure Thunderhead SDK in Flutter Module
Open the module's [main.dart](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_module_example/lib/main.dart#L48)
to initialize the SDK using the integration parameters specific to your ONE environment.

```java
  final String SITE_KEY = "ONE-XXXXXXXXXX-1022";
  final String TOUCHPOINT = "myAppsNameURI";
  final String API_KEY = "f713d44a-8af0-4e79-ba7e-xxxxxxxxx";
  final String SHARED_SECRET = "bb8bacb2-ffc2-4c52-aaf4-xxx";
  final String USER_ID = "yourUsername@yourCompanyName"; // when integrating with Interaction Studio use a numeric user id - see https://eu2.thunderhead.com/one/help/interaction-studio/how-do-i/mobile/one_integrate_mobile_find_integration_info/#username-user-id
  final String HOST = "https://xx.thunderhead.com";
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
    
* For more information on finding these parameters, see [Find the Information required when Integrating ONE with your Mobile Solutions](https://na5.thunderhead.com/one/help/conversations/how-do-i/mobile/one_integrate_mobile_find_integration_info/)

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._

### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
