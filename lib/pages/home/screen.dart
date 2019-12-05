
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sunnydaydev_site/core/platform_detect/platform_detect.dart';
import 'package:sunnydaydev_site/core/ui/widget_size_tracker.dart';
import 'package:sunnydaydev_site/pages/home/bloc.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  
  AnimationController _logoAnimationController;
  
  WidgetSizeTracker _headerSizeTracker = WidgetSizeTracker(GlobalKey());
  
  HomeBloc _bloc;
  
  @override
  void initState() {
    _bloc = HomeBloc(context);
    _logoAnimationController =  AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    _logoAnimationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _bloc.close();
    super.dispose();
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
                top: MediaQuery.of(context).padding.top + 16,
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

  Widget get _animatedLogo {
    final image = Image.asset("assets/images/logo.png");

    return Container(
      width: 100,
      height: 100,
      child: _animatedRotation(image)
    );
  }

  Widget _animatedRotation(Widget widget) => AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut
      ),
      builder: (context, child) => Transform.rotate(angle: pi - pi/16 + pi/8 * _logoAnimationController.value, child: widget)
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
            child: Center(child: _mainContent,));
    },
  );
  
  Widget get _mainContent {
    final mainContentElements = <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
        child: _infoCardsContent,
      ),
      Text("Контакты", style: TextStyle(fontSize: 20, color: Colors.brown)),
      Padding(
        padding: EdgeInsets.all(32),
        child: _contacts,
      )
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: PlatformDetect.isBrowser
        ? mainContentElements + [_footer]
        : mainContentElements
    );
  }
  
  Widget get _infoCardsContent => StreamBuilder(
    stream: _bloc.infos,
    builder: (context, snapshot) {
      List<InfoItem> items = snapshot.data ?? List();
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: items.map((item) =>
          _infoCard(title: item.title, icon: item.icon, message: item.message))
          .toList(),
      );
    }
  );
  
  Widget _infoCard({
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
                  child: Text(title,
                    style: TextStyle(fontSize: 20, color: Colors.brown)),
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
  
  Widget get _contacts => StreamBuilder(
    stream: _bloc.contacts,
    builder: (context, snapshot) {
      final List<ContactItem> items = snapshot.data ?? List();
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 32,
        children: items.map((item) => _contact(
          icon: item.icon,
          text: item.value,
          onTap: () {
            _bloc.add(ContactSelected(item));
          }))
          .toList()
      );
    },
  );
  
  Widget _contact({
    @required IconData icon,
    @required String text,
    @required Function() onTap
  }) => InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.all(16),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 48),
          Text(text)
        ],
      ),
    ),
  );
  
  Widget get _footer => Container(
    color: Colors.black,
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("© ${DateTime.now().year} SunnyDay.Dev",
          style: TextStyle(color: Colors.white),)
      ],
    ),
  );
  
}