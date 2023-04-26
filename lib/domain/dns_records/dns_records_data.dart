import 'package:flutter/material.dart';

import '../../data/secure_storage.dart';
import '../models/dns_record.dart';
import '../models/dns_zone.dart';

dnsRecordTiles(DnsZone activeZoneModel) {
  List<Widget> widgetList = <Widget>[];

  for (DnsRecord item in activeZoneModel.dnsRecords) {
    widgetList.add(
      ListTile(
        leading: Text(item.type),
        title: Text(item.name),
        subtitle: (item.type == 'MX')
            ? Text("${item.name} ${item.content}")
            : Text(item.content),
        onTap: () async {},
      ),
    );
  }

  if (widgetList.isEmpty) {
    return [
      const Icon(
        Icons.forward,
        color: Colors.red,
        size: 60,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Not exist any Records for this DNS Zone'),
      )
    ];
  } else {
    return widgetList;
  }
}

Future getProjectDetails() async {
  return await tokenDefined();
}
