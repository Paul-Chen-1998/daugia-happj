

import 'package:flutter/material.dart';
class chitietsanpham extends StatefulWidget {
  final tenchitietsanpham;
  final giachitietsanpham;
  final hinhanhchitietsanpham;

  chitietsanpham({
    this.tenchitietsanpham,
    this.giachitietsanpham,
    this.hinhanhchitietsanpham,
});

  @override
  _chitietsanphamState createState() => _chitietsanphamState();
}

class _chitietsanphamState extends State<chitietsanpham> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("Happj App"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),

      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.hinhanhchitietsanpham),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(widget.tenchitietsanpham,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${widget.giachitietsanpham} \ VND  ",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
          // ======= the first buttons =======
          Row(
            children: <Widget>[
              // ====== the size button ======
              Expanded(
                child: MaterialButton(onPressed: (){},
                color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Số Lượng")
                      ),
                      Expanded(
                          child: new Icon(Icons.arrow_drop_down)
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: null);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text(("Mua ngay")
                  ),
                ),
              ),
//asdsadasdzczxczxcxz
              new IconButton(icon: Icon(Icons.add_shopping_cart), color: Colors.red, onPressed: (){}),
              new IconButton(icon: Icon(Icons.favorite_border), color: Colors.red, onPressed: (){}),
            ],
          )
        ],
      ),
    );
  }
}
