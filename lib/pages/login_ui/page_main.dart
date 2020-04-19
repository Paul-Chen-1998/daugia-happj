import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutterhappjapp/components/CustomDialog.dart';
import 'package:flutterhappjapp/pages/login_ui/sign_up.dart';
import 'package:flutterhappjapp/pages/page_main/page_main_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'image_carousel_slider.dart';
import 'login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _current = 0;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
   // chectLoginStatus();

  }

//  chectLoginStatus() async {
//    sharedPreferences = await SharedPreferences.getInstance();
//    sharedPreferences.setString("anonymous", "");
//  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    //CarouselSlider
    Widget _imageCarousel = new CarouselSlider(
      items: imagesSlider.map((img) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.green),
              child: new Image.asset(
                img.imgAsset,
                fit: BoxFit.cover,
              ),
//                    new Text(
//                      img.title,
//                      style: new TextStyle(
//                          fontWeight: FontWeight.bold, fontSize: 5),
//                    )
            );
          },
        );
      }).toList(),
      height: 400.0,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 2),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: Duration(seconds: 1),
      enlargeCenterPage: false,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      scrollDirection: Axis.horizontal,
    );

    //Position CarouselSlider
    Widget _positionCarousel = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(imagesSlider, (index, imageAsset) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }),
    );

    Widget _body = new Container(
      constraints: BoxConstraints.expand(),
      //color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                            title: "Bạn muốn tạo tài khoản? ",
                            description:
                                "Tài khoản là miễn phí và sẽ luôn là như vậy!",
                            primaryButtonRoute: "/signup",
                            primaryButtonText: "Create my account",
                            secondaryButtonRoute: "/anonymousSigniIn",
                            secondaryButtonText: "Maybe later",
                          ));
                },
                child: new Text(
                  "SKIP",
                  style: new TextStyle(fontSize: 13, color: Color(0xff888888)),
                ),
              ),
              new RaisedButton(
                onPressed: _onLoginClicked,
                color: Colors.white,
                child: new Text(
                  "Log in",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
              ),
            ],
          ),
          new Container(
            margin: EdgeInsets.only(top: 30),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[_imageCarousel, _positionCarousel],
            ),
          ),
          new SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new RaisedButton(
              color: Colors.green[800],
              onPressed: _onSignUpClicked,
              child: new GestureDetector(
                onTap: _onSignUpClicked,
                child: new Text(
                  "Sign up for an account",
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ),
          new SizedBox(
            height: 10.0,
          ),
          new SizedBox(
            width: double.infinity,
            height: 50.0,
            child: new RaisedButton.icon(
              onPressed: _onCotinueWithFaceBook,
              color: Colors.blue[900],
              icon: new Icon(
                CommunityMaterialIcons.facebook_box,
                color: Colors.white,
              ),
              label: new Text(
                "Continue with Facebook",
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          new SizedBox(
            height: 10.0,
          ),
          new RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: 'By signing up, you agree to our '),
                TextSpan(
                  text: 'Terms of Service ',
                  style: new TextStyle(color: Colors.green[800]),
                ),
                TextSpan(text: 'and '),
                TextSpan(
                  text: 'Privacy Policy.',
                  style: new TextStyle(color: Colors.green[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return new Scaffold(
      //appBar: new AppBar(backgroundColor: Colors.green,),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: _body,
      ),
    );
  }

  void _onLoginClicked() {
    setState(() {
      Navigator.of(context).pushReplacementNamed('/signin');
    });
  }

  void _onSignUpClicked() {
    setState(() {
      Navigator.of(context).pushReplacementNamed('/signup');
    });
  }

  void _onCotinueWithFaceBook() {}
}
