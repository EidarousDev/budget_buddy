import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/home_screen.dart';

class AppDrawer extends StatelessWidget {
  final int total;

  const AppDrawer({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Daily Spendings',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Home"),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("Contact Us"),
                    onTap: () async {
                      String url = Uri.encodeFull(
                          "mailto:mufaddalshakir55@gmail.com?subject=NeedHelp&body=Contact Reason: ");
                      if (await canLaunch(url)) {
                        Navigator.of(context).pop();
                        await launch(url);
                      }
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/github.png',
                      color: Colors.grey,
                    ),
                    title: Text("Contribute"),
                    onTap: () async {
                      String url = Uri.encodeFull(
                          "https://github.com/Mufaddal5253110/DailySpending.git");
                      if (await canLaunch(url)) {
                        Navigator.of(context).pop();
                        await launch(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Total: ₹$total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
