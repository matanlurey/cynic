import 'package:cynic/cynic.dart';

final microServices = const [
  Reachable.googleDns, // 99.9% uptime helper
  const Reachable.ip('172.217.19.227', name: 'My API Server'),
];

final mirrors = const [
  //const Reachable.ip('216.58.204.131', name: 'My CDN A'),
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