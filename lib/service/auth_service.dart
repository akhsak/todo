import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimo/features/user/model/user_model.dart';
import 'package:mimo/service/firestore_service.dart';


class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> registerUser(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );

      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }
      await FirestoreService().createUser(UserModel(
          email: userModel.email,
          fullname: userModel.email,
          uid: userCredential.user!.uid));
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw Exception('An error occurred during registration: $e');
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }

  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
  }

  User? get currentUser => firebaseAuth.currentUser;

  Future<dynamic> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw Exception('An error occurred during password reset: $e');
    }
  }
}
