## 0.2.0

- Rename `Service` to `Reachable`.
- Expose the default service as `Reachable.googleDns`.
- Added `Reachable.any|all`.

## 0.1.1

- Added a `Service` class, that represents something online or offline:

```dart
final servers = const [
  const Service.ipAddress('256.257.258.1', name: 'Server A'),
  const Service.ipAddress('256.257.258.2', name: 'Server B'),
  const Service.ipAddress('256.257.258.3', name: 'Server C'),
];

main() async {
  print(await Service.allOnline(servers));
}
```

## 0.1.0

- Initial commit with the `isOnline()` method:

```dart
import 'package:cynic/cynic.dart';

main() async {
  print('Connected: ${await isOnline()}');
}
```
