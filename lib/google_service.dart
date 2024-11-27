import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  // Google Sign-In with prompt for account selection
  Future<UserCredential?> signInWithGoogle() async {
    // Configure GoogleSignIn to request email scope
    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      // Check if a user is already signed in
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }

      // Start the sign-in process
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) return null; // The user canceled the sign-in

      // Obtain auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with the new credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }
}
