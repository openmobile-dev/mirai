---
sidebar_position: 2
---

# How to use Mirai?

Now that you have successfully installed Mirai, let's dive into how you can use it to build dynamic, server-driven UIs in your Flutter project.

## 1. Import the Mirai package

To start using Mirai, you need to import the package in your Dart file. Add the following import statement to your `main.dart`:

```dart
import 'package:mirai/mirai.dart';
```

This import allows you to access all the classes and functions provided by Mirai.

## 2. Initialize Mirai

In the `main` function, initialize Mirai to set up the necessary configurations and prepare your app for rendering UI from JSON.

### Basic Initialization
```dart
void main() async {
  await Mirai.initialize();
  runApp(const MyApp());
}
```

### Initialization with Custom Parsers and Dio Instance
If you need to use custom parsers or a Dio instance for HTTP requests, specify them during initialization:

```dart
void main() async {
  final dio = Dio();

  await Mirai.initialize(
    parsers: const [
      ExampleParser(),
    ],
    dio: dio,
  );

  runApp(const MyApp());
}
```

## 3. Use Mirai to Render UI

You can use `Mirai.fromJson` to load and render the UI from a JSON object. Here’s how you can integrate it into your Flutter app:

### Rendering UI from JSON Object
```dart
import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';

void main() async {
  await Mirai.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiraiDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mirai.fromJson(json, context),
    );
  }
}
```

### Rendering UI from JSON File in Assets

You can also use `Mirai.fromAssets` to load and render the UI from a JSON file stored in the assets folder:

```dart
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'MiraiDemo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Mirai.fromAsset('assets/ui.json', context),
  );
}
```

### Rendering UI from Network

Alternatively, use the `Mirai.fromNetwork` method to load and render the UI from a JSON file stored on a server:

```dart
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'MiraiDemo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Mirai.fromNetwork(
      request: MiraiNetworkRequest(
        url: 'https://example.com/ui.json',
      ), 
      context: context,
    ),
  );
}
```

By following these steps, you can effectively integrate Mirai into your Flutter project and start building dynamic, server-driven UIs. For more detailed examples and advanced usage, refer to the [Mirai Gallery App](https://github.com/Securrency-OSS/mirai/tree/dev/examples/mirai_gallery).