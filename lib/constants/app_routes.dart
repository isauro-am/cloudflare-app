import 'package:flutter/material.dart';

import '../ui/dns_records/new_record.dart';
import '../ui/settings/set_token.dart';
import '../ui/zones/zones.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    // Routes.home: (context) => const Home(),
    Routes.account: (_) => const SetToken(),
    Routes.home: (_) => const DNSZones(),
    // Routes.dnsRecords: (context) => const DnsRecordView(),
    Routes.newDnsRecord: (_) => const NewDnsRecord()
  };
}
