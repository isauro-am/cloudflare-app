import 'package:flutter/material.dart';

import '../../data/api_dns_records.dart';
import '../../data/api_zones.dart';
import '../../data/secure_storage.dart';
import '../../domain/models/dns_zone.dart';
import '../../services/services.dart';
import '../../utils.dart';
import '../drawer/drawer.dart';

class DNSZones extends StatefulWidget {
  final DnsZone activeZone;
  const DNSZones({Key? key, required this.activeZone}) : super(key: key);

  @override
  State<DNSZones> createState() => _DNSZonesState();
}

class _DNSZonesState extends State<DNSZones> {
  String title = 'DNS Zones';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: cloudflareDrawer(context),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<dynamic>(
              future: getProjectDetails(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> widgetList;

                if (snapshot.hasData) {
                  widgetList = dnsZoneTiles(snapshot, context, widget.activeZone);

                  widgetList.add(Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10)));
                } else if (snapshot.hasError) {
                  widgetList = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('- Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  widgetList = <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting DNS Zones results...'),
                    )
                  ];
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widgetList,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

dnsZoneTiles(snapshot, BuildContext context, DnsZone activeZoneModel) {
  List<Widget> widgetList = <Widget>[];

  for (var item in snapshot.data) {
    widgetList.add(
      ListTile(
        title: Text(item.name),
        leading: Icon(
          Icons.dns,
          size: 20.0,
          color: (item.status == "active")
              ? cloudflareColors.activeIcon
              : cloudflareColors.noActiveIcon,
        ),
        onTap: () async {
          activeZoneModel = item;

          CloudflareDnsRecords cloudflareDnsRecords =
              CloudflareDnsRecords(activeZoneModel: activeZoneModel);

          await cloudflareDnsRecords.getDnsRecords();

          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, pageRoutes.dnsRecords);
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



Future getProjectDetails() async {
  cloudflareZones.zones = [];
  if (await tokenDefined()) {
    List<DNSZones> zones = await cloudflareZones.getZones();
    return zones;
  } else {
    // Return empty Dns Zone list
    return cloudflareZones.zones;
  }
}
