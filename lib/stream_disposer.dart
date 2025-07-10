import 'dart:async';
import 'package:meta/meta.dart';

/// A mixin that provides functionality to manage and dispose multiple
/// [StreamSubscription] instances.
///
/// This mixin allows you to add subscriptions to a list and ensures that all
/// subscriptions are canceled when [clear] is called, preventing memory leaks
/// and unintended behaviors.
mixin class StreamDisposer {
  /// A list that holds all active [StreamSubscription] instances.
  final List<StreamSubscription> _subscriptions = [];

  /// Returns the number of active [StreamSubscription] instances.
  @visibleForTesting
  int get subscriptionCount => _subscriptions.length;

  /// Adds a [StreamSubscription] to the internal list for management.
  ///
  /// This method registers a single subscription to be managed. The subscription
  /// will be canceled when [clear] is invoked.
  ///
  /// ```dart
  /// class MyClass with StreamDisposer {
  ///   void initialize(Stream stream) {
  ///     var subscription = stream.listen((event) {
  ///       // Handle event
  ///     });
  ///     addSubscription(subscription);
  ///   }
  ///
  ///   @override
  ///   void dispose() {
  ///     super.dispose();
  ///   }
  /// }
  /// ```
  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }

  /// Adds multiple [StreamSubscription] instances to the internal list for management.
  ///
  /// This method registers multiple subscriptions to be managed. All subscriptions
  /// will be canceled when [clear] is invoked.
  ///
  /// ```dart
  /// class MyClass with StreamDisposer {
  ///   void initialize(List<Stream> streams) {
  ///     var subscriptions = streams.map((stream) => stream.listen((event) {
  ///       // Handle event
  ///     }));
  ///     addSubscriptions(subscriptions);
  ///   }
  ///
  ///   @override
  ///   void dispose() {
  ///     super.dispose();
  ///   }
  /// }
  /// ```
  void addSubscriptions(Iterable<StreamSubscription> subscriptions) {
    _subscriptions.addAll(subscriptions);
  }

  /// Cancels all managed [StreamSubscription] instances and clears the list.
  ///
  /// This method ensures that all subscriptions added via [addSubscription] or
  /// [addSubscriptions] are canceled to prevent memory leaks. Subclasses that
  /// override [clear] must call `super.dispose()` to ensure proper cancellation.
  ///
  /// ```dart
  /// class MyClass with StreamDisposer {
  ///   void dispose() {
  ///     // Perform additional cleanup if necessary
  ///     clear();
  ///   }
  /// }
  /// ```
  @mustCallSuper
  void clear() {
    final subscriptions = List.from(_subscriptions);
    _subscriptions.clear();

    for (var subscription in subscriptions) {
      subscription.cancel();
    }
  }
}