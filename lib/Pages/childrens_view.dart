import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidsnursery/Models/children.dart';

import 'package:kidsnursery/main.dart';

class Childrens extends StatefulWidget {
  const Childrens({Key? key}) : super(key: key);

  @override
  State<Childrens> createState() => _ChildrensState();
}

class _ChildrensState extends State<Childrens> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Users')
          .doc(currentUser!.uid)
          .collection('Children')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching Children.'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final childrens = snapshot.data?.docs;

        if (childrens == null || childrens.isEmpty) {
          return const Center(child: Text('No childrens found.'));
        }
        return Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: childrens.length,
            itemBuilder: (context, index) {
              final childrenData =
                  childrens[index].data() as Map<String, dynamic>;
              Children child = Children(
                  childrenData['age'],
                  childrenData['firstName'],
                  childrenData['lastName'],
                  childrenData['profileImageUrl']);

              return Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(30),
                          child: child.profileimageUrl.isNotEmpty
                              ? Image.network(
                                  child.profileimageUrl,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // While no progress is available, display the image
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                )
                              : Image.asset(
                                  "assets/kid.webp",
                                  fit: BoxFit.fill,
                                ))),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${child.firstName} ${child.lastName}",
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black87),
                      ),
                      Text(
                        "${child.age} year",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios),
                  const SizedBox(
                    width: 10,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
