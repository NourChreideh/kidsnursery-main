import 'package:flutter/material.dart';

class Children extends ChangeNotifier {
  int? age;
  String? firstName;
  String? lastName;
  String profileimageUrl;

  Children(
    this.age,
    this.firstName,
    this.lastName,
    this.profileimageUrl,
  );

  factory Children.fromjson(Map<String, dynamic> json) {
    return Children(
      json['Age'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['profileimageUrl'] as String,
    );
  }
}

class CurrentChildren extends ChangeNotifier {
  Children? children;
  void currentChildren(Children children) {
    this.children = children;
    notifyListeners();
  }
}
