// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';


/// Returns a future that completes with whether the internet is reachable.
///
/// You may specify a [timeout] to complete with `false` regardless.
///
/// **NOTE**: The current implementation attempts to connect to the Google DNS
/// servers as proof of internet connectivity. You will need to implement custom
/// functionality for an intranet.
Future<bool> isOnline({Duration timeout}) {
  return Reachable.googleDns.isOnline(timeout: timeout);
}

/// Returns a future that completes with whether the internet is not reachable.
///
/// See [isOnline] for full documentation.
Future<bool> isOffline({Duration timeout}) async {
  return Reachable.googleDns.isOffline(timeout: timeout);
}

/// Platform-agnostic indication of a remote service being online or offline.
abstract class Reachable {

  /// Preconfigured Google DNS is a good candidat to test online status
  static const Reachable googleDns = const Reachable.ip('8.8.8.8');

  /// A future that is true if any [services] is online.
  static Future<bool> any(Iterable<Reachable> services, {
    Duration timeout,
  }) async {
    final completer = new Completer<bool>();
    void _maybeComplete(bool isOnline) {
      if (isOnline && !completer.isCompleted) {
        completer.complete(true);
      }
    }
    final futures = services.map((s) => s.isOnline(timeout: timeout));
    for (final future in futures) {
      future.then(_maybeComplete);
    }
    Future.wait(futures).then((all) {
      completer.complete(false);
    });
    return completer.future;
  }

  /// A future that is true if all [services] are online.
  static Future<bool> all(Iterable<Reachable> services, {
    Duration timeout,
  }) async {
    return Future.wait(services.map((s) =>
        s.isOnline(timeout: timeout))).then((status) =>
        status.every((online) => online));
  }


  @visibleForOverriding
  const Reachable();

  /// Returns a service monitor for an [ipAddress].
  const factory Reachable.ip(String ipAddress, {
    String name,
    Duration timeout,
  }) = _ReachableIp;

  /// Name of the service.
  String get name;

  /// Returns a future that completes with whether this service is reachable.
  ///
  /// You may specify a [timeout] to complete with `false` regardless.
  Future<bool> isOnline({Duration timeout});

  /// Returns a future that completes with whether this service not reachable.
  ///
  /// See [Reachable.isOnline] for full documentation.
  Future<bool> isOffline({Duration timeout}) async {
    return !(await isOnline(timeout: timeout));
  }
}

class _ReachableIp extends Reachable {
  final String _ipAddress;
  final Duration timeout;

  @override
  final String name;

  const _ReachableIp(String ipAddress, {
    this.timeout,
    String name,
  })
      : _ipAddress = ipAddress,
        this.name = name ?? ipAddress;

  @override
  Future<bool> isOnline({Duration timeout}) async {
    timeout ??= this.timeout;
    try {
      var result = new InternetAddress(_ipAddress).reverse();
      if (timeout != null) {
        result = result.timeout(timeout);
      }
      await result;
      return true;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
  }
}
