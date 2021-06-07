## iOS Add Flutter to App Example 
An example app that adds the [flutter_example](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_example) Flutter project to demonstrate how to add a Flutter module to an existing iOS app with the Thunderhead ONE Flutter Plugin.

## Getting Started
For help getting started with Flutter, view the Flutter online [documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).

### Flutter installation
In order to get started and run this example app, you'll need [Flutter](https://flutter.dev/docs/get-started/install) installed.

## Configure the ONE SDK 
Now, with the ability to integrate Flutter piecewise within a native app, you can now configure the SDK in two places. 

### Configure SDK in Flutter Module
Open [main.dart](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/flutter_example/lib/main.dart#L48)
to initialize the SDK using the integration parameters specific to your ONE environment.

```java
  final String SITE_KEY = "ONE-XXXXXXXXXX-1022";
  final String TOUCHPOINT = "myAppsNameURI";
  final String API_KEY = "f713d44a-8af0-4e79-ba7e-xxxxxxxxx";
  final String SHARED_SECRET = "bb8bacb2-ffc2-4c52-aaf4-xxx";
  final String USER_ID = "yourUsername@yourCompanyName";
  final String HOST = "https://xx.thunderhead.com";
```

### Configure SDK in iOS
Open [AppDelegate.swift](https://github.com/thunderheadone/one-sdk-flutter/blob/master/examples/ios-add-flutter-to-existing-app-example/os-add-flutter-to-existing-app-example/Add%20Flutter%20to%20Existing%20App%20Example/AppDelegate.swift#L26)
to initialize the SDK using the integration parameters specific to your ONE environment.

```swift
One.startSessionWithSK(
    "ONE-XXXXXXXXXX-1022",
    uri:"myAppsNameURI",
    apiKey:"f713d44a-8af0-4e79-ba7e-xxxxxxxxxxxxxxxx",
    sharedSecret:"bb8bacb2-ffc2-4c52-aaf4-xxxxxxxxxxxxxxxx",
    userId:"api@yourCompanyName",
    adminMode:false,
    hostName:"eu2.thunderhead.com"
)
```
* For more information on finding these parameters, see [Find the Information required when Integrating ONE with your Mobile Solutions](https://na5.thunderhead.com/one/help/conversations/how-do-i/mobile/one_integrate_mobile_find_integration_info/)

## Install Pod Dependencies
From terminal, in the example app folder, run the following command:
```
$ pod install
```

## Run the iOS app
Navigate to the example app folder and open `Add Flutter to Existing App Example.xcworkspace` in Xcode, then build and run the app.

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._


### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_