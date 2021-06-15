import 'package:finance/service/drive/GoogleAuthClient.dart';
import 'package:finance/service/user/user_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as dr;

class UserFirebase implements IUser {

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn.standard(scopes: [dr.DriveApi.driveFileScope]);

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if(googleUser != null){
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }

  Future<bool> isUserOnGoogle() async {
    bool isSignedIn = await _googleSignIn.isSignedIn();

    return isSignedIn;
  }

  bool isUserOn()  {
    return _auth.currentUser != null;
  }

  @override
  Future<void> signOut() async {

    var response = _googleSignIn.currentUser;

    print(response);
    //await _googleSignIn.signOut();
    await _googleSignIn.disconnect();

    await FirebaseAuth.instance.signOut();
  }

  Future? getAuthHeaders() async {
    final currentUser = _googleSignIn.currentUser;

    try{
      if(currentUser == null){
        await signInWithGoogle();
      }

      final authHeaders = await _googleSignIn.currentUser!.authHeaders;

      return authHeaders;
    }catch(e){
      return null;
    }

  }


  Future uploadFileToGoogleDrive() async {
    //await signInWithGoogle();
    /*try{

    final authHeaders = await _googleSignIn.currentUser!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);

    final drive = dr.DriveApi(authenticateClient);

    DateTime dateTime = DateTime.now();
    var file = new dr.File();
    file.name = dateTime.toIso8601String();
    file.parents = ["1n4nVjVP3ttjRDrEvUe8mqFzHic6N8uAY"];

    //file.mimeType = "application/vnd.google-apps.file";



    String hh = jsonEncode({"lul": dateTime.millisecond});

    print(hh);

    dr.Media mediaStream = dr.Media(
      Future.value(
        List.from(ascii.encode(hh)).cast<int>().toList(),
      ).asStream().asBroadcastStream(),
      hh.length,
    );


      final response = await drive.files.create(file, uploadMedia: mediaStream);

      //print(response.id);

      //var media = await FilePicker.platform.pickFiles();

      /*final lul = await drive.files.list(q: "'1n4nVjVP3ttjRDrEvUe8mqFzHic6N8uAY' in parents");
      print(lul.files);
      lul.files!.forEach((element) {
        print("${element.id} - ${element.name}");
      });*/
//'1n4nVjVP3ttjRDrEvUe8mqFzHic6N8uAY', downloadOptions: dr.DownloadOptions.fullMedia
      //final response = await drive.files.export('1n4nVjVP3ttjRDrEvUe8mqFzHic6N8uAY', "application/json", downloadOptions: dr.DownloadOptions.fullMedia);
      /*final response = await drive.files.get('1fx_xTTgPFz3guTJ3Yf4UHGIorF8eUNo1', downloadOptions: dr.DownloadOptions.fullMedia);

      List<int> dataStore = [];*/



      //print();

    }catch(e){
      print(e);
    }*/

    //final Stream<List<int>> mediaStream = Future.value([104, 105]).asStream();
    //var media = new dr.Media(mediaStream, 2);
    /*var media = await FilePicker.platform.pickFiles();
    if(media != null){
      //print(media.files.single);
      //media.files.single.bytes.
      File file = File(media.files.single.path.toString());
      await file.writeAsBytes(ascii.encode("teste"));
      var driveFile = new dr.File();
      driveFile.name = "hello_world.txt";
      final result = await drive.files.create(driveFile, uploadMedia: dr.Media(file.openRead(), file.lengthSync()));

      print(result);
    }*/
  }

}