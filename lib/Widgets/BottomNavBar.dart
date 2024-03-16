// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidsnursery/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:kidsnursery/Models/children.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Pages/CenterPage.dart';
import 'package:kidsnursery/Pages/HomePage.dart';
import 'package:kidsnursery/Pages/LoginPage.dart';
import 'package:kidsnursery/Pages/ProfilePage.dart';
import 'package:kidsnursery/Pages/inbox_page.dart';
import 'package:kidsnursery/Utility/globalColors.dart';

class CustomNavBar extends StatefulWidget {
  final String image;
  final int? currentIndex;

  const CustomNavBar({
    Key? key,
    required this.image,
    this.currentIndex,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  Users user =
      Users(false, false, '', '', false, '', 0, Timestamp.now(), false, '');

  Future<void> fetchUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    user = await firebaseApi.fetchUser(currentUser!);
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      user: user,
                    )));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InboxScreen(user: user)));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CenterPage(
                      user: user,
                    )));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      user: user,
                    )));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      height: 70,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                _onItemTapped(0);
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: widget.currentIndex == 0
                          ? GlobalColors.mainColor
                          : Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                     S.of(context).home,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.currentIndex == 0
                            ? GlobalColors.mainColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => _onItemTapped(1),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: widget.currentIndex == 1
                          ? GlobalColors.mainColor
                          : Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                   S.of(context).inbox,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.currentIndex == 1
                            ? GlobalColors.mainColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => _onItemTapped(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.business_sharp,
                    color: widget.currentIndex == 2
                        ? GlobalColors.mainColor
                        : Colors.black,
                  ),
                  const SizedBox(height: 5),
                  Text(
                  S.of(context).center,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.currentIndex == 2
                          ? GlobalColors.mainColor
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => _onItemTapped(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: widget.currentIndex == 3
                        ? GlobalColors.mainColor
                        : Colors.black,
                  ),
                  const SizedBox(height: 5),
                  Text(
                   S.of(context).profile,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.currentIndex == 3
                          ? GlobalColors.mainColor
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
