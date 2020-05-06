import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/User.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool load = false;
  bool _status = true;
  File fileImage;
  TextEditingController id,
      userName,
      phoneUser,
      email,
      imageUser,
      note,
      create_at;

  Future<void> _pickImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      fileImage = selected;
    });
  }

  void _clear() {
    setState(() => fileImage = null);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = new TextEditingController(text: widget.user.id);
    userName = new TextEditingController(text: widget.user.userName);
    phoneUser = new TextEditingController(text: widget.user.phoneUser);
    if(widget.user.email == ""){
      email = new TextEditingController(text: "Bạn chưa nhập mail");
    }else
    {email = new TextEditingController(text: widget.user.email);}

    imageUser = new TextEditingController(text: widget.user.imageUser);

    note = new TextEditingController(text: widget.user.note);
    create_at = new TextEditingController(text: widget.user.create_at);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: !load
            ? new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          height: 250.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, top: 20.0),
                                  child: new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.black,
                                          size: 22.0,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 25.0),
                                        child: new Text('PROFILE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                                fontFamily: 'sans-serif-light',
                                                color: Colors.black)),
                                      )
                                    ],
                                  )),
                              if (imageUser.text != "") ...[
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: new Stack(
                                      fit: StackFit.loose,
                                      children: <Widget>[
                                        new Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(
                                                width: 140.0,
                                                height: 140.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                    image: fileImage == null
                                                        ? NetworkImage(Server
                                                                .getImgUrlUser +
                                                            imageUser.text)
                                                        : FileImage(fileImage),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        !_status
                                            ? pickAndRefreshImg()
                                            : Container()
                                      ]),
                                ),
                              ] else ...[
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: new Stack(
                                      fit: StackFit.loose,
                                      children: <Widget>[
                                        new Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(
                                                width: 140.0,
                                                height: 140.0,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                    image: fileImage == null
                                                        ? AssetImage(
                                                            'images/hoso/userr.png')
                                                        : FileImage(fileImage),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        !_status
                                            ? pickAndRefreshImg()
                                            : Container()
                                      ]),
                                ),
                              ]
                            ],
                          ),
                        ),
                        new Container(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Parsonal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : new Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                _titleFields(title: "Name"),
                                _textFields(
                                    status: _status,
                                    hintText: userName.text,
                                    controller: !_status
                                        ? userName
                                        : new TextEditingController(text: "")),
                                _titleFields(title: "Email"),
                                _textFields(
                                    status: _status,
                                    hintText: email.text,
                                    controller: !_status
                                        ? email
                                        : new TextEditingController(text: "")),
                                _titleFields(title: "Phone"),
                                _textFields(
                                    status: true,
                                    hintText: phoneUser.text,
                                    controller:
                                        new TextEditingController(text: "")),
                                _titleFields(title: "Note"),
                                _textFields(
                                    status: _status,
                                    hintText: note.text,
                                    controller: !_status
                                        ? note
                                        : new TextEditingController(text: "")),
                                _titleFields(title: "Create_at"),
                                _textFields(
                                    status: true,
                                    hintText: create_at.text,
                                    controller:
                                        new TextEditingController(text: "")),
                                !_status
                                    ? _getActionButtons()
                                    : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : SplashPage());
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed

    super.dispose();
  }

  Widget _titleFields({String title}) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                child: new RaisedButton(
                  child: new Text("Save"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    updateInfoUser();
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                child: new RaisedButton(
                  child: new Text("Cancel"),
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      _status = true;
                    });
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _textFields(
      {String hintText, bool status, TextEditingController controller}) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                ),
                enabled: !status,
                autofocus: !status,
              ),
            ),
          ],
        ));
  }

  Widget pickAndRefreshImg() {
    return Padding(
      padding: EdgeInsets.only(top: 90.0, right: 100.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircleAvatar(
            backgroundColor: Colors.red,
            radius: 25.0,
            child: new IconButton(
              icon: Icon(fileImage == null ? Icons.camera_alt : Icons.refresh),
              color: Colors.white,
              onPressed: () {
                if (fileImage == null) {
                  // ignore: unnecessary_statements
                  _pickImage();
                } else {
                  _clear();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  void updateInfoUser() async {
    try {
      setState(() {
        load = true;
      });
      String url;
      var mimeType;

      if (fileImage != null) {
        url = Server.updateUser + widget.user.id;
        mimeType = lookupMimeType(fileImage.path, headerBytes: [0xFF, 0xD8])
            .split('/');
      } else {
        url = Server.updateUserNotImage + widget.user.id;
      }

      Uri uri = Uri.parse(url);
      final uploadRequest = http.MultipartRequest('PUT', uri);

      if (fileImage != null) {
        uploadRequest.files.add(await http.MultipartFile.fromPath(
            'imageUser', fileImage.path,
            contentType: MediaType(mimeType[0], mimeType[1])));
      }

      uploadRequest.fields['userName'] = userName.text;
      uploadRequest.fields['email'] = email.text;
      uploadRequest.fields['note'] = note.text;

      final streamResponse = await uploadRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: responseData['message']);
      } else {
        setState(() {
          load = false;
        });
        print(responseData['error']);
        print(response.body);
        Fluttertoast.showToast(msg: "Có lỗi khi cập nhật thông tin");
      }
    } catch (e) {
      setState(() {
        load = false;
      });
      print(e);
    }
  }
}
//                          Padding(
//                            padding:
//                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
//                            child: new Row(
//                              mainAxisSize: MainAxisSize.max,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                Expanded(
//                                  child: Container(
//                                    child: new Text(
//                                      'Note',
//                                      style: TextStyle(
//                                          fontSize: 16.0,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                  ),
//                                  flex: 2,
//                                ),
//                                Expanded(
//                                  child: Container(
//                                    child: new Text(
//                                      'Create_at',
//                                      style: TextStyle(
//                                          fontSize: 16.0,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                  ),
//                                  flex: 2,
//                                ),
//                              ],
//                            ),
//                          ),
//                          Padding(
//                              padding: EdgeInsets.only(
//                                  left: 25.0, right: 25.0, top: 2.0),
//                              child: new Row(
//                                mainAxisSize: MainAxisSize.max,
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
//                                  Flexible(
//                                    child: Padding(
//                                      padding: EdgeInsets.only(right: 10.0),
//                                      child: new TextField(
//                                        controller: !_status ? note : "",
//                                        decoration: InputDecoration(
//                                            hintText: note.text),
//                                        enabled: !_status,
//                                      ),
//                                    ),
//                                    flex: 2,
//                                  ),
//                                  Flexible(
//                                    child: new TextField(
//                                      controller: !_status ? create_at : "",
//                                      decoration: InputDecoration(
//                                          hintText: create_at.text),
//                                      enabled: !_status,
//                                    ),
//                                    flex: 2,
//                                  ),
//                                ],
//                              )),
