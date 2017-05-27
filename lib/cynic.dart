// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

final InternetAddress _googleDns = new InternetAddress('8.8.8.8');

/// Returns a future that completes with whether the internet is reachable.
///
/// You may specify a [timeout] to complete with `false` regardless.
///
/// **NOTE**: The current implementation attempts to connect to the Google DNS
/// servers as proof of internet connectivity. You will need to implement custom
/// functionality for an intranet.
Future<bool> isOnline({Duration timeout}) async {
  try {
    var result = _googleDns.reverse();
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
