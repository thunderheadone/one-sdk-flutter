# one_sdk_flutter

The ONE SDK Flutter Plugin for iOS and Android.

## Installation
To install the ONE Flutter Plugin, go to your `pubspec.yaml` and add the dependency:
```
one_sdk_flutter:
  git:
    url: https://github.com/thunderheadone/one-sdk-ios.git
    path: one_sdk_flutter
```
* See example [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/flutter_example/pubspec.yaml#L23)

## Usage
### Initialization
To initialize the ONE Flutter Plugin, call the following method:
```javascript
OnePlugin.initializeOne(SITE_KEY, TOUCHPOINT, API_KEY, SHARED_SECRET, USER_ID, HOST, false);
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/flutter_example/lib/main.dart#L58)

### Send an Interaction 
To send an Interaction request without properties, call the following method:
```javascript
One.sendInteraction("/interactionPath");
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/flutter_example/lib/main.dart#L60)

To send an Interaction request with properties, call the following method:
```javascript
OnePlugin.sendProperties("/interactionPath", { 'key' : 'value' });
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/flutter_example/lib/main.dart#L128)

### Access debug information
To configure logging, call the following method:
```javascript
OnePlugin.setThunderheadLogLevel(true);
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/flutter_example/lib/main.dart#L59)

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._

### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
