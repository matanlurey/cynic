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