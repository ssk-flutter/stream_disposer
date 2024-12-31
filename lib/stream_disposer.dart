import 'dart:async';
import 'package:meta/meta.dart';

mixin class StreamDisposer {
  final List<StreamSubscription> _subscriptions = [];

  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  void addSubscriptions(Iterable<StreamSubscription> subscriptions) {
    _subscriptions.addAll(subscriptions);
  }

  @mustCallSuper
  void dispose() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }
}
