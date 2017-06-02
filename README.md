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
  cynic: ^0.1.4
```

### Determine online status

```dart
import 'package:cynic/cynic.dart';

main() async {
  print('Connected: ${await isOnline()}');
}
```

### Create and monitor a list of Reachables

```dart
import 'package:cynic/cynic.dart';

final microservices = const [
  Reachable.googleDns,
  Reachable.googleDns,
];

final mirrors = const [
  Reachable.googleDns,
  const Reachable.ip('1.1.1.2', name: 'Server A'),
];

main() async {

  var all = await Reachable.allOnline(microservices);
  if (all) print('All servers are online');

  var any = await Reachable.anyOnline(mirrors);
  if (any) print('At least one server is online');


}
```
