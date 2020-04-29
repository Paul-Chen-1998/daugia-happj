import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';

class ImageDetail extends StatelessWidget {
  final hinhAnh;

  ImageDetail({this.hinhAnh});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                Server.hinhAnh + hinhAnh,
                fit: BoxFit.cover,
              ),
            ),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
