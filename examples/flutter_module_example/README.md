## Flutter Module Example 

A flutter module example for integration with [android-add-flutter-to-existing-app-example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/android-add-flutter-to-existing-app-example) and [ios-add-flutter-to-existing-app-example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/ios-add-flutter-to-existing-app-example) example apps.  

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
* For more information on finding these parameters, see [Find the Information required when Integrating ONE with your Mobile Solutions](https://na5.thunderhead.com/one/help/conversations/how-do-i/mobile/one_integrate_mobile_find_integration_info/)

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._


### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
