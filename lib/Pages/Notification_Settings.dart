// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidsnursery/generated/l10n.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  @override
  Widget build(BuildContext context) {
      List<String> items = [S.of(context).allnotifications, ];

    List<String> items2 = [

   S.of(context).checkin,
    S.of(context).checkout,
   S.of(context).food,
 
  ];
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title:  Text(
         S.of(context).notifications,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(6),
          child: Divider(
            color: Color(0xffECECEC),
            height: 1,
          ),
        ),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: 1,
            itemBuilder: (context, index) {
              return commonListView(items[index], items, 0);
            },
          ),
         
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return commonListView(items[index], items2, 2);
            },
          ),
          SizedBox(height: 200,)
        ]),
      ),
    );
  }
}

Widget commonListView(String item, List<String> items, int index) {
  return Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(8)),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(items[index]);
            },
          ),
        ),
      ),
    ],
  );
}

class ItemCard extends StatefulWidget {
  final String item;

  const ItemCard(this.item, {super.key});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        tileColor: const Color(0xffF5F5F5),
        trailing: CupertinoSwitch(
          activeColor: Colors.blue,
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
          },
        ),
        title: Text(
          widget.item,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
