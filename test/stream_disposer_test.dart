import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:stream_disposer/stream_disposer.dart';

class MockObject with StreamDisposer {
  void onStreamListen(void Function(int) onData) {
    final streamSubscription =
        Stream<int>.periodic(const Duration(seconds: 1), (int count) => count)
            .listen(onData);
    addSubscription(streamSubscription);
  }
}

void main() {
  test('adds one to input values', () {
    final mockObject = MockObject();

    mockObject.onStreamListen((int count) {
      print('count: $count');
    });

    mockObject.dispose();

  });
}
