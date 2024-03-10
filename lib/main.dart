import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kidsnursery/Models/children.dart';
import 'package:kidsnursery/Models/prefrences.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Network/firebase_api.dart';
import 'package:kidsnursery/Pages/CenterPage.dart';
import 'package:kidsnursery/Pages/HomePage.dart';
import 'package:kidsnursery/Pages/LoginPage.dart';
import 'package:kidsnursery/Network/firebase_options.dart';
import 'package:kidsnursery/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseApi firebaseApi = FirebaseApi();
late final SharedPref sharedPref;
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  sharedPref = SharedPref(prefs);
  await firebaseApi.initnotification();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CurrentChildren(),
    ),
    ChangeNotifierProvider(create: (context) => CurrentUser())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //locale: Locale('fr'),
      localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<StatefulWidget>(
        future: firebaseApi.checkAndNavigateUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the future to complete
            return Scaffold(
              body: Center(
                child: Image.asset('assets/logo.png'),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error if the future encountered an error
            return const LoginPage();
          } else {
            // Future completed successfully, no errors
            return snapshot.data ??
                Container(); // Return an empty container or any other widget
          }
        },
      ),
    );
  }
}
