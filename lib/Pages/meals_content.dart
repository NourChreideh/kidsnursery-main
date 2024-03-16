import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/generated/l10n.dart';

class MealsContent extends StatefulWidget {
  final String userID;
  const MealsContent({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<MealsContent> createState() => _MealsContentState();
}

class _MealsContentState extends State<MealsContent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('meals')
          .doc(widget.userID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.data() == null) {
          return const Center(child: Text('No attendance data found.'));
        }

        List<Map<String, dynamic>> attendanceHistory =
            List<Map<String, dynamic>>.from(snapshot.data!['meals']);

        return ListView.builder(
      
          itemCount: attendanceHistory.length,
          itemBuilder: (context, index) {
            var attendanceEntry = attendanceHistory[index];
            DateTime timestamp = attendanceEntry['timestamp'] != null
                ? attendanceEntry['timestamp'].toDate()
                : DateTime.now();
         
            String formattedTime = DateFormat('HH:mm EEE').format(timestamp);

            // Categorize the date
            DateTime now = DateTime.now();
            String timeAgo = '';
            if (now.year == timestamp.year &&
                now.month == timestamp.month &&
                now.day == timestamp.day) {
              timeAgo = S.of(context).today;
            } else {
              DateTime yesterday = now.subtract(const Duration(days: 1));
              if (yesterday.year == timestamp.year &&
                  yesterday.month == timestamp.month &&
                  yesterday.day == timestamp.day) {
                timeAgo = S.of(context).yesterday;
              } else {
                Duration difference = now.difference(timestamp);
                if (difference.inDays < 31) {
                  timeAgo = '${difference.inDays} ${S.of(context).daysago}';
                } else {
                  int months = (now.year - timestamp.year) * 12 +
                      now.month -
                      timestamp.month;
                  timeAgo = '$months months ago';
                }
              }
            }

            return attendanceEntry['childName'] == null
                  ? Container() :ListTile(
              leading: CircleAvatar(
                backgroundColor: GlobalColors.mainColor.withOpacity(0.5),
                child: Image.asset("assets/food.png")),
              title: Text(' ${attendanceEntry['childName']}'),
              subtitle: attendanceEntry['type'] == null
                  ? null
                  : Text(

                      '${S.of(context).mealstaken}: ${attendanceEntry['type'] ?? ''} '),
                      trailing: Text("$formattedTime ",style: TextStyle(color: Colors.grey),),
            );
          },
        );
      },
    );
  }
}
