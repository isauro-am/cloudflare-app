import 'package:flutter/material.dart';

import 'services/services.dart';

class CloudflareColors {
  Color get activeIcon => const Color.fromARGB(255, 223, 141, 49);
  Color get noActiveIcon => const Color.fromARGB(255, 156, 143, 127);
}

tokenDefined() async {

  if (await sotoreSecureData.getData("token") != null) {
    return true;
  } else {
    return false;
  }
}

class SnackBarMessages {
  List<String> messages = [];

  show(BuildContext context) {
    for (String message in messages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      messages.remove(message);
    }
  }
}

