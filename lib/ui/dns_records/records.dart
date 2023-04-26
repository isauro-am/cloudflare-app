import 'package:flutter/material.dart';

import '../../data/secure_storage.dart';
import '../../domain/dns_records/dns_records_data.dart';
import '../../domain/models/dns_zone.dart';
import '../../services/services.dart';
import '../drawer/drawer.dart';

class DnsRecordView extends StatefulWidget {
  final DnsZone activeZone;

  const DnsRecordView({Key? key, required this.activeZone}) : super(key: key);

  @override
  State<DnsRecordView> createState() => _DnsRecordViewState();
}

class _DnsRecordViewState extends State<DnsRecordView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.activeZone.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, pageRoutes.newDnsRecord);
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, pageRoutes.home );
                Navigator.popAndPushNamed(context, pageRoutes.home);
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        drawer: cloudflareDrawer(context),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<dynamic>(
              future: tokenDefined(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                List<Widget> widgetList;

                if (snapshot.hasData) {
                  widgetList = dnsRecordTiles(widget.activeZone);

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
