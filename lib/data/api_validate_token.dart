import 'package:cloudflare/data/endpoints.dart';

import '../services/services.dart';

CloudFlareToken cloudFlareToken = CloudFlareToken();

class CloudFlareToken {

  String baseUrl = Endpoints().host;
  String version = Endpoints().version;
  String path = "user/tokens/verify";

  validate() async {
    dynamic response = await httpRequest.getList("$baseUrl/$version/$path");
    print(response);
    return (response.containsKey("success"))? response['success'] : false;
  }
}



