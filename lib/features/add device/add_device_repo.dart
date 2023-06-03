import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sdl_v2/core/failure.dart';
import 'package:sdl_v2/core/providers.dart';
import 'package:sdl_v2/core/typedef.dart';

import '../../Models/device.dart';

final addDeviceProvider = Provider<AddDeviceRepo>((ref) {
  return AddDeviceRepo(
    firebaseDatabase: ref.read(databaseProvider),
    firebaseAuth: ref.read(authProvider),
  );
});

class AddDeviceRepo {
  final FirebaseDatabase firebaseDatabase;
  final FirebaseAuth firebaseAuth;
  AddDeviceRepo({
    required this.firebaseDatabase,
    required this.firebaseAuth,
  });

  FutureVoid addDevice(Device device) async {
    try {
      final ref = firebaseDatabase.ref().child("Devices").push();
      await ref.update(device.copyWith(id: ref.key.toString()).toMap());
      return right("");
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }
}
