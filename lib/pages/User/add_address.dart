import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/City.dart';
import 'package:flutterhappjapp/model/District.dart';
import 'package:flutterhappjapp/model/Ward.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddAdress extends StatefulWidget {
  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;

  City selectedCity;
  List<City> listCity = new List();

  District selectedDistrict;
  List<District> listDistrict = new List();

  Ward selectedWard;
  List<Ward> listWard = new List();

  String diaChi;

  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getListCity();
    //dropDownCity = buildAndGetDropDownItems(listCity);
    // selectedCity = dropDownCity[0].value;
  }

  Future<List> getWard(District district) async {
    String url = Server.getWard + selectedDistrict.id.toString() + "/ward";
    var response = await http.get(url);
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<List> getDistrict(City city) async {
    String url = Server.getDistrict + city.id.toString() + "/district";
    var response = await http.get(url);
    var jsonResponse = json.decode(response.body);
    //print(jsonResponse['LtsItem'][0]);
    //listCity.addAll(jsonResponse['LtsItem']);
    //print(listCity[0]['Title']);
    return jsonResponse;
  }

  Future<List> getListCity() async {
    String url = Server.getCity;
    var response = await http.get(url);
    var jsonResponse = json.decode(response.body);
    //print(jsonResponse['LtsItem'][0]);
    //listCity.addAll(jsonResponse['LtsItem']);
    //print(listCity[0]['Title']);
    return jsonResponse['LtsItem'];
  }

  Widget dropDownWard({String textTitle, Ward selectedItem, List<Ward> list}) {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Text(
              textTitle,
              style: new TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(color: Colors.white),
                  borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<Ward>(
                    value: selectedItem,
                    items: list.map((Ward item) {
                      return DropdownMenuItem<Ward>(
                        value: item,
                        child: Text(item.title),
                      );
                    }).toList(),
                    onChanged: (Ward value) {
                      setState(() {
                        selectedWard = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  Widget dropDownDistrict(
      {String textTitle, District selectedItem, List<District> list}) {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Text(
              textTitle,
              style: new TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(color: Colors.white),
                  borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<District>(
                    value: selectedItem,
                    items: list.map((District item) {
                      return DropdownMenuItem<District>(
                        value: item,
                        child: Text(item.title),
                      );
                    }).toList(),
                    onChanged: (District value) {
                      setState(() {
                        selectedWard = null;
                        listWard.clear();
                        selectedDistrict = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  Widget dropDownCity({String textTitle, City selectedItem, List<City> list}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(0.0),
          child: new Text(
            textTitle,
            style:
                new TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(color: Colors.white),
                borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: new DropdownButtonHideUnderline(
                child: new DropdownButton<City>(
                  value: selectedItem,
                  items: list.map((City item) {
                    return DropdownMenuItem<City>(
                      value: item,
                      child: Text(item.title),
                    );
                  }).toList(),
                  onChanged: (City value) {
                    setState(() {
                      listDistrict.clear();
                      selectedDistrict = null;
                      selectedCity = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return load ? SplashPage() : Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add address'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              updateAddress(
                  diaChi, selectedCity, selectedWard, selectedDistrict);
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _textFields(
                hintText: "Địa chỉ", obscure: false, paddingBottom: 15.0),
            FutureBuilder<List>(
              future: getListCity(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  print(snapshot.error);
                else if (snapshot.hasData) {
                  for (var item in snapshot.data) {
                    listCity.add(City.fromJson(item));
                  }
                  return dropDownCity(
                      textTitle: "City",
                      selectedItem: selectedCity,
                      list: listCity);
                } else {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            selectedCity != null
                ? FutureBuilder<List>(
                    future: getDistrict(selectedCity),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        print(snapshot.error);
                      else if (snapshot.hasData) {
                        print("asdsad");
                        for (var item in snapshot.data) {
                          listDistrict.add(District.fromJson(item));
                        }
                        return dropDownDistrict(
                            textTitle: "District",
                            selectedItem: selectedDistrict,
                            list: listDistrict);
                      } else {
                        return Container(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                : Container(),
            selectedDistrict != null
                ? FutureBuilder<List>(
                    future: getWard(selectedDistrict),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        print(snapshot.error);
                      else if (snapshot.hasData) {
                        print("asdsad");
                        for (var item in snapshot.data) {
                          listWard.add(Ward.fromJson(item));
                        }
                        return dropDownWard(
                            textTitle: "Ward",
                            selectedItem: selectedWard,
                            list: listWard);
                      } else {
                        return Container(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  updateAddress(String diachi, City city, Ward ward, District district) async {
    if (!validation()) {
      return;
    }
    setState(() {
      load = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("_id");
    String url = Server.updateAddress + id;
    String address = diachi.trim() +
        ", " +
        ward.title +
        ", " +
        district.title +
        ", " +
        city.title;

    Map data = {
      "addressUser": address
    };
    var response =await http.put(url, body:data);
    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      print("update address success");
      sharedPreferences.setString("address", address);
      Navigator.of(context).pop();
    }
  }

  List<Widget> listTextFields() {
    List<Widget> list = [];
    //list.add(_titleFields(title: "City"));
    //list.add(productDropDown(dropDownItems: dropDownCity,selectedItem: selectedCity,textTitle: "City"));
    return list;
  }

  showSnackBar(String message, final scaffoldKey, Color color) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: new TextStyle(color: Colors.white),
      ),
    ));
  }

  Widget _titleFields({String title}) {
    return Padding(
        padding: EdgeInsets.only(left: 0, right: 25.0, top: 25.0),
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

  Widget _textFields(
      {String hintText,
      bool obscure,
      TextEditingController controller,
      double paddingBottom}) {
    return Padding(
        padding:
            EdgeInsets.only(left: 0, right: 0, top: 0, bottom: paddingBottom),
        child: Container(
          child: new TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
            ),
            enabled: true,
            obscureText: obscure,
            onChanged: (value) => diaChi = value,
          ),
        ));
  }

  bool validation() {
    if (diaChi == null) {
      showSnackBar("Address cannot empty", scaffoldKey, Colors.red[600]);
      return false;
    }
    if (selectedCity == null) {
      showSnackBar("Please choose city", scaffoldKey, Colors.red[600]);
      return false;
    }
    if (selectedDistrict == null) {
      showSnackBar("Please choose District", scaffoldKey, Colors.red[600]);
      return false;
    }
    if (selectedWard == null) {
      showSnackBar("Please choose Ward", scaffoldKey, Colors.red[600]);
      return false;
    }
    return true;
  }
}
