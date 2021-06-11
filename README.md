# one-sdk-flutter

The Thunderhead ONE SDK Flutter Plugin for iOS and Android.

## Examples
Check out the [examples](https://github.com/thunderheadone/one-sdk-flutter/tree/master/examples/) folder to see integration examples.

## Installation
To install the Thunderhead ONE Flutter Plugin, go to your `pubspec.yaml` and add the dependency:
```
one_sdk_flutter:
  git:
    url: https://github.com/thunderheadone/one-sdk-flutter.git
```
* See example [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/examples/flutter_example/pubspec.yaml#L23)

### Disable automatic Interaction detection
By disabling automatic Interaction detection, the SDK will no longer automatically send Interaction requests as native iOS `View Controllers` or Android `Activities` or `Fragments` are presented on screen. 

It is recommended to disable automatic Interaction detection in Flutter applications as the SDK does not recognize Flutter or web view elements, so it becomes your responsibility to send them when needed by using the [send Interaction](#send-an-interaction) methods outlined below.  

For native applications where only a part of the app uses [Flutter](https://flutter.dev/docs/development/add-to-app), you may want to ignore disabling automatic Interaction detection to automatically detect native Interactions.

You can disable automatic Interaction detection by calling the method `disableAutomaticInteractionDetection:` and passing `true` as a parameter, as shown below:

```swift
// Swift
One.disableAutomaticInteractionDetection(true)
// https://github.com/thunderheadone/one-sdk-ios#disable-automatic-interaction-detection
```

```kotlin
// Kotlin
oneConfigureCodelessInteractionTracking {
    // disables Fragment/Activity Interaction Tracking
    disableCodelessInteractionTracking = true 
}
// https://github.com/thunderheadone/one-sdk-android#disable-automatic-interaction-detection
```

An appropriate place to call the method might be under `didFinishLaunchingWithOptions` in your `AppDelegate` for iOS or under `onCreate` in your `Application` class for Android.

You can set this back to `false` at any point to restart automatic Interaction detection.

## Usage
### Initialization
To initialize the ONE Flutter Plugin, call the following method:
```dart
import 'package:one_sdk_flutter/one_sdk_flutter.dart';

One.initializeOne(SITE_KEY, TOUCHPOINT, API_KEY, SHARED_SECRET, USER_ID, HOST, false);
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/examples/flutter_example/lib/main.dart#L58)

### Send an Interaction 
To send an Interaction request without properties, call the following method:
```dart
One.sendInteraction("/interactionPath", null);
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/examples/flutter_example/lib/main.dart#L60)

To send an Interaction request with properties, call the following method:
```dart
One.sendInteraction("/interactionPath", { 'key' : 'value' });
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/examples/flutter_example/lib/main.dart#L128)

### Access debug information
To configure logging, call the following method:
```dart
One.setThunderheadLogLevel(true);
```
* See example of usage [here](https://github.com/thunderheadone/one-sdk-flutter/tree/master/examples/flutter_example/lib/main.dart#L59)

## Questions or need help

### Thunderhead ONE Support
_The Thunderhead team is available 24/7 to answer any questions you have. Just email onesupport@thunderhead.com or visit our docs page for more detailed installation and usage information._

### Salesforce Interaction Studio Support
_For Salesforce Marketing Cloud Interaction Studio questions, please submit a support ticket via https://help.salesforce.com/home_
