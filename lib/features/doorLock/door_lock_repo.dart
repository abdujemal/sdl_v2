import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sdl_v2/Models/door_lock.dart';
import 'package:sdl_v2/core/failure.dart';
import 'package:sdl_v2/core/providers.dart';
import 'package:sdl_v2/core/typedef.dart';

final doorLockRepoProvider = Provider<DoorLockRepo>((ref) {
  return DoorLockRepo(firebaseDatabase: ref.read(databaseProvider));
});

class DoorLockRepo {
  final FirebaseDatabase firebaseDatabase;
  const DoorLockRepo({required this.firebaseDatabase});

  FutureVoid updateDoorLock(DoorLock doorLock) async {
    try {
      await firebaseDatabase
          .ref()
          .child("DoorLock")
          .child("DL1234")
          .update(doorLock.toMap());

      return right("r");
    } catch (e) {
      return left(Failure(messege: e.toString()));
    }
  }
}
