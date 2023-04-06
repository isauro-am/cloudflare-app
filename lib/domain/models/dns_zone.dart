// To parse this JSON data, do
//
//     final dnsZone = dnsZoneFromJson(jsonString);

import 'dart:convert';

import 'dns_record.dart';

DnsZone dnsZoneFromJson(String str) => DnsZone.fromJson(json.decode(str));

String dnsZoneToJson(DnsZone data) => json.encode(data.toJson());

class DnsZone {
    DnsZone({
        required this.status,
        required this.activatedOn,
        required this.createdOn,
        required this.developmentMode,
        required this.id,
        required this.modifiedOn,
        required this.name,
        required this.originalDnshost,
        required this.originalNameServers,
        required this.nameServers,
        required this.originalRegistrar,
    });

    List<DnsRecord> dnsRecords = [];

    String status;
    DateTime activatedOn;
    DateTime createdOn;
    int developmentMode;
    String id;
    DateTime modifiedOn;
    String name;
    String originalDnshost;
    List<String> originalNameServers;
    List<String> nameServers;
    String originalRegistrar;

    factory DnsZone.fromJson(Map<String, dynamic> json) => DnsZone(
        activatedOn: DateTime.parse(json["activated_on"]),
        createdOn: DateTime.parse(json["created_on"]),
        developmentMode: json["development_mode"],
        id: json["id"],
        modifiedOn: DateTime.parse(json["modified_on"]),
        name: json["name"],
        originalDnshost: json["original_dnshost"].toString(),
        originalNameServers: List<String>.from(json["original_name_servers"].map((x) => x)),
        nameServers: List<String>.from(json["name_servers"].map((x) => x)),
        originalRegistrar: json["original_registrar"], 
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "activated_on": activatedOn.toIso8601String(),
        "created_on": createdOn.toIso8601String(),
        "development_mode": developmentMode,
        "id": id,
        "modified_on": modifiedOn.toIso8601String(),
        "name": name,
        "original_dnshost": originalDnshost,
        "original_name_servers": List<dynamic>.from(originalNameServers.map((x) => x)),
        "name_servers": List<dynamic>.from(nameServers.map((x) => x)),
        "original_registrar": originalRegistrar,
        "status": status,
    };
}
