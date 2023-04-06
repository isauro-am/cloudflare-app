import 'package:flutter/material.dart';

import '../../data/api_validate_token.dart';
import '../../data/secure_storage.dart';
import '../../services/services.dart';
import '../drawer/drawer.dart';

class SetToken extends StatefulWidget {
  const SetToken({Key? key}) : super(key: key);

  @override
  State<SetToken> createState() => _SetTokenState();
}

class _SetTokenState extends State<SetToken> {
  @override
  Widget build(BuildContext context) {
    String token;

    TextEditingController tokenC = TextEditingController();

    try {
      tokenC.text = sotoreSecureData.getData('token');
    } catch (e) {
      tokenC.text = '';
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
        ),
        drawer: cloudflareDrawer(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Reference name / account',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tokenC,
                // initialValue: tokenC.text,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: (tokenC.text != '') ? tokenC.text : 'Token',
                ),
                // onChanged: (value) {
                //   tokenC.text = value;
                // },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    if (tokenC.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Token is required'),
                        ),
                      );
                      return;
                    }

                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    await sotoreSecureData.setData('token', tokenC.text);

                    

                    var result = await cloudFlareToken.validate();

                    if (result == false) {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text('Token is invalid'),
                        ),
                      );
                      // tokenC.text = '';
                      return;
                    } else {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text('Token is valid'),
                        ),
                      );
                      Navigator.pushNamed(context, pageRoutes.home);
                    }
                  },
                  child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
