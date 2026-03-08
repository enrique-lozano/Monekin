# Running the Code Locally 🧑‍💻🚀

Monekin is fully open-source, allowing you to run it locally on your device. Whether you’re curious about how the app works, planning to contribute, or simply exploring, this guide provides all the steps to get started.

## Prerequisites 🛠️

Before running Monekin, ensure you have the following tools installed:

1. **Flutter SDK**: Follow the [official installation guide](https://docs.flutter.dev/get-started/install) to set up Flutter on your system.
2. **Code Editor (Optional)**: Tools like [Visual Studio Code](https://code.visualstudio.com/) or Android Studio make managing Flutter projects easier.

## Getting the Project 📂

You can choose one of two ways to obtain the project:

### Option 1: Download as ZIP File (No Git Required)

1. Go to the [Monekin GitHub Repository](https://github.com/enrique-lozano/Monekin).
2. Click the green **Code** button, then select **Download ZIP**.
3. Extract the ZIP file to a folder of your choice.

### Option 2: Clone the Repository (Recommended for Contributors)

1. Open a terminal in the folder where you want the project.
2. Run the following command:

   ```bash
   git clone https://github.com/enrique-lozano/Monekin.git
   ```

## Installing Dependencies 📦

Once you’ve downloaded or cloned the project, navigate to the project directory and install the required dependencies using Flutter:

```bash
# Install dependencies:
flutter pub get

# Retrieve translations
dart run slang
```

## Running the App ▶️

With the setup complete, you can run the app on a connected device or an emulator:

```bash
flutter run
```

If everything is set up correctly, the app will launch, and you’ll be able to test its features locally.

## Building Your Custom App 🏗️

Monekin’s open-source nature allows you to create your own customized version of the app for your device. In each of the supported OS directories of this repository (`/android`, `/windows`...), you can find documentation detailing how to build the app yourself.

These guides include all the necessary steps to configure, build, and deploy the app tailored to your platform.

---

## Tips for Contributing 🤝

If you’re interested in contributing to Monekin, consider using the Git-based setup and check out our [Code Contribution Guide](https://github.com/enrique-lozano/Monekin/blob/main/docs/CODE_CONTRIBUTING.md). It includes coding standards, tips, and guidelines for submitting pull requests.
