import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../data/api_dns_records.dart';
import '../../data/api_zones.dart';
import '../../data/secure_storage.dart';
import '../../ui/dns_records/records.dart';
import '../models/dns_zone.dart';

dnsZoneTiles(snapshot, BuildContext context) {
  List<Widget> widgetList = <Widget>[];

  for (DnsZone item in snapshot.data) {
    widgetList.add(
      ListTile(
        title: Text(item.name),
        leading: Icon(
          Icons.dns,
          size: 20.0,
          color: (item.status == "active")
              ? CloudflareColors.activeIcon
              : CloudflareColors.noActiveIcon,
        ),
        onTap: () async {
          CloudflareDnsRecords cloudflareDnsRecords =
              CloudflareDnsRecords(activeZoneModel: item);

          item.dnsRecords = await cloudflareDnsRecords.getDnsRecords();

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DnsRecordView(
                activeZone: item,
              ),
            ),
          );
        },
      ),
    );
  }

  if (widgetList.isEmpty) {
    return [
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Not exist any DNS Zone Records'),
      )
    ];
  } else {
    return widgetList;
  }
}

/// This function retrieves a list of active DNS zones from Cloudflare.
///
/// Returns:
///   This function is returning a `Future` object that will eventually resolve to a list of `DnsZone`
/// objects. If the `tokenDefined()` function returns `true`, the function will call
/// `cloudflareZones.getZones()` to retrieve a list of DNS zones from Cloudflare and return it. If
/// `tokenDefined()` returns `false`, an empty list of `DnsZone` objects
Future getActiveZones({bool update = false}) async {
  if (update) {
    cloudflareZones.zones = [];
  }
  if (await tokenDefined() && cloudflareZones.zones.isEmpty) {
    List<DnsZone> zones = await cloudflareZones.getZones();
    return zones;
  } else {
    // Return empty Dns Zone list
    return cloudflareZones.zones;
  }
}
