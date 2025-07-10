import 'dart:async';

import 'package:stream_disposer/stream_disposer.dart';
import 'package:test/test.dart';

class MockStreamSubscription implements StreamSubscription {
  bool _isCanceled = false;
  bool get isCanceled => _isCanceled;

  @override
  Future<void> cancel() {
    _isCanceled = true;
    return Future.value();
  }

  @override
  Future<E> asFuture<E>([E? futureValue]) {
    throw UnimplementedError();
  }

  @override
  bool get isPaused => throw UnimplementedError();

  @override
  void onData(void Function(dynamic data)? handleData) {
    throw UnimplementedError();
  }

  @override
  void onDone(void Function()? handleDone) {
    throw UnimplementedError();
  }

  @override
  void onError(Function? handleError) {
    throw UnimplementedError();
  }

  @override
  void pause([Future<void>? resumeSignal]) {
    throw UnimplementedError();
  }

  @override
  void resume() {
    throw UnimplementedError();
  }
}

class TestStreamDisposer with StreamDisposer {}

void main() {
  group('StreamDisposer', () {
    late TestStreamDisposer disposer;

    setUp(() {
      disposer = TestStreamDisposer();
    });

    test('addSubscription cancels a single subscription on clear()', () {
      final mockSubscription = MockStreamSubscription();
      disposer.addSubscription(mockSubscription);
      expect(mockSubscription.isCanceled, isFalse);

      disposer.clear();
      expect(mockSubscription.isCanceled, isTrue);
      expect(disposer.subscriptionCount, 0);
    });

    test('addSubscriptions cancels multiple subscriptions on clear()', () {
      final mockSubscription1 = MockStreamSubscription();
      final mockSubscription2 = MockStreamSubscription();
      final mockSubscription3 = MockStreamSubscription();

      disposer.addSubscriptions([mockSubscription1, mockSubscription2, mockSubscription3]);
      expect(mockSubscription1.isCanceled, isFalse);
      expect(mockSubscription2.isCanceled, isFalse);
      expect(mockSubscription3.isCanceled, isFalse);

      disposer.clear();
      expect(mockSubscription1.isCanceled, isTrue);
      expect(mockSubscription2.isCanceled, isTrue);
      expect(mockSubscription3.isCanceled, isTrue);
      expect(disposer.subscriptionCount, 0);
    });

    test('clear() handles empty subscriptions list gracefully', () {
      expect(() => disposer.clear(), returnsNormally);
      expect(disposer.subscriptionCount, 0);
    });

    test('addSubscription adds to the list', () {
      final mockSubscription = MockStreamSubscription();
      disposer.addSubscription(mockSubscription);
      expect(disposer.subscriptionCount, 1);
    });

    test('addSubscriptions adds to the list', () {
      final mockSubscription1 = MockStreamSubscription();
      final mockSubscription2 = MockStreamSubscription();
      disposer.addSubscriptions([mockSubscription1, mockSubscription2]);
      expect(disposer.subscriptionCount, 2);
    });
  });
}
