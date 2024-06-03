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

This project utilizes the Timber library for efficient logging across both Android and iOS platforms. Timber provides a lightweight yet powerful logging utility that helps in managing log statements effortlessly. For enhanced remote debugging, we've integrated Firebase, which captures and posts these logs in real-time to the Firebase console. This setup allows for seamless monitoring and debugging of the application, ensuring that critical issues can be identified and resolved promptly. By leveraging Timber's logging capabilities and Firebase's robust cloud infrastructure, we achieve a reliable and scalable remote logging solution, facilitating better maintenance and quicker iterations during the development cycle.

## Features

- Efficiently track logs both remotely and locally, ensuring comprehensive monitoring and analysis capabilities.
- Seamlessly monitor application logs directly within the Firebase console, providing an integrated and streamlined user experience.
- Designed with ease of use in mind, it offers an intuitive and accessible interface for users of all technical levels.
- Realtime database screenshot:

![Realtime firebase logs](https://github.com/anandhkumar25/flutter_logs_firebase_timber/blob/main/screenshots/flutter_logs_firebase_timber.png?raw=true)


## Getting started

- Add the package to your pubspec.yaml file:
```dart
  flutter_logs_firebase_timber: ^0.0.3
```
- Run the command to fetch all the dependencies listed in your pubspec.yaml file and makes them available in your project.

```dart
flutter pub get
```

## Firebase Setup

- Create a Firebase project in the [Firebase console](https://console.firebase.google.com).
- Register your app by clicking the Flutter icon in the Project Overview section.

![Flutter project icon](https://github.com/anandhkumar25/flutter_logs_firebase_timber/blob/main/screenshots/flutter_project.png?raw=true)

- Follow the given instructions for CLI setup.

## A. Configure Firebase Realtime Database rules for public read and write access:

1. Select your Firebase project.
2. Navigate to Realtime Database:
- Click on "Build" in the left-hand menu, then select "Realtime Database".
3. Open the Rules Tab:
- Click on the "Rules" tab in the Realtime Database section.
4. Set Public Read and Write Access:
- Replace the existing rules with the following code to allow public read and write access. Note that setting public access is generally not recommended for production applications due to security risks. Use this configuration only for testing or development purposes.

```
{

  "rules": {

    ".read": "true",

    ".write": "true"

  }

}
```

5. Click the "Publish" button to apply the changes.

## Important Note:
- Setting .read and .write to true allows anyone with the database URL to read and write data, posing significant security risks. For production environments, implement proper security rules to protect your data. For example, allow access only to authenticated users:

```
{
  "rules": {

    ".read": "auth != null",

    ".write": "auth != null"

  }

}
```

## Example

Initializes the FlutterLogsFirebaseTimber package.This method should be called once during the application startup.

```dart
await RemoteLogger.initialize();
```

- To perform asynchronous operations before the runApp() method is called, such as initializing a database or fetching initial configuration settings, you should ensures that the binding between the Flutter framework and the underlying platform (such as iOS or Android) is fully initialized at the beginning of the main() function.

```dart
WidgetsFlutterBinding.ensureInitialized();
```
- Asynchronously initializes for RemoteLogger.

```dart
void main() async {
  // Ensure that the Flutter framework is initialized
  WidgetsFlutterBinding.ensureInitialized();
  //Initialze the package only for debug mode
  if (kDebugMode) {
    await RemoteLogger.initialize();
  }
  runApp(const MyApp());
}
```

## Usage

This is a static method call to the log function of the RemoteLogger class providing functionality to send log messages to a logging service on Firebase.

```dart
RemoteLogger.log(
                logLevel: LogLevel.info,
                tag: "onPressed()",
                message: "This is a log message",
                error: null)
```

## Additional information

We hope you find FlutterLogsFirebaseTimber useful!
