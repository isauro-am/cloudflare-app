const dnsRecordTypes = DNSRecordsTypes([
  'A',
  'CNAME',
  'MX',
  'NS',
  'PTR',
  'SPF',
  'TLSA',
  'TXT',
]);

class DNSRecordsTypes {
  final List<String> values;

  const DNSRecordsTypes(this.values);

  /// This function checks if a given value is present in a list of values.
  ///
  /// Args:
  ///   value (String): The parameter "value" is a String type parameter that represents the value to be
  /// checked if it exists in a collection of values. The method "contains" returns a boolean value
  /// indicating whether the specified value is present in the collection or not.
  bool contains(String value) => values.contains(value);
}
