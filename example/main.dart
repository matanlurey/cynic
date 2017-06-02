import 'package:cynic/cynic.dart';

final servers = const [
  Reachable.googleDns,
  const Reachable.ip('192.168.1.67', name: 'Server A'),
];

main() async {
  var online = await Reachable.allOnline(servers);
  if (online)
    print('Alive');

  return online;
}