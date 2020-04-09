import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _showPassWord = false;
  TextEditingController _controllerName,
      _controllerEmail,
      _controllerPassword,
      _controllerConfimpassWord = new TextEditingController();

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
    Widget _CreateMyAccount = new RaisedButton(
      color: Colors.green[800],
      child: new Text("Create my account",
          style: new TextStyle(color: Colors.white, fontSize: 20.0)),
      onPressed: () {
        validateForm();
      },
    );

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Container(
//                height: double.infinity,
//                width: double.infinity,
                color: Colors.white,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: new IconButton(
                          icon: new Icon(
                            CommunityMaterialIcons.arrow_left,
                            size: 35.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                      child: new Text(
                        'Sign up',
                        style: new TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    new Column(
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
                                      child:
                                          Icon(CommunityMaterialIcons.refresh),
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
                                        icon: Icon(
                                            CommunityMaterialIcons.file_image,
                                            size: 110,
                                            color: Colors.green[700]),
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
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    Padding(
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
                                labelText: 'My Phone',
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
                                  child: new Text(
                                      !_showPassWord ? 'SHOW' : 'HIDE',
                                      style: new TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
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
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Color(0xff888888),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new SizedBox(height: 20),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: _CreateMyAccount),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateForm() {}

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
//new TextField(
//controller: _controllerUser,
//autocorrect: false,
//style: new TextStyle(fontSize: 18.0, color: Colors.black),
//decoration: InputDecoration(
//labelText: 'Username or Email address',
//labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
//),
//),

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
