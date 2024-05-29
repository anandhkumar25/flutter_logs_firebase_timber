<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

FlutterLogsFirebaseTimber is a logging package for Flutter, similar to Android's Timber. This package allows you to track logs both locally and remotely using Firebase Realtime Database.

## Features

- Track logs remotely and locally.
- Monitor application logs in the Firebase console.
- Easy to use.
- Realtime database screenshot:

![Realtime firebase logs](https://github.com/anandhkumar25/flutter_logs_firebase_timber/blob/main/screenshots/flutter_logs_firebase_timber.png?raw=true)


## Getting started

Add the package to your pubspec.yaml file:
```dart
  flutter_logs_firebase_timber: ^0.0.3
```

## Firebase Setup

- Create a Firebase project in the [Firebase console](https://console.firebase.google.com).
- Register your app by clicking the Flutter icon in the Project Overview section.
- Follow the given instructions for CLI setup.

## A. Configure Firebase Realtime Database rules for public read and write access:

1. Select your Firebase project.
2. Navigate to Realtime Database:
- Click on "Build" in the left-hand menu, then select "Realtime Database".
3. Open the Rules Tab:
- Click on the "Rules" tab in the Realtime Database section.
4. Set Public Read and Write Access:
- Replace the existing rules with the following code to allow public read and write access. Note that setting public access is generally not recommended for production applications due to security risks. Use this configuration only for testing or development purposes.

{

  "rules": {

    ".read": "true",

    ".write": "true"

  }

}

5. Click the "Publish" button to apply the changes.

## Important Note:
- Setting .read and .write to true allows anyone with the database URL to read and write data, posing significant security risks. For production environments, implement proper security rules to protect your data. For example, allow access only to authenticated users:

{

  "rules": {

    ".read": "auth != null",

    ".write": "auth != null"

  }

}

## Example

Asynchronously initializes the logging system by setting up the DeviceInfo and LogsTree. This should be done before the app starts running to ensure that all logs are captured from the beginning.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialze the package only for debug mode
  if (kDebugMode) {
    await FlutterLogsFirebaseTimber.initialize();
  }
  runApp(const MyApp());
}
```

## Usage

This is a static method call to the log function of the FlutterLogsFirebaseTimber class providing functionality to send log messages to a logging service like Firebase.

```dart
FlutterLogsFirebaseTimber.log(
                logLevel: LogLevel.info,
                tag: "onPressed()",
                message: "This is a log message",
                error: null)
```

## Additional information

We hope you find FlutterLogsFirebaseTimber useful!
