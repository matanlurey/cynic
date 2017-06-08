# cynic

Utilities for offline-first development.

**Warning**: This is not an official Google or Dart project.

* [Usage](#usage)
* [Determine online status](#determine-online-status)

## Usage

_This library works in [Flutter][] and the standalone [Dart VM][]._

[Flutter]: https://flutter.io
[Dart VM]: https://www.dartlang.org/dart-vm/tools/dart-vm

```
dependencies:
  cynic: ^0.2.0
```

### Determine online status

```dart
import 'package:cynic/cynic.dart';

main() async {
  print('Connected: ${await isOnline()}');
}
```

### Create and monitor a list of reachable services

```dart
import 'package:cynic/cynic.dart';

final microServices = const [
  Reachable.googleDns, // 99.9% uptime helper
  const Reachable.ip('172.217.19.227', name: 'My API Server'),
];

final mirrors = const [
  const Reachable.ip('216.58.204.131', name: 'My CDN A'),
  const Reachable.ip('5.5.5.5', name: 'My CDN B'), // not online
];

main() async {

  var all = await Reachable.all(microServices);
  if (all)
    print('All servers are online');

  var any = await Reachable.any(mirrors);
  if (any)
    print('At least one server is online');

}
```
