// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/Widgets/BottomNavBar.dart';
import 'package:kidsnursery/generated/l10n.dart';

class CenterPage extends StatefulWidget {
  final Users user;
  const CenterPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  final int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8faf9),
      body: Container(
                  decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.lightGreen.withOpacity(0.1),
                Colors.lightBlue.withOpacity(0.1),
                Colors.pink.withOpacity(0.1),
              ],
            ),
          ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Little talent",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Play",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Set the shadow color
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ], borderRadius: BorderRadius.circular(5), color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                       Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                          S.of(context).adress,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.home_outlined,
                            size: 28,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "123 Free Trail Way ,Demonstration,\nVirginia,23265,USA",
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                       Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                         S.of(context).contactinfo,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          const Text("@",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "linettesimseamv@gmail.com",
                            style: TextStyle(
                                fontSize: 15, color: GlobalColors.mainColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Operating hours",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DayOpen("Sundays:"),
                      const SizedBox(
                        height: 3,
                      ),
                      DayOpen("Mondays:"),
                      const SizedBox(
                        height: 3,
                      ),
                      DayOpen("Tuesdays:"),
                      const SizedBox(
                        height: 3,
                      ),
                      DayOpen("Wednesdays:"),
                      const SizedBox(
                        height: 3,
                      ),
                      DayOpen("Thursdays:"),
                      const SizedBox(
                        height: 3,
                      ),
                      DayOpen("Fridays:"),
                      const SizedBox(
                        height: 3,
                      ),
                      DayOpen("Saturdays:"),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Center Closing",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "2024",
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "No closed days in 2024",
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        image: widget.user.profileimageUrl!,
        currentIndex: _selectedIndex,
      ),
    );
  }
}

Widget DayOpen(String day) {
  return Row(
    children: [
      const SizedBox(
        width: 15,
      ),
      Text(
        day,
        style: const TextStyle(fontSize: 15, color: Colors.black54),
      ),
      const Spacer(),
      const Text(
        "3:00 AM-10:00 PM",
        style: TextStyle(fontSize: 15, color: Colors.black54),
      ),
      const SizedBox(
        width: 5,
      ),
    ],
  );
}
