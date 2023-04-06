import 'package:cloudflare/data/endpoints.dart';
import 'package:cloudflare/domain/models/dns_zone.dart';

import '../services/services.dart';

CloudflareZones cloudflareZones = CloudflareZones();

class CloudflareZones {
  String baseUrl = Endpoints().host;
  String version = Endpoints().version;
  String path = "zones";

  List<DnsZone> zones = [];

  getZones() async {
    zones = [];
    dynamic response = await httpRequest.getList("$baseUrl/$version/$path");

    if (response.containsKey('result')) {
      for (var element in response['result']) {
        dynamic json = {};
        try {
          json = {
            'id': element['id'],
            'name': element['name'],
            'development_mode': element['development_mode'],
            'name_servers': (element['name_servers'] == null)
                ? []
                : element['name_servers'],
            'original_name_servers': (element['original_name_servers'] == null)
                ? []
                : element['original_name_servers'],
            'original_registrar': (element['original_registrar'] == null)
                ? ''
                : element['original_registrar'].toString(),
            'original_dnshost': element['original_dnshost'],
            'modified_on': element['modified_on'],
            'created_on': element['created_on'],
            'activated_on': element['activated_on'],
            'status': element['status'],
          };
          DnsZone tmpZoneModel = DnsZone.fromJson(json);
          zones.add(tmpZoneModel);
        } catch (e) {}
      }
    }
    return zones;
  }
}
