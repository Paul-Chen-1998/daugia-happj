import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/User/HoSo.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class VeUngDung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HoSo()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Mục đích ứng dụng",
          body: "Là khóa luận và có thể cũng là sản phẩm cuối ứng dụng cùng trong thời sinh viên của tụi em.",
          image: Center(
            child: Image.asset("images/aboutus/student.png", width: 350.0,height: 200),
          ),
        ),
        PageViewModel(
          title: "Khó khăn",
          body: "Trong mùa covid nên không thể tương tác nhiều với nhau nên ứng dụng tụi em còn thiếu sót",
          image: Center(
            child: Image.asset("images/aboutus/covid.png", width: 350.0,height: 200),
          ),
        ),
        PageViewModel(
          title: "Sản phẩm",
          body: "Nhưng nhóm em vẫn hoàn thanh được những chức năng cơ bản trên ứng dụng và nó hoàn toàn là công sức của nhóm chúng em",
          image: Center(
            child: Image.asset("images/aboutus/bid.png", width: 350.0,height: 200),
          ),
        ),
        PageViewModel(
          title: "Hiện tại",
          body: "Tuy ứng dụng chưa phải tốt nhất nhưng tụi em vẫn sẽ hoàn thiện những tính năng còn thiếu trong tương lai để đưa lên store",
          image: Center(
            child: Image.asset("images/aboutus/scores.png", width: 350.0,height: 200),
          ),
        ),
        PageViewModel(
          title: "Tương lai",
          body: "Tụi em hy vọng với kiến thức tích lũy từ ứng dụng này có thể sẽ giúp nhóm kiếm được công việc tốt trong tương lai",
          image: Center(
            child: Image.asset("images/aboutus/job.png", width: 350.0,height: 200),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

