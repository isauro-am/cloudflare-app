import 'package:flutter/material.dart';

import 'data/secure_storage.dart';

CloudflareColors cloudflareColors = CloudflareColors();

class CloudflareColors {
  Color get activeIcon => const Color.fromARGB(255, 223, 141, 49);
  Color get noActiveIcon => const Color.fromARGB(255, 156, 143, 127);
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
