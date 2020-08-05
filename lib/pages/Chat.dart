import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutterhappjapp/model/message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controll extends StatefulWidget {
  final String keyy;

  Controll({this.keyy});

  @override
  _ControllState createState() => _ControllState();
}

class _ControllState extends State<Controll> {
  DatabaseReference itemRef;
  String idUser;
  List<Message> listMessage = new List();

  getNameAndID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //name = sharedPreferences.getString('name');
    setState(() {
      idUser = sharedPreferences.getString('_id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idUser = "";
    getNameAndID();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: itemRef.orderByKey().equalTo(widget.keyy).onValue,
                // ignore: missing_return
                builder: (context, snapshot) {
                  // ignore: missing_return
                  if (snapshot.hasError) {
                    print("has error");
                    print(snapshot.error);
                  }
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    listMessage.clear();
                    print('begin mesage');
                    Map data = snapshot.data.snapshot.value;
                    data.forEach((index, data) {
                      if ((DateTime.now().millisecondsSinceEpoch -
                              int.parse(data['extraTime']) >
                          0)) {
                        bool check = data['messages'] == null;
                        if (!check) {
                          List message = new List();
                          message.addAll(data['messages']);
                          print(message);
                          for (var item in message) {
                            listMessage.add(Message(
                                unread: item['unread'],
                                time: item['time'],
                                sender: item['sender'],
                                isLiked: item['isliked'],
                                text: item['text']));
                          }
                          for(var item in listMessage){
                            print(item.text);
                          }
                        }
                      }
                    });
                    return Flexible(
                        child: ChatScreen(
                      messages: listMessage,
                      keyy: widget.keyy,
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 550,
                      child: new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}

class ChatScreen extends StatefulWidget {
  List<Message> messages;
  String keyy;

  ChatScreen({this.messages, this.keyy});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textMessageController = TextEditingController();
  bool _isComposing = false;
  DatabaseReference itemRef;
  String idUser;
  List<Message> _message = new List();

  getNameAndID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //name = sharedPreferences.getString('name');
    setState(() {
      idUser = sharedPreferences.getString('_id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _message.addAll(widget.messages);
    idUser = "";
    getNameAndID();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
  }

  _buildMessage(Message message, bool isMe) {
    final Widget msg = Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        margin: isMe
            ? EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 80.0,
              )
            : EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: isMe
              ? AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR_ACTION)
              : AppConstants.hexToColor(
                  AppConstants.APP_BACKGROUND_COLOR_WHITE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white60 : Colors.blueGrey,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.time,
                  style: TextStyle(
                    color: isMe ? Colors.white60 : Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Row(
      children: <Widget>[msg],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "Chức năng này đang hoàn thiện");
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 25.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(15.0),
          ),
          Expanded(
            child: TextField(
              controller: _textMessageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                hintText: 'Type your message...',
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: _isComposing
                ? () => _handleSubmitted(_textMessageController.text)
                : null,
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textMessageController.clear();
    print('start');
    setState(() {
      _isComposing = false;
    });
    var timeStampNow = new DateTime.now().millisecondsSinceEpoch;
    var time = DateTime.fromMicrosecondsSinceEpoch(timeStampNow * 1000);
    String timenow = "${time.hour.toString()}:${time.minute.toString()}";
    Message z = Message(
      sender: idUser,
      time: timenow,
      text: text,
      isLiked: true,
      unread: false,
    );
    _message.clear();
    _message.addAll(widget.messages);
    setState(() {
      _message.insert(0, z);
    });


    List asd = new List();

    for(var item in _message){
      asd.add({
      "unread": item.unread,
      "time": item.time,
      "sender": item.sender,
      "isLiked": item.isLiked,
      "text": item.text
      });
    }

    itemRef.child(widget.keyy).update({"messages": asd}).then((_) {
      print('sucees');
      setState(() {

      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.only(top: 15.0),
                itemCount: widget.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final Message message = widget.messages[index];
                  final bool isMe = message.sender == idUser;

                  return _buildMessage(message, isMe);
                },
              ),
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }
}
