

import 'package:flutter/material.dart';
import 'package:kidsnursery/Models/children.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Network/firebase_api.dart';
import 'package:kidsnursery/Pages/Notification_Settings.dart';
import 'package:kidsnursery/Pages/childrens_view.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/Widgets/BottomNavBar.dart';
import 'package:kidsnursery/generated/l10n.dart';

class ProfilePage extends StatefulWidget {
  final Users user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _selectedIndex = 3;
  FirebaseApi firebaseApi = FirebaseApi();

  Future<void> fetchChildrenData() async {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8faf9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: widget.user.profileimageUrl!.isNotEmpty
                                  ? Image.network(
                                      widget.user.profileimageUrl!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      "assets/kid.webp",
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.user.firstName} ${widget.user.lastName}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffe8527e)),
                                color: const Color.fromARGB(15, 204, 101, 129),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${widget.user.unpaidServices}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffe8527e)),
                                  ),
                                   Text(
                               S.of(context).unpaid  ,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffe8527e)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.3), 
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child:  Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
S.of(context).children,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 5,
                        ),
                        const Childrens(),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                  
                   
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.3), // Set the shadow color
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.settings,
                              color: GlobalColors.mainColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                             Text(
                            S.of(context).children ,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => const Notifications())));
                          },
                          child:  Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.notifications),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                               S.of(context).notifications,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            firebaseApi.signOut();
                          },
                          child:  Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.logout),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                              S.of(context).signout,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 180,)
              ],
            ),
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

