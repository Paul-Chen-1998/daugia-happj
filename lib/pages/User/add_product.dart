import 'dart:convert';
import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {

  bool loadding = false;
  List<DropdownMenuItem<String>> dropDownCategories;
  List<DropdownMenuItem<String>> dropDownExtraTime;

  String selectedCategory;
  String selectedExtraTime;
  List<File> imageList;

  List<String> categoryList = new List();
  List<String> extraTimeList = new List();

  //Map<int, File> imagesMap = new Map();

  TextEditingController productTitle = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  TextEditingController productDesc = new TextEditingController();
  TextEditingController productStatus = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;
  String idUser;
  getId() async{
    SharedPreferences sharedPreferencess = await SharedPreferences.getInstance();
    String idUserr = sharedPreferencess.getString("_id");
    setState(() {
      idUser = idUserr;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idUser = "";
    getId();
    categoryList = new List.from(localCatgeories);
    dropDownCategories = buildAndGetDropDownItems(categoryList);
    selectedCategory = dropDownCategories[0].value;

    extraTimeList = new List.from(localExtraTime);
    dropDownExtraTime = buildAndGetDropDownItems(extraTimeList);
    selectedExtraTime = dropDownExtraTime[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return !loadding
        ? new Scaffold(
      resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            backgroundColor: Colors.grey,
            appBar: new AppBar(
              flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
              brightness: Brightness.dark,
              backgroundColor: Colors.greenAccent,
              title: Text(
                "Thêm Sản Phẩm",
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 5.0,
                ),
              ),
//              centerTitle: true,
              centerTitle: false,
              elevation: 0.0,
              actions: <Widget>[
                new IconButton(
                    icon: Image.asset("images/miniicon/miniimage.png"),
                    iconSize: 50,
                    onPressed:_onButtonPressed
                )
              ],
            ),
            body: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MultiImagePickerList(
                      imageList: imageList,
                      // ignore: missing_return
                      removeNewImage: (index) {
                        removeImage(index);
                      }),
                  new SizedBox(
                    height: 10.0,
                  ),
                  //name product
                  productTextField(
                      textTitle: "Tên sản phẩm",
                      textHint: "Vd (Iphone X, ThinkPad T470, ... )",
                      controller: productTitle),
                  new SizedBox(
                    height: 10.0,
                  ),

                  productTextField(
                      textTitle: "Giá khởi điểm (VND)",
                      textHint: "Vd (20 000)",
                      textType: TextInputType.number,
                      controller: productPrice),
                  new SizedBox(
                    height: 10.0,
                  ),
                  productTextField(
                      textTitle: "Tình trạng sản phẩm",
                      textHint: "Vd (hàng đã qua sử dụng, hàng còn bảo hành, ...)",
                      controller: productStatus),
                  new SizedBox(
                    height: 10.0,
                  ),
                  productTextField(
                      textTitle: "Mô tả sản phẩm",
                      textHint: "Vd (Máy còn chạy tốt, chưa qua sửa chữa lần nào, trong máy có sẵn AI, ...)",
                      controller: productDesc,
                      height: 180.0),
                  new SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      productDropDown(
                          textTitle: "Danh mục sản phẩm",
                          selectedItem: selectedCategory,
                          dropDownItems: dropDownCategories,
                          changedDropDownItems: changedDropDownCategory),
                      productDropDown(
                          textTitle: "Thời gian đấu giá",
                          selectedItem: selectedExtraTime,
                          dropDownItems: dropDownExtraTime,
                          changedDropDownItems: changedDropDownExtraTime),
                    ],
                  ),
                  appButton(
                      btnTxt: "Thêm sản phẩm",
                      onBtnclicked: addNewProducts,
                      btnPadding: 20.0,
                      btnColor: Theme.of(context).primaryColor),
                  new SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            ),
          )
        : SplashPage();
  }

  List<String> localCatgeories = [
    "Thực phẩm sạch",
    "Hàng nhập khẩu",
    "Thời trang",
    "Điện máy",
    "Bất động sản",
    "Xe cộ",
    "Khác"
  ];
  List<String> categoryId = [
    "5ea69cae18de79407cce3e57",
    "5ea69d27bf173b2170f6b393",
    "5ea69d2ebf173b2170f6b394",
    "5ea69d39bf173b2170f6b395",
    "5ea69d3fbf173b2170f6b396",
    "5ea69d45bf173b2170f6b397"
  ];
  List<String> localExtraTime = [
    "2h",
    "4h",
    "6h",
    "8h",
    "10h",
    "12h",
  ];
  List<String> milliseconds = [
    "7200000",
    "14400000",
    "21600000",
    "28800000",
    "36000000",
    "43200000"
  ];

//  List<int> milliseconds = [
//    2 * 60 * 60 * 1000,
//    4 * 60 * 60 * 1000,
//    6 * 60 * 60 * 1000,
//    8 * 60 * 60 * 1000,
//    10 * 60 * 60 * 1000,
//    12 * 60 * 60 * 1000
//  ];

  convertCategory(String category) {
    for (String item in localCatgeories) {
      if (category == item) {
        return categoryId[localCatgeories.indexOf(category)];
      }
    }
  }

  convertExtraTime(String extraTime) {
    for (String item in localExtraTime) {
      if (extraTime == item) {
        return milliseconds[localExtraTime.indexOf(extraTime)];
      }
    }
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
                    onTap: () => pickImage(ImageSource.camera),
                  ),
                  ListTile(
                    leading: Icon(CommunityMaterialIcons.library_shelves),
                    title: Text('Gallery'),
                    onTap: () {
                      pickImage(ImageSource.gallery);
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

  Widget MultiImagePickerList(
      {List<File> imageList, VoidCallback removeNewImage(int position)}) {
    return new Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: imageList == null || imageList.length == 0
          ? new Container()
          : new SizedBox(
              height: 150.0,
              child: new ListView.builder(
                  itemCount: imageList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return new Padding(
                      padding: new EdgeInsets.only(left: 3.0, right: 3.0),
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                                color: Colors.grey.withAlpha(100),
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(15.0)),
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new FileImage(imageList[index]))),
                          ),
                          new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new CircleAvatar(
                              backgroundColor: Colors.red[600],
                              child: new IconButton(
                                  icon: new Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    removeNewImage(index);
                                  }),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
    );
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownItems(List size) {
    List<DropdownMenuItem<String>> items = new List();
    for (String size in size) {
      items.add(new DropdownMenuItem(value: size, child: new Text(size)));
    }
    return items;
  }

  Widget productTextField(
      {String textTitle,
      String textHint,
      double height,
      TextEditingController controller,
      TextInputType textType}) {
    textTitle == null ? textTitle = "Enter Title" : textTitle;
    textHint == null ? textHint = "Enter Hint" : textHint;
    height == null ? height = 50.0 : height;
    //height !=null

    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            textTitle,
            style:
                new TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Container(
            height: height,
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(color: Colors.white),
                borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
            child: new Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: new TextField(
                autocorrect: false,
                controller: controller,
                keyboardType: textType == null ? TextInputType.text : textType,
                decoration: new InputDecoration(
                    border: InputBorder.none, hintText: textHint),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget productDropDown(
      {String textTitle,
      String selectedItem,
      List<DropdownMenuItem<String>> dropDownItems,
      ValueChanged<String> changedDropDownItems}) {
    textTitle == null ? textTitle = "Enter Title" : textTitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            textTitle,
            style:
                new TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
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
                  child: new DropdownButton(
                value: selectedItem,
                items: dropDownItems,
                onChanged: changedDropDownItems,
              )),
            ),
          ),
        ),
      ],
    );
  }

  void changedDropDownExtraTime(String a) {
    setState(() {
      selectedExtraTime = a;
    });
  }

  void changedDropDownCategory(String a) {
    setState(() {
      selectedCategory = a;
    });
  }

  pickImage(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source);
    if (file != null) {
      //imagesMap[imagesMap.length] = file;
      List<File> imageFile = new List();
      imageFile.add(file);
      //imageList = new List.from(imageFile);
      if (imageList == null) {
        imageList = new List.from(imageFile, growable: true);
      } else {
        for (int s = 0; s < imageFile.length; s++) {
          imageList.add(file);
        }
      }
      setState(() {});
    }
  }

  removeImage(int index) async {
    //imagesMap.remove(index);
    imageList.removeAt(index);
    setState(() {});
  }

  addNewProducts() {
    int timeStampNow = new DateTime.now().millisecondsSinceEpoch;
    String timeStampAfter = (int.parse(convertExtraTime(selectedExtraTime)) + timeStampNow).toString();
    String idType = selectedCategory;
//    print(
//        "product name : ${productTitle.text}\nproduct price : ${productPrice.text}\nproduct status : ${productStatus.text}"
//        "\nproduct description : ${productDesc.text}\nproduct type : $selectedCategory\n"
//        "product time : $selectedExtraTime\nmiliseconds : $timeStampAfter\nid type : $idType");

    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Product Images cannot be empty", scaffoldKey);
      return;
    }
    if (imageList.length > 4) {
      showSnackBar("The product is only a minimum of five photos", scaffoldKey);
      return;
    }
    if (productTitle.text == "") {
      showSnackBar("Product Title cannot be empty", scaffoldKey);
      return;
    }
    if (productTitle.text.length > 100) {
      showSnackBar("Product name cannot be greater than 100 characters", scaffoldKey);
      return;
    }

    if (productPrice.text == "") {
      showSnackBar("Product Price cannot be empty", scaffoldKey);
      return;
    }

    if (productDesc.text == "") {
      showSnackBar("Product Description cannot be empty", scaffoldKey);
      return;
    }

    createProduct(
        imageProduct: imageList,
        idType: selectedCategory,
        nameProduct: productTitle.text,
        description: productDesc.text,
        extraTime: timeStampAfter,
        startPriceProduct: productPrice.text,
        status: productStatus.text);
  }

  showSnackBar(String message, final scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red[600],
      content: new Text(
        message,
        style: new TextStyle(color: Colors.white),
      ),
    ));
  }

  Widget appButton(
      {String btnTxt,
      double btnPadding,
      Color btnColor,
      VoidCallback onBtnclicked}) {
    btnTxt == null ? btnTxt == "App Button" : btnTxt;
    btnPadding == null ? btnPadding = 0.0 : btnPadding;
    btnColor == null ? btnColor = Colors.black : btnColor;

    return Padding(
      padding: new EdgeInsets.all(btnPadding),
      child: new RaisedButton(
        color: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
        onPressed: onBtnclicked,
        child: Container(
          height: 50.0,
          child: new Center(
            child: new Text(
              btnTxt,
              style: new TextStyle(color: btnColor, fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }

  createProduct(
      {String nameProduct,
      String status,
      String description,
      String idType,
      String startPriceProduct,
      String extraTime,
      List<File> imageProduct}) async {
    var dio = new Dio();
    try {
      setState(() {
        loadding = true;
      });
      String url = Server.newProduct + idUser ;
      Uri z = Uri.parse(url);
      final uploadRequest = http.MultipartRequest('POST', z);
      var mimeType;

      imageList.forEach((image) async {
        mimeType =
            lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])
                .split('/');
        uploadRequest.files.addAll([
          await http.MultipartFile.fromPath('imageProduct', image.path,
              contentType: MediaType(mimeType[0], mimeType[1]))
        ]);
      });

      uploadRequest.fields["nameProduct"] = nameProduct;
      uploadRequest.fields["nameProductType"] = idType;
      uploadRequest.fields["startPriceProduct"] = startPriceProduct;
      uploadRequest.fields["status"] = status;
      uploadRequest.fields["description"] = description;
      uploadRequest.fields["extraTime"] = extraTime;


      final streamResponse = await uploadRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData != null) {
          print(responseData['data']);
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "create product successfully");
          setState(() {
            loadding = false;
          });
        } else {
          print('khong co du lieu');
        }
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          loadding = false;
        });
      }
    } catch (e) {
      print('loi');
      print(e);
      setState(() {
        loadding = false;
      });
    }
  }
}
