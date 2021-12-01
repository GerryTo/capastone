import 'dart:developer';

import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileViewModel extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final currentUserInfo = ServiceLocator.getIt.get<CurrentUserInfo>();

  String? _name;
  String? _company;
  String? _location;

  Future<void> fetchData() async {
    try {
      final userRef = await currentUserInfo.userRef;
      final user = await firestore.collection('users').doc(userRef?.id).get();
      final userData = user.data();

      _name = userData?['name'];
      _company = userData?['company'];
      _location = userData?['location'];
      notifyListeners();
    } on Exception catch (e, s) {
      log("edit_profile_viewmodel", error: e, stackTrace: s);
    }
  }

  String get name => _name ?? "";
  String get company => _company ?? "";
  String get location => _location ?? "";
}
