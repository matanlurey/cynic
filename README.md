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
  cynic: ^0.1.2
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
final servers = const [
  const Reachable.ip('256.257.258.1', name: 'Server A'),
  const Reachable.ip('256.257.258.2', name: 'Server B'),
  const Reachable.ip('256.257.258.3', name: 'Server C'),
];

main() async {
  print(await Reachable.allOnline(servers));
}
```
