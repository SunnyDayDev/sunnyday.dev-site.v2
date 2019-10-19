
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sunnydaydev_site/core/ui/widget_size_tracker.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  
  AnimationController _logoAnimationController;
  
  WidgetSizeTracker _headerSizeTracker = WidgetSizeTracker(GlobalKey());
  
  @override
  void initState() {
    _logoAnimationController =  AnimationController(duration: Duration(seconds: 3), vsync: this);
    _logoAnimationController.repeat();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    _headerSizeTracker.onBuild(context);
    
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0, left: 0, right: 0,
                child: _header,
              ),
              Positioned(
                top: 16,
                left: 32,
                child: _headerTitle,
              ),
              _belowHeaderContent
            ],
          ),
        ),
      ),
    );
  }
  
  Widget get _header => ConstrainedBox(
    key: _headerSizeTracker.key,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height / 2
    ),
    child: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.only(left: 32, right: 32, top: 64, bottom: 128),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _animatedLogo,
              SizedBox(height: 16),
              headerText("Качество, сроки, сопровождение"),
              SizedBox(height: 16),
              headerText("Android/iOS Development", textSize: 32),
              SizedBox(height: 16),
              headerText("Сейчас сайт находится в разработке, ниже предоставлена краткая информация обо мне.")
            ],
          ),
        ),
      ),
    ),
  );
  
  Widget headerText(String text, {double textSize = 16}) {
    return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: textSize, color: Colors.white));
  }
  
  Widget get _animatedLogo => AnimatedBuilder(
    animation: Tween(begin: 0.0, end: 1.0).animate(_logoAnimationController),
    builder: (context, child) => Transform(
      transform: Matrix4.rotationY(_logoAnimationController.value * pi),
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 100,
        child: Image.asset("assets/images/logo.png"),
      ),
    ),
  );
  
  Widget get _headerTitle => Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text("SunnyDay", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
      Text(".Dev", style: TextStyle(fontSize: 18, color: Colors.white))
    ],
  );
  
  Widget get _belowHeaderContent => StreamBuilder(
    initialData: Size.zero,
    stream: _headerSizeTracker.size,
    builder: (context, snapshot) {
      Size size = snapshot.data;
      return size.isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: size.height - 64),
            child: Center(child: _mainContent(),));
    },
  );
  
  Widget _mainContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
          child: _infoCardsContent(),
        )
      ],
    );
  }
  
  Widget _infoCardsContent() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        infoCard(title: "Android", icon: Icons.android, message: "Опыт разработки более 6-х лет. Работал со всем спектром Android SDK, в результате чего имею отличное понимание о «жизни» Андроида и его компонентов. Уважаю Java, люблю Kotlin."),
        infoCard(title: "В общем", icon: Icons.person, message: "Никогда не останавливаюсь на достигнутом и все время совершенствуюсь. Стараюсь быть в курсе текущего состояния дел, слежу за всем что творится в мире мобильной разработки и разработки в целом, посещаю конференции (Mobius, DroidCon, MBLTDev), мечтаю начать контрибьютить в open-source. Всегда открыт чему-то новому."),
        infoCard(title: "iOS", icon: Icons.android, message: "Опыт разработки более 2-х лет. В основном Swift (новые приложения), но также занимался и поддержкой старых приложений написанных на Objective-C.")
      ],
    );
  }
  
  Widget infoCard({
    @required String title,
    @required IconData icon,
    @required String message
  }) => Container(
    width: 380,
    child: Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 48,color: Colors.brown,),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(title, style: TextStyle(fontSize: 20, color: Colors.brown),),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 64, top: 16),
              child: Text(message),
            )
          ],
        ),
      ),
    ),
  );
  
  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }
  
}