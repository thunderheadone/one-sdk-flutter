## Flutter Example 

A flutter example to demonstrate how to integrate and use the Thunderhead ONE Flutter Plugin.

## Getting Started

For help getting started with Flutter, view the Flutter online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).

#### Install Flutter
In order to get started and run this example app, you'll need [Flutter](https://flutter.dev/docs/get-started/install) installed.

#### Configure the Example app 
Open [main.dart](https://github.com/thunderheadone/one-sdk-flutter/blob/1067438e6cba71215e871886cfba4b3a89f656aa/flutter_example/lib/main.dart#L48)
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

#### Install the Thunderhead ONE Flutter Plugin
From terminal, in the example app's root folder, run the following command:
```
$ flutter pub get
```

#### Run the iOS app
To run the app in:
* Terminal: Have the iOS simulator running and then run the following command:
    ```
    $ flutter run
    ```
* Xcode: navigate to the `ios` folder and open `Runner.xcworkspace`.
* A Flutter supported editor: please see https://flutter.dev/docs/get-started/editor.

For more information on running the flutter app on mobile, see the [Flutter documentation](https://flutter.dev/docs/get-started/test-drive).

#### Run the Android app
To run the app in:
* Terminal: Have the Android emulator running and run the following command:
    ```
    $ flutter run
    ```
* Android Studio: navigate to the `android` folder and open `build.gradle`.
* A Flutter supported editor: please see https://flutter.dev/docs/get-started/editor.

For more information on running the flutter app on mobile, see the [Flutter documentation](https://flutter.dev/docs/get-started/test-drive).

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._


### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
