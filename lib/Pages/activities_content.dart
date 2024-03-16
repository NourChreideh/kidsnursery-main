import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/generated/l10n.dart';

class ActivitiesContent extends StatefulWidget {
  final String userID;
  const ActivitiesContent({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<ActivitiesContent> createState() => _ActivitiesContentState();
}

class _ActivitiesContentState extends State<ActivitiesContent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('activity')
          .doc(widget.userID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return const Center(child: Text('No activity data found.'));
        }

        List<Map<String, dynamic>> attendanceHistory =
            List<Map<String, dynamic>>.from(snapshot.data!['activity']);

        Map<String, List<Widget>> groupedTiles = {};
        for (var activityEntry in attendanceHistory) {
          DateTime timestamp = activityEntry['timestamp'] != null
              ? activityEntry['timestamp'].toDate()
              : DateTime.now();
          String formattedDate = DateFormat('dd/MM/yyyy').format(timestamp);
          String formattedTime = DateFormat('HH:mm EEE').format(timestamp);

          DateTime now = DateTime.now();
          String timeAgo = '';
          if (now.year == timestamp.year &&
              now.month == timestamp.month &&
              now.day == timestamp.day) {
            timeAgo = 'Today';
          } else {
            DateTime yesterday = now.subtract(const Duration(days: 1));
            if (yesterday.year == timestamp.year &&
                yesterday.month == timestamp.month &&
                yesterday.day == timestamp.day) {
              timeAgo = 'Yesterday';
            } else {
              Duration difference = now.difference(timestamp);
              if (difference.inDays < 31) {
                timeAgo = '${difference.inDays} days ago';
              } else {
                int months = (now.year - timestamp.year) * 12 +
                    now.month -
                    timestamp.month;
                timeAgo = '$months months ago';
              }
            }
          }

          String key = timeAgo.isNotEmpty ? timeAgo : formattedDate;
          if (!groupedTiles.containsKey(key)) {
            groupedTiles[key] = [];
          }
          groupedTiles[key]!.add(activityEntry['childName'] != null
              ? ListTile(
                  leading: CircleAvatar(
                      backgroundColor: GlobalColors.mainColor.withOpacity(0.1),
                      child:Image.asset("assets/lifestyle.png")),
                  title: Text(' ${activityEntry['childName']} '),
                  subtitle: Text('Activity: ${activityEntry['activity']} '),
                  trailing: Text(" $formattedTime"),
                )
              : Container());
        }

        return ListView(
          children: groupedTiles.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
                ...entry.value,
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
