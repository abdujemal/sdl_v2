import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sdl_v2/Models/room.dart';
import 'package:sdl_v2/core/failure.dart';
import 'package:sdl_v2/core/typedef.dart';

import '../../core/providers.dart';

final homeRepoProvider = Provider<HomeRepo>((ref) {
  return HomeRepo(
    firebaseDatabase: ref.read(databaseProvider),
    firebaseAuth: ref.read(authProvider),
  );
});

class HomeRepo {
  final FirebaseDatabase firebaseDatabase;
  final FirebaseAuth firebaseAuth;

  HomeRepo({
    required this.firebaseDatabase,
    required this.firebaseAuth,
  });

  FutureVoid addRoom(String roomName) async {
    try {
      final ref = firebaseDatabase.ref().child("Rooms").push();
      await ref.update(Room(id: ref.key!.toString(), name: roomName).toMap());

      return right("Void");
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }

  FutureVoid toggleDeviceSwitch(bool val, String id) async {
    try {
      final ref = await firebaseDatabase
          .ref()
          .child("Devices")
          .child(id)
          .child("swittch")
          .set(val);
      return right('Void');
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }

   FutureVoid toggleDeviceSchedule(bool val, String id) async {
    try {
      final ref = await firebaseDatabase
          .ref()
          .child("Devices")
          .child(id)
          .child("schedule")
          .set(val);
      return right('Void');
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }

  FutureVoid toggleDeviceAuto(bool val, String id) async {
    try {
      final ref = await firebaseDatabase
          .ref()
          .child("Devices")
          .child(id)
          .child("auto")
          .set(val);
      return right('Void');
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }
}
