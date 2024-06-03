---
slug: /
sidebar_position: 1
---

# Get Started 🚀

Welcome to Mirai, a revolutionary Server-Driven UI (SDUI) library for Flutter. Mirai empowers developers to build dynamic, cross-platform applications by utilizing JSON in real time. This innovative approach to UI development allows for flexible, efficient, and seamless updates, minimizing the need for frequent app store releases and ensuring your application always looks and feels fresh.

## Features

- **Cross-Platform**: Works everyone where flutter works.
- **Real-Time Updates**: Instant UI updates using JSON.
- **Dynamic UI**: Create and modify UIs on the fly.
- **Follows Flutter Structure**: Adheres to Flutter's architecture for building UI.
- **Flexible Integration**: Easily integrates with existing Flutter projects.
- **Open Source**: Encourages community contributions and collaboration.

## Packages

The Miraiverse consists of the following packages:

| Package | Description | Link                                                                                               |
|---------|-------------|----------------------------------------------------------------------------------------------------|
| [mirai](https://github.com/Securrency-OSS/mirai/tree/dev/packages/mirai) | The core package that provides the foundation for building server-driven UIs in Flutter. | [![pub package](https://img.shields.io/pub/v/mirai.svg)](https://pub.dev/packages/mirai)           |
| [mirai_framework](https://github.com/Securrency-OSS/mirai/tree/dev/packages/mirai_framework) | A framework that extends the functionality of the core package and provides additional features for building server-driven UIs. | [![pub package](https://img.shields.io/pub/v/mirai_framework.svg)](https://pub.dev/packages/mirai_framework) |
| [mirai_webview](https://github.com/Securrency-OSS/mirai/tree/dev/packages/mirai_webview) | A package that enables you to embed web views in your server-driven UIs. | [![pub package](https://img.shields.io/pub/v/mirai_webview.svg)](https://pub.dev/packages/mirai_webview)   |


## Installation

To get started with Mirai, follow the installation instructions below:

1. Add the Mirai dependency to your `pubspec.yaml` file:

Run this command:

```bash
flutter pub add mirai
```
This will add mirai into your package's pubspec.yaml (and run an implicit flutter pub get):

Alternatively, you can manually add the dependency to your app from within your pubspec.yaml:

```yaml
dependencies:
  mirai: ^<latest-version>
```
:::note
Please replace `<latest-version>` with the latest version of Mirai. You can find the latest version on the [Mirai pub.dev page](https://pub.dev/packages/mirai).
:::

2. Run the following command in your terminal to install the package:

```bash
flutter pub get
```

3. Import the Mirai package in your Dart file:

```dart
import 'package:mirai/mirai.dart';
```

Now, you're ready to start using Mirai in your Flutter project.





