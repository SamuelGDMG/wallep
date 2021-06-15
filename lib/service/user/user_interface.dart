import 'package:firebase_auth/firebase_auth.dart';

abstract class IUser {
  Future<UserCredential?> signInWithGoogle();
  Future<void> signOut();
}