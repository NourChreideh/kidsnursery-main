import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/Utility/globalColors.dart';

class FeedContent extends StatefulWidget {
  final String userID;
  const FeedContent({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<FeedContent> createState() => _FeedContentState();
}

class _FeedContentState extends State<FeedContent> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Attendance')
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
            List<Map<String, dynamic>>.from(snapshot.data!['attendance']);

    
        Map<String, List<Widget>> groupedTiles = {};
        for (var attendanceEntry in attendanceHistory) {
          DateTime timestamp = attendanceEntry['timestamp'] != null
              ? attendanceEntry['timestamp'].toDate()
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
          groupedTiles[key]!.add(
            attendanceEntry['childName'] != null
                  ? 
            
            ListTile(
            leading: CircleAvatar(
              backgroundColor: GlobalColors.mainColor.withOpacity(0.1),
              child: Icon(Icons.business_outlined)),
            title:  Text(' ${attendanceEntry['childName']} ${attendanceEntry['type'] ?? ''} by system'),
            trailing: Text(" $formattedTime"),
          
          ):Container());
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
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey
                    ),
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
