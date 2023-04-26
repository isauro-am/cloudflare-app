import 'package:cloudflare/constants/navigation.dart';
import 'package:flutter/material.dart';

import '../../constants/routes.dart';

drawerTextElement(String text) {
  return Text(text,
      style: const TextStyle(fontSize: 18.0, color: Colors.white));
}

cloudflareDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 229, 136, 59)),
      // decoration: const BoxDecoration(color: Color(0xFF0098c2)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: drawerTextElement('Zones'),
                  leading: const Icon(
                    Icons.dns,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  onTap: () {
                    AppNavigator.navigator(context, Routes.home);
                  },
                ),
                ListTile(
                  title: drawerTextElement('Tokens'),
                  leading: const Icon(
                    Icons.token_outlined,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: drawerTextElement('DNS'),
                  leading: const Icon(
                    Icons.info_outline,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: <Widget>[
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.settings),
                      onTap: () {
                        AppNavigator.navigator(context, Routes.account);
                      },
                      title: const Text('Accounts')),
                  const ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Info'),
                  )
                ],
              )),
        ],
      ),
    ),
  );
}
