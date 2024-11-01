import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/new_transaction.dart';

import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';
import 'providers/transactions_provider.dart';
import 'screens/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Transactions(),
          ),
          ChangeNotifierProvider(
            create: (_) => SettingsProvider()..fetchSettings(),
          )
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Money Tracker',
            theme: ThemeData(
              primaryColor: Colors.amber,
              secondaryHeaderColor: Colors.amberAccent,
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headlineLarge: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // button: const TextStyle(
                    //     color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              appBarTheme: AppBarTheme(
                titleTextStyle: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            routes: {
              HomeScreen.routeName: (_) => HomeScreen(),
              NewTransaction.routeName: (_) => NewTransaction(),
              SettingsScreen.routeName: (_) => SettingsScreen(),
            },
          );
        });
  }
}
