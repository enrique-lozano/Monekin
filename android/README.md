# Monekin Android App

This folder contains the Android-specific code and configuration for the app. Follow these instructions to build and run the Android version of the app.

## Building for android

### Pre-requisites for building in release mode

You should add sign keys for the android project to build the app. For that, you should add two files inside `android/keys`:

- A `key.jks` with the key for the app
- A `key.properties` with the information about this key

This last file, should have the following format:

```
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=../keys/key.jks
```

### Build the apk

```
flutter build apk --release
```

After running this command, you can install the generate apk directly in your connected device by using:

```
flutter install
```

### Build the production version

```
flutter build appbundle --release
```
