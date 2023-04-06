import 'package:flutter/material.dart';

import '../../domain/zone/zone_data.dart';
import '../drawer/drawer.dart';

class DNSZones extends StatefulWidget {
  const DNSZones({Key? key,}) : super(key: key);

  @override
  State<DNSZones> createState() => _DNSZonesState();
}

class _DNSZonesState extends State<DNSZones> {
  String title = 'DNS Zones';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: cloudflareDrawer(context),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<dynamic>(
              future: getActiveZones(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> widgetList;

                if (snapshot.hasData) {
                  widgetList = dnsZoneTiles(snapshot, context);

                  widgetList.add(Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10)));
                } else if (snapshot.hasError) {
                  widgetList = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('- Error: ${snapshot.error}'),
                    )
                  ];
                } else {
                  widgetList = <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting DNS Zones results...'),
                    )
                  ];
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widgetList,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
