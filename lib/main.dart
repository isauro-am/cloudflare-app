import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/services.dart';
import 'ui/dns_records/new_record.dart';
import 'ui/settings/set_token.dart';
import 'ui/zones/zones.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      builder: (_) => const MyApp(),
      enabled: !kReleaseMode, // Enable it only in debug mode
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
      scrollBehavior:
          MyCustomScrollBehavior(), // Custom Scroll Behavior for all scrollable widgets

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: pageRoutes.account,
      routes: {
        // pageRoutes.home: (context) => const Home(),
        pageRoutes.account: (_) => const SetToken(),
        pageRoutes.home: (_) => const DNSZones(),
        // pageRoutes.dnsRecords: (context) => const DnsRecordView(),
        pageRoutes.newDnsRecord: (_) => const NewDnsRecord()
      },
    );
  }
}

/// This class is a MaterialScrollBehavior that allows dragging with touch and mouse.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}