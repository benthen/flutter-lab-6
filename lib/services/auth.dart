import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';
// import '../models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj
  UserInfo _userFromFirebaseUser(final user){
    return UserInfo(user.uid);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;
      return user;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email password
  Future signin(String email, String password) async {
    try{
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      dynamic user = result.user;
      return user;
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  // register
  Future register(String email, String password) async {
    try{
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;

      // create a new document for the user
      await Database().update('0', 'new crew member', 100);

      return user;
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signout() async {
    try{
      print('signing out');
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
