import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Widgets/BottomNavBar.dart';
import 'package:kidsnursery/generated/l10n.dart';

class InboxScreen extends StatefulWidget {
  final Users user;
  const InboxScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

const int _selectedIndex = 1;

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(S.of(context).inbox),
      ),
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
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('message')
              .doc(widget.user.userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (!snapshot.hasData || snapshot.data!.data() == null) {
              return const Center(child: Text('No message data found.'));
            }
        
            List<Map<String, dynamic>> messagesHistory =
                List<Map<String, dynamic>>.from(snapshot.data!['message']);
        
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
             
              itemCount: messagesHistory.length,
              itemBuilder: (context, index) {
                var attendanceEntry = messagesHistory[index];
                DateTime timestamp = attendanceEntry['timestamp'] != null
                    ? attendanceEntry['timestamp'].toDate()
                    : DateTime.now();
                String formattedDate = DateFormat('dd/MM/yyyy').format(timestamp);
                String formattedTime = DateFormat('HH:mm').format(timestamp);
        
                // Categorize the date
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
        
                return attendanceEntry['Message'].toString().isNotEmpty
                    ? Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          title: Text('${attendanceEntry['Message']}'),
                          subtitle: attendanceEntry['type'] == null
                              ? null
                              : Text(' $formattedDate $formattedTime ($timeAgo)'),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        image: widget.user.profileimageUrl!,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
