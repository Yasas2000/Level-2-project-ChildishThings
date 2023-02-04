// ignore_for_file: import_of_legacy_library_into_null_safe

import "package:google_sign_in/google_sign_in.dart";

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}