import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  List<DropdownMenuItem<String>> dropDownColors;
  String selectedColor;
  List<String> colorList = new List();

  List<DropdownMenuItem<String>> dropDownSizes;
  String selectedSize;
  List<String> sizeList = new List();

  List<DropdownMenuItem<String>> dropDownCategories;
  String selectedCategory;
  List<String> categoryList = new List();

  //Map<int, File> imagesMap = new Map();

  TextEditingController prodcutTitle = new TextEditingController();
  TextEditingController prodcutPrice = new TextEditingController();
  TextEditingController prodcutDesc = new TextEditingController();

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorList = new List.from(localColors);
    sizeList = new List.from(localSizes);
    categoryList = new List.from(localCatgeories);
    dropDownColors = buildAndGetDropDownItems(colorList);
    dropDownSizes = buildAndGetDropDownItems(sizeList);
    dropDownCategories = buildAndGetDropDownItems(categoryList);
    selectedColor = dropDownColors[0].value;
    selectedSize = dropDownSizes[0].value;
    selectedCategory = dropDownCategories[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text("Add Products"),
        centerTitle: false,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new RaisedButton.icon(
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    new BorderRadius.all(new Radius.circular(15.0))),
                onPressed: () => pickImage(),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: new Text(
                  "Add Images",
                  style: new TextStyle(color: Colors.white),
                )),
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
                removeNewImage: (index) {
                  removeImage(index);
                }),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Product Title",
                textHint: "Enter Product Title",
                controller: prodcutTitle),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Product Price",
                textHint: "Enter Product Price",
                textType: TextInputType.number,
                controller: prodcutPrice),
            new SizedBox(
              height: 10.0,
            ),
            productTextField(
                textTitle: "Product Description",
                textHint: "Enter Description",
                controller: prodcutDesc,
                height: 180.0),
            new SizedBox(
              height: 10.0,
            ),
            productDropDown(
                textTitle: "Product Category",
                selectedItem: selectedCategory,
                dropDownItems: dropDownCategories,
                changedDropDownItems: changedDropDownCategory),
            new SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                productDropDown(
                    textTitle: "Color",
                    selectedItem: selectedColor,
                    dropDownItems: dropDownColors,
                    changedDropDownItems: changedDropDownColor),
                productDropDown(
                    textTitle: "Size",
                    selectedItem: selectedSize,
                    dropDownItems: dropDownSizes,
                    changedDropDownItems: changedDropDownSize),
              ],
            ),
            new SizedBox(
              height: 20.0,
            ),
            appButton(
                btnTxt: "Add Product",
                onBtnclicked: addNewProducts,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  List<String> localColors = [
    "Select a color",
    "All Colors",
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Indigo",
    "Violet"
  ];

  List<String> localSizes = [
    "Select a size",
    "All Sizes",
    "Small",
    "Meduim",
    "Large",
    "Extra Large"
  ];

  List<String> localCatgeories = [
    "Select Product category",
    "Tops",
    "Shirts",
    "Shoes",
    "Bom-shorts",
    "Jeans",
    "Bags",
    "Make-ups"
  ];

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
              return new Padding
                (
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

  void changedDropDownColor(String selectedSize) {
    setState(() {
      selectedColor = selectedSize;
    });
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
    });
  }

  void changedDropDownSize(String selected) {
    setState(() {
      selectedSize = selected;
    });
  }

  List<File> imageList;

  pickImage() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
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
    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Product Images cannot be empty", scaffoldKey);
      return;
    }

    if (prodcutTitle.text == "") {
      showSnackBar("Product Title cannot be empty", scaffoldKey);
      return;
    }

    if (prodcutPrice.text == "") {
      showSnackBar("Product Price cannot be empty", scaffoldKey);
      return;
    }

    if (prodcutDesc.text == "") {
      showSnackBar("Product Description cannot be empty", scaffoldKey);
      return;
    }

    if (selectedCategory == "Select Product category") {
      showSnackBar("Please select a category", scaffoldKey);
      return;
    }

    if (selectedColor == "Select a color") {
      showSnackBar("Please select a color", scaffoldKey);
      return;
    }

    if (selectedSize == "Select a size") {
      showSnackBar("Please select a size", scaffoldKey);
      return;
    }

    Map newProduct = {};
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
}
