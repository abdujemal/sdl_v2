// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sdl_v2/Models/device.dart';
import 'package:sdl_v2/core/failure.dart';
import 'package:sdl_v2/core/providers.dart';

import '../../core/typedef.dart';

final AddSensorProvider = Provider<AddSensorRepo>((ref) {
  return AddSensorRepo(
    firebaseDatabase: ref.read(databaseProvider),
    firebaseAuth: ref.read(authProvider),
  );
});

class AddSensorRepo {
  final FirebaseDatabase firebaseDatabase;
  final FirebaseAuth firebaseAuth;
  AddSensorRepo({
    required this.firebaseDatabase,
    required this.firebaseAuth,
  });

  FutureVoid addSensor(Device sensor) async {
    try {
      final ref = firebaseDatabase.ref().child("Devices").push();
      await ref.update(sensor.copyWith(id: ref.key.toString()).toMap());
      return right("");
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }
}
