
import '../domain/models/dns_record.dart';
import '../domain/models/dns_zone.dart';
import '../services/services.dart';
import 'endpoints.dart';

class CloudflareDnsRecords {
  String baseUrl = Endpoints().host;
  String version = Endpoints().version;

  String path = "dns_records";

  final DnsZone activeZoneModel;

  CloudflareDnsRecords({
        required this.activeZoneModel,
    });

  List<DnsRecord> dnsRecords = [];

  getDnsRecords() async {
    activeZoneModel.dnsRecords = [];
    dynamic response = await httpRequest.getList("$baseUrl/$version/$path?zone_id=${activeZoneModel.id}");
    // $zones/$zoneIdentifier/dns_records"

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