// To parse this JSON data, do
//
//     final dnsRecord = dnsRecordFromJson(jsonString);

import 'dart:convert';

DnsRecord dnsRecordFromJson(String str) => DnsRecord.fromJson(json.decode(str));

String dnsRecordToJson(DnsRecord data) => json.encode(data.toJson());

class DnsRecord {
    DnsRecord({
        required this.id,
        required this.zoneId,
        required this.zoneName,
        required this.name,
        required this.type,
        required this.content,
        required this.proxiable,
        required this.proxied,
        required this.ttl,
        required this.createdOn,
        required this.modifiedOn,
    });

    String content;
    String name;
    bool proxied;
    String type;
    DateTime createdOn;
    String id;
    DateTime modifiedOn;
    bool proxiable;
    int ttl;
    String zoneId;
    String zoneName;

    factory DnsRecord.fromJson(Map<String, dynamic> json) => DnsRecord(
        content: json["content"],
        name: json["name"],
        proxied: json["proxied"],
        type: json["type"],
        createdOn: DateTime.parse(json["created_on"]),
        id: json["id"],
        modifiedOn: DateTime.parse(json["modified_on"]),
        proxiable: json["proxiable"],
        ttl: json["ttl"],
        zoneId: json["zone_id"],
        zoneName: json["zone_name"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "name": name,
        "proxied": proxied,
        "type": type,
        "created_on": createdOn.toIso8601String(),
        "id": id,
        "modified_on": modifiedOn.toIso8601String(),
        "proxiable": proxiable,
        "ttl": ttl,
        "zone_id": zoneId,
        "zone_name": zoneName,
    };
}

class Meta {
    Meta({
        required this.autoAdded,
        required this.source,
    });

    bool autoAdded;
    String source;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        autoAdded: json["auto_added"],
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "auto_added": autoAdded,
        "source": source,
    };
}
