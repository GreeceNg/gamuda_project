import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  
  Future<bool> handleSignIn() async{
    try {
      GoogleSignInAccount signInAccount = await googleSignIn.signIn();
      if (signInAccount == null) {
        print('signInAccount null');
        return false;
      } 
        AuthResult user = await firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: (await signInAccount.authentication).idToken, 
            accessToken: (await signInAccount.authentication).accessToken
          )
        );
        if(user.user == null) {
          print(' user false');
          return false;
        } else return true;
      
    } catch (e) {
      print('Error login with google');
      return false;
    }
  }

  Future<bool> handleSignOut() async {
    try{
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      
      if(firebaseAuth == null &&  googleSignIn == null)
        return false;
       
       else return true;
    } catch(e) {
      print("logout error");
      return true;
    }
  }
}