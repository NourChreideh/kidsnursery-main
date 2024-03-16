import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidsnursery/Models/children.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Pages/AttendancePage.dart';
import 'package:kidsnursery/Pages/ProfilePage.dart';
import 'package:kidsnursery/Pages/activities_content.dart';
import 'package:kidsnursery/Pages/diapers_content.dart';
import 'package:kidsnursery/Pages/health_content.dart';
import 'package:kidsnursery/Pages/meals_content.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/Widgets/BottomNavBar.dart';
import 'package:kidsnursery/generated/l10n.dart';
import 'package:kidsnursery/main.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Users user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${widget.user.firstName} ${widget.user.lastName}',
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      user: widget.user,
                    )));
                        },
                        child: const Text(
                          "View Profile",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.fill,
                          )))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.white,
                        dividerHeight: 0,
                        labelStyle: TextStyle(fontSize: 12),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: GlobalColors.mainColor,
                        indicator: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: GlobalColors.mainColor.withOpacity(0.5)),
                        controller: _tabController,
                        tabs: [
                          Tab(text: S.of(context).attendance),
                          Tab(text: S.of(context).meals),
                          Tab(text: S.of(context).health),
                          Tab(text: S.of(context).diapers),
                          Tab(text: S.of(context).activities)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FeedContent(userID: widget.user.userId),
                    MealsContent(userID: widget.user.userId),
                    HealthContent(userID: widget.user.userId),
                    DiapersContent(userID: widget.user.userId),
                    ActivitiesContent(userID: widget.user.userId),
                  ],
                ),
              ),
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
