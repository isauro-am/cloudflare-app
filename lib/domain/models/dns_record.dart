// To parse this JSON data, do
//
//     final dnsRecord = dnsRecordFromJson(jsonString);

import 'dart:convert';

DnsRecord dnsRecordFromJson(String str) => DnsRecord.fromJson(json.decode(str));

String dnsRecordToJson(DnsRecord data) => json.encode(data.toJson());

class DnsRecord {
    DnsRecord({
        required this.content,
        required this.name,
        required this.proxied,
        required this.type,
        required this.comment,
        required this.createdOn,
        required this.id,
        required this.locked,
        required this.meta,
        required this.modifiedOn,
        required this.proxiable,
        required this.tags,
        required this.ttl,
        required this.zoneId,
        required this.zoneName,
    });

    String content;
    String name;
    bool proxied;
    String type;
    String comment;
    DateTime createdOn;
    String id;
    bool locked;
    Meta meta;
    DateTime modifiedOn;
    bool proxiable;
    List<String> tags;
    int ttl;
    String zoneId;
    String zoneName;

    factory DnsRecord.fromJson(Map<String, dynamic> json) => DnsRecord(
        content: json["content"],
        name: json["name"],
        proxied: json["proxied"],
        type: json["type"],
        comment: json["comment"],
        createdOn: DateTime.parse(json["created_on"]),
        id: json["id"],
        locked: json["locked"],
        meta: Meta.fromJson(json["meta"]),
        modifiedOn: DateTime.parse(json["modified_on"]),
        proxiable: json["proxiable"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        ttl: json["ttl"],
        zoneId: json["zone_id"],
        zoneName: json["zone_name"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "name": name,
        "proxied": proxied,
        "type": type,
        "comment": comment,
        "created_on": createdOn.toIso8601String(),
        "id": id,
        "locked": locked,
        "meta": meta.toJson(),
        "modified_on": modifiedOn.toIso8601String(),
        "proxiable": proxiable,
        "tags": List<dynamic>.from(tags.map((x) => x)),
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
