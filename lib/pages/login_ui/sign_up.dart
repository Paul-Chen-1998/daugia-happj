import 'dart:convert';
import 'dart:io';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/utils/auth_service.dart';
import 'package:flutterhappjapp/utils/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

enum AuthFormType { signIn, signUp, reset }

class SignUp extends StatefulWidget {
  final AuthFormType authFormType;

  SignUp({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState(authFormType: this.authFormType);
}

class _SignUpState extends State<SignUp> {
  AuthFormType authFormType;

  _SignUpState({this.authFormType});

  bool _loading = false;
  bool _showPassWord = false;
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  SharedPreferences sharedPreferences;
  final formKey = GlobalKey<FormState>();
  String _phone, _password, _confirmPassword,_confirmPassword1, _name, _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if (state == 'authentication') {
      Navigator.of(context).pushNamed('/authentication');
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  saveUserMongoDB(String userID, userName, email, imageUser) async {
    try {
      print('begin');
      print("$userID,$userName,$email,$imageUser");
      Map data;
      data = {
        "id": userID,
        "userName": userName,
        "email": email,
        "imageUser": imageUser,
      };
      if (imageUser == null) {
        data = {
          "id": userID,
          "userName": userName,
          "email": email,
          "imageUser": imageUser,
        };
      }

      String body = json.encode(data);

      var jsonResponse = null;

      var response = await http.post(Server.signUp, body: data);

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (jsonResponse != null) {
          print(
              'id : ${jsonResponse['id']}, luu du lieu tren mongo thanh cong');
        }
      } else {
        print(response.body);
        print('luu du lieu tren mongo that bai');
      }
      print('end');
    } catch (e) {
      print(e);
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        switch (authFormType) {
          case AuthFormType.signIn:
            signIn(_phone,_password);

            break;
          case AuthFormType.signUp:
            signUp(_name,_phone,_password);
            break;
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_phone.trim());
            setState(() {
              _error = "A password reset link has been sent to $_phone";
              authFormType = AuthFormType.signIn;
              print("send link reset password");
            });
            break;
        }
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

      return _loading ? SplashPage() : new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * 0.05),
                  showAler(),
                  buildTitle(height),
                  SizedBox(height: height * 0.01),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.all(0.0),
                      margin: EdgeInsets.all(0.0),
                      width: width,
                      height: height * 0.6,
                      child: ListView(
                        padding: EdgeInsets.all(0.0),
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: buildsInputs() + buildButton(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }

  Padding buildTitle(double height) {
    String headerText;
    if (authFormType == AuthFormType.signIn)
      headerText = "Sign in";
    else if (authFormType == AuthFormType.reset) {
      headerText = " Reset password";
    } else
      headerText = "Create New Account";

    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: new Text(
        headerText,
        style: new TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  void validateForm() {}

  // ignore: missing_return
  List<Widget> buildsInputs() {

    List<Widget> textFields = [];
    if (authFormType == AuthFormType.reset) {
      textFields.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextFormField(
          validator: EmailValidator.validate,
          autocorrect: false,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
          decoration: buildInputSignInDecoration("Email"),
          onSaved: (value) => _phone = value.trim(),
        ),
      ));
      return textFields;
    }

    if (authFormType == AuthFormType.signUp) {
      textFields.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextFormField(
          validator: NameValidator.validate,
          autocorrect: false,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
          decoration: buildInputSignInDecoration("Name"),
          onSaved: (value) => _name = value.trim(),
        ),
      ));
    }
    if(authFormType == AuthFormType.signUp){
      textFields.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextFormField(
          initialValue: TrangThai.phone ,
          enabled: false,
          validator: EmailValidator.validate,
          autocorrect: false,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
          decoration: buildInputSignInDecoration("My phone"),
          onSaved: (value) => _phone = value.trim(),
        ),
      ));
    }else{
      textFields.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextFormField(
          validator: EmailValidator.validate,

          autocorrect: false,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
          decoration: buildInputSignInDecoration("My phone"),
          onSaved: (value) => _phone = value.trim(),
        ),
      ));
    }


    textFields.add(SizedBox(
      height: 5.0,
    ));
    textFields.add(
      Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: <Widget>[
              new TextFormField(
                validator: PasswordValidator.validate,
                obscureText: !_showPassWord,
                autocorrect: false,
                style: new TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: buildInputSignInDecoration("Password"),
                onSaved: (value) => _password = value.trim()
              ),
              new GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassWord = !_showPassWord;
                  });
                },
                child: new Text(!_showPassWord ? 'SHOW' : 'HIDE',
                    style: new TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              )
            ],
          )),
    );
    if (authFormType == AuthFormType.signUp) {
      textFields.add(SizedBox(
        height: 5.0,
      ));
      textFields.add(
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                new TextFormField(
                  validator:
                      PasswordConfirmValidator(text: _password ,text2: _confirmPassword)
                          .validate,
                  obscureText: !_showPassWord,
                  autocorrect: false,
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  decoration: buildInputSignInDecoration("Confrim password"),
                  onSaved: (value) => _confirmPassword = value.trim(),

                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassWord = !_showPassWord;
                    });
                  },
                  child: new Text(!_showPassWord ? 'SHOW' : 'HIDE',
                      style: new TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                )
              ],
            )),
      );
    }

    return textFields;
  }

  InputDecoration buildInputSignInDecoration(String hint) {
    return InputDecoration(
      focusColor: Colors.orangeAccent,
      fillColor: Colors.orangeAccent,
      contentPadding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 14.0),
      labelText: hint,
      labelStyle: TextStyle(
          color: Color(0xff888888), fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  List<Widget> buildButton() {
    String _swtichButton, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocialButton = true;

    if (authFormType == AuthFormType.signIn) {
      _swtichButton = "Create new Account";
      _newFormState = "authentication";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _swtichButton = "Return to Sign in";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
      _showSocialButton = false;
    } else {
      _swtichButton = "Already Have account? Sign in";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }
    return [
      Container(
        margin: EdgeInsets.only(top: 10.0),
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.06,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.green[800],
          child: new AutoSizeText(_submitButtonText,
              maxLines: 1,
              style: new TextStyle(color: Colors.white, fontSize: 22.0)),
          onPressed: () {
            submit();
          },
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _swtichButton,
          style: TextStyle(color: Colors.green),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocialButton)
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      visible: visible,
      child: FlatButton(
        child: AutoSizeText("Forgot Password?",
            style: new TextStyle(color: Colors.green)),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
    );
  }

  Widget showAler() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0.0);
  }

  // ignore: missing_return
  Widget buildSocialIcons(bool visible) {
    final auth = Provider.of(context).auth;
    return Visibility(
      visible: visible,
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 5.0),
          GoogleSignInButton(
            onPressed: () async {
              try {
                  await auth.signInWithGoogle();
                  Navigator.of(context).pushReplacementNamed('/home');
                  //await auth.saveUserMongoDB();
                  Fluttertoast.showToast(msg: "Login was successful");

              } catch (e) {
                setState(() {
                  _error = e.message;
                });
              }
            },
          )
        ],
      ),
    );
  }

  signIn(String phone, pass) async {
    setState(() {
      _loading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'phoneUser': phone, 'passWord': pass};

    var jsonResponse = null;
    var response = await http.post(Server.signIn, body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("_id", jsonResponse['id']);
        sharedPreferences.setString("name", jsonResponse['name']);
        sharedPreferences.setString("phone", jsonResponse['phone']);
        Navigator.of(context).pushNamedAndRemoveUntil('/home',(Route<dynamic> route) => false);
       // Navigator.of(context).popAndPushNamed('/home');
        Fluttertoast.showToast(msg: "SignIn was successful");
      }
    }
    else{
      setState(() {
        _loading = false;
      });
      _error = response.body;
      print(response.body);
    }
  }

  signUp(String userName, phone, passWord) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _loading = true;
    });
    Map data = {
      'userName': userName,
      'phoneUser': phone,
      'passWord': passWord
    };
    var jsonResponse = null;

    var response = await http.post(Server.signUp, body: data);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("_id", jsonResponse['_id']);
        sharedPreferences.setString("name", jsonResponse['name']);
        sharedPreferences.setString("phone", jsonResponse['phoneUser']);
        print('id : ${jsonResponse['_id']}, luu du lieu tren mongo thanh cong');
        Navigator.of(context).pushNamedAndRemoveUntil('/home',(Route<dynamic> route) => false);
        //Navigator.of(context).popAndPushNamed('/home');
        Fluttertoast.showToast(msg: "SignUp was successful");
      }


    } else {
      setState(() {
        _loading = false;
      });
      _error = response.body;
      print(response.body);
      print('luu du lieu tren mongo that bai');
    }
  }

//  void _onButtonPressed() {
//    showModalBottomSheet(
//        context: context,
//        builder: (context) {
//          return new Container(
//            color: Color(0xFF737373),
//            height: 168,
//            child: new Container(
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.only(
//                    topLeft: const Radius.circular(10),
//                    topRight: const Radius.circular(10)),
//              ),
//              child: new Column(
//                children: <Widget>[
//                  ListTile(
//                    leading: Icon(CommunityMaterialIcons.camera),
//                    title: Text('Camera'),
//                    onTap: () => _pickImage(ImageSource.camera),
//                  ),
//                  ListTile(
//                    leading: Icon(CommunityMaterialIcons.library_shelves),
//                    title: Text('Gallery'),
//                    onTap: () {
//                      _pickImage(ImageSource.gallery);
//                      Navigator.pop(context);
//                    },
//                  ),
//                  ListTile(
//                    leading: Icon(CommunityMaterialIcons.close),
//                    title: Text('Close'),
//                    onTap: () {
//                      Navigator.pop(context);
//                    },
//                  )
//                ],
//              ),
//            ),
//          );
//        });
//  }
}

class TextFiledUser extends StatefulWidget {
  @override
  _TextFiledUserState createState() => _TextFiledUserState();
}

class _TextFiledUserState extends State<TextFiledUser> {
  bool _showPassWord = false;
  TextEditingController _controllerName,
      _controllerEmail,
      _controllerPassword,
      _controllerConfimpassWord = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Container(
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: _controllerEmail,
              autocorrect: false,
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            new Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                new TextField(
                  controller: _controllerPassword,
                  obscureText: !_showPassWord,
                  autocorrect: false,
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassWord = !_showPassWord;
                    });
                  },
                  child: new Text(!_showPassWord ? 'SHOW' : 'HIDE',
                      style: new TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            new TextField(
              controller: _controllerConfimpassWord,
              obscureText: false,
              autocorrect: false,
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Confrim password',
                labelStyle: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            new TextField(
              controller: _controllerName,
              autocorrect: false,
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 2),
      compressQuality: 100,
      maxWidth: 500,
      maxHeight: 500,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.lightBlueAccent,
          toolbarWidgetColor: Colors.white,
          toolbarTitle: 'Crop it'),
    );

    this.setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Column(
          children: <Widget>[
            // ignore: sdk_version_ui_as_code
            if (_imageFile != null) ...[
              new SizedBox(height: 20),
              new Container(
                height: 200,
                width: 200,
//                decoration: new BoxDecoration(
//                  shape: BoxShape.circle,
//                  color: Color(0xffd8d8d8),
//                ),
                child: Image.file(
                  _imageFile,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(CommunityMaterialIcons.crop),
                      onPressed: _cropImage,
                    ),
                    FlatButton(
                      child: Icon(CommunityMaterialIcons.refresh),
                      onPressed: _clear,
                    )
                  ],
                ),
              ),
            ] else ...[
              Center(
                child: new SizedBox(
                    height: 200,
                    width: 200,
                    child: IconButton(
                        icon: Icon(CommunityMaterialIcons.file_image,
                            size: 110, color: Colors.green[700]),
                        onPressed: _onButtonPressed)),
              ),
              new GestureDetector(
                onTap: _onButtonPressed,
                child: new Text(
                  'Add a profile photo',
                  style: new TextStyle(
                      color: Colors.green[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        )
      ],
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            color: Color(0xFF737373),
            height: 168,
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10)),
              ),
              child: new Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(CommunityMaterialIcons.camera),
                    title: Text('Camera'),
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                  ListTile(
                    leading: Icon(CommunityMaterialIcons.library_shelves),
                    title: Text('Gallery'),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(CommunityMaterialIcons.close),
                    title: Text('Close'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
