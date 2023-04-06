import 'package:cloudflare/domain/models/dns_record.dart';
import 'package:cloudflare/domain/models/dns_zone.dart';

import '../services/services.dart';

CloudflareZones cloudflareZones = CloudflareZones();

class CloudflareZones {
  List<DnsZone> zones = [];

  getZones() async {
    zones = [];
    dynamic response = await httpRequest.getList(cloudflareUrls.zones);

    if (response.containsKey('result')) {
      for (var element in response['result']) {
        DnsZone tmpZoneModel = DnsZone.fromJson(
          {
            'id': element['id'],
            'name': element['name'],
            'status': element['status'],
            'name_servers': element['name_servers'],
            'original_name_servers': element['original_name_servers'],
            'original_registrar': element['original_registrar'],
            'original_dnshost': element['original_dnshost'],
            'created_on': element['created_on'],
            'modified_on': element['modified_on'],
            'activated_on': element['activated_on'],
            'development_mode': element['development_mode'],
            }
        );
        zones.add(tmpZoneModel);
      }
    }
    return zones;
  }
}



class CloudflareDnsRecords {

  final DnsZone activeZoneModel;

  CloudflareDnsRecords({
        required this.activeZoneModel,
    });

  List<DnsRecord> dnsRecords = [];

  getDnsRecords() async {
    activeZoneModel.dnsRecords = [];
    dynamic response = await httpRequest.getList(cloudflareUrls.dnsRecords(activeZoneModel.id));

    if (response.containsKey('result')) {
      for (var element in response['result']) {
        DnsRecord tmpZoneModel = DnsRecord.fromJson(
          {
            'id': element['id'],
            'zone_id': element['zone_id'],
            'zone_name': element['zone_name'],
            'name': element['name'],
            'type': element['type'],
            'content': element['content'],
            'proxiable': element['proxiable'],
            'proxied': element['proxied'],
            'ttl': element['ttl'],
            'created_on': element['created_on'],
            'modified_on': element['modified_on'],
            }
        );
        activeZoneModel.dnsRecords.add(tmpZoneModel);
      }
    }
  }
}
