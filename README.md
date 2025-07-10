# StreamDisposer

`StreamDisposer` is a Dart mixin that simplifies the management of multiple `StreamSubscription` instances. It provides methods to add subscriptions and ensures that all are properly canceled when no longer needed, preventing memory leaks and unintended behaviors.

## Features

- Add individual or multiple `StreamSubscription` instances for centralized management.
- Automatically cancel all managed subscriptions with a single `clear` method.
- Designed for easy integration into existing Dart classes.

## Getting Started

To use `StreamDisposer` in your project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  stream_disposer: ^1.0.0
```

Then, run dart pub get to fetch the package.

## Usage

Here’s how to use StreamDisposer in your Dart classes:

```dart
import 'dart:async';
import 'package:stream_disposer/stream_disposer.dart';

class MyStreamHandler with StreamDisposer {
  ...
  
  void startListening() {
    addSubscription(stream.listen((data) {
      // Handle the incoming data
    }));
  }

  void dispose() {
    // Perform any additional cleanup if necessary
    clear(); // Ensure all subscriptions are canceled
  }
}
```

### In this example:
	•	MyStreamHandler uses the StreamDisposer mixin to manage its stream subscriptions.
	•	The startListening method adds a subscription to the internal list for management.
	•	The dispose method cancels all managed subscriptions, ensuring proper resource cleanup.

## Example

For a complete example, refer to the example/ directory in the repository.

## Contributing

Contributions are welcome! Please see the contributing guidelines for more information.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
