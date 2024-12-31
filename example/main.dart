import 'dart:async';
import 'package:stream_disposer/stream_disposer.dart';

class MyStreamHandler with StreamDisposer {
  void startListening(Stream<int> stream) {
    // add a single subscription
    addSubscription(
      stream.listen((data) {
        print('Data: $data');
      }),
    );

    // add multiple subscriptions
    addSubscriptions([
      stream.listen((data) {
        print('Data1: $data');
      }),
      stream.listen((data) {
        print('Data2: $data');
      }),
    ]);
  }

  @override
  void dispose() {
    // Perform any additional cleanup if necessary
    super.dispose(); // Ensure all subscriptions are canceled
  }
}

void main() {
  final myStreamHandler = MyStreamHandler();
  final stream =
      Stream<int>.periodic(const Duration(seconds: 1), (count) => count);

  myStreamHandler.startListening(stream);

  // Wait for 5 seconds
  Future.delayed(const Duration(seconds: 5), () {
    myStreamHandler.dispose();
  });
}
