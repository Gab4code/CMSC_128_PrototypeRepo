import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/models/user.dart';

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "The email address is already in use by another account.";
        break;
      default:
        errorMessage = "An error occurred. Please try again later.";
    }
    return errorMessage;
  }
}

class AuthService {
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create a stream
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String email, String username, String password,
      [void Function(String)? onError]) async {
    try {
      if (await isEmailTaken(email) || await isUsernameTaken(username)) {
        onError?.call("Email or username already in use.");
        return;
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("Users").doc(email).set({
        'username': username,
      });

      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  Future<bool> isEmailTaken(String email) async =>
      (await _auth.fetchSignInMethodsForEmail(email)).isNotEmpty;

  Future<bool> isUsernameTaken(String username) async {
    final usersSnap = await _firestore.collection("Users").get();
    return usersSnap.docs.any((doc) => doc.get('username') == username);
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }

  // Check if email already exists
  Future<bool> emailExists(String email) async {
    try {
      final result = await _auth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Check if username already exists
  Future<bool> usernameExists(String username) async {
    final result = await _firestore
        .collection('Users')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
