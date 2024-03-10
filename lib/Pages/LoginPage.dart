import 'package:flutter/material.dart';
import 'package:kidsnursery/Network/Response/ApiResponse.dart';
import 'package:kidsnursery/Network/firebase_api.dart';
import 'package:kidsnursery/Pages/HomePage.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/generated/l10n.dart';
import 'package:kidsnursery/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final FirebaseApi firebaseApi = FirebaseApi();
TextEditingController _username = TextEditingController();
TextEditingController _password = TextEditingController();
bool isloading = true;

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _password.clear();
    _username.clear();
    super.dispose();
  }

  void loadingDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
              child: Center(child: CircularProgressIndicator()),
            )));
  }

  void displayMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  void loggin(BuildContext context) async {
    loadingDialog();
    ApiResponse apiResponse =
        await firebaseApi.signIn(_username.text.trim(), _password.text.trim());

    if (mounted) {
      displayMessage(context, apiResponse.message.toString());
    }
    navigatorKey.currentState?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.fill,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
             Text(
              S.of(context).welcome,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
             Text(
            S.of(context).loginsentence,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: GlobalColors.mainColor),
              ),
              child: TextField(
                controller: _username,
                decoration:  InputDecoration(
                  hintText: S.of(context).username,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: GlobalColors.mainColor),
              ),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration:  InputDecoration(
                  hintText:S.of(context).password,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                loggin(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      GlobalColors.mainColor, const Color(0xffc2d4f1)],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:  Center(
                  child: Text(
                  S.of(context).singin ,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
