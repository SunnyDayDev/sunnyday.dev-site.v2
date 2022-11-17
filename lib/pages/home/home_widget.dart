import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sunnydaydev_site/core/platform_detect/platform_detect.dart';
import 'package:sunnydaydev_site/core/ui/widget_size_tracker.dart';
import 'package:sunnydaydev_site/domain/about_me/about_me_models.dart';
import 'package:sunnydaydev_site/pages/home/bloc.dart';
import 'package:sunnydaydev_site/widgets/contact_button.dart';
import 'package:sunnydaydev_site/widgets/info_card.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  late AnimationController _logoAnimationController;

  late HomeBloc _bloc;

  final WidgetSizeTracker _headerSizeTracker = WidgetSizeTracker(GlobalKey());

  @override
  void initState() {
    _bloc = HomeBloc();
    _logoAnimationController =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    _logoAnimationController.repeat(reverse: true);

    super.initState();

    _bloc.initState();
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
                top: 0,
                left: 0,
                right: 0,
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
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height / 2),
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
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
                  headerText('Качество, сроки, сопровождение'),
                  SizedBox(height: 16),
                  headerText('Android/iOS Development', textSize: 32),
                  SizedBox(height: 16),
                  headerText(
                      'Сейчас сайт находится в разработке, ниже предоставлена краткая информация обо мне.')
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
    final image = Image.asset('assets/images/logo.png');

    return Container(width: 100, height: 100, child: _animatedRotation(image));
  }

  Widget _animatedRotation(Widget widget) => AnimatedBuilder(
      animation: CurvedAnimation(
          parent: _logoAnimationController,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut),
      builder: (context, child) =>
          Transform.rotate(angle: _animatedLogoAngle(), child: widget));

  double _animatedLogoAngle() =>
      pi - pi / 16 + pi / 8 * _logoAnimationController.value;

  Widget get _headerTitle => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'SunnyDay',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text('.Dev', style: TextStyle(fontSize: 18, color: Colors.white))
        ],
      );

  Widget get _belowHeaderContent => StreamBuilder<Size>(
        initialData: Size.zero,
        stream: _headerSizeTracker.size,
        builder: (context, snapshot) {
          var size = snapshot.data;
          if (size == null) {
            return Container();
          }
          return size.isEmpty ? Container() : _mainContent(size.height);
        },
      );

  Widget _mainContent(double headerHeight) => StreamBuilder<bool>(
        stream: _bloc.isLoading,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? true;
          return isLoading
              ? _loadingIndicatorBelowHeader(headerHeight)
              : _loadedContentBelowHeader(headerHeight);
        },
      );

  Widget _loadingIndicatorBelowHeader(double headerHeight) => Padding(
      padding: EdgeInsets.only(top: headerHeight),
      child: Container(
        height: max(MediaQuery.of(context).size.height - headerHeight, 92),
        width: MediaQuery.of(context).size.width,
        child: Center(child: CircularProgressIndicator()),
      ));

  Widget _loadedContentBelowHeader(double headerHeight) => Padding(
      padding: EdgeInsets.only(top: headerHeight - 64),
      child: Center(child: _loadedContent));

  Widget get _loadedContent {
    final mainContentElements = <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 64),
        child: _infoCardsContent,
      ),
      Text('Контакты',
          style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor)),
      Padding(
        padding: EdgeInsets.all(32),
        child: _contacts,
      )
    ];

    return Column(
        mainAxisSize: MainAxisSize.min,
        children: PlatformDetect.isBrowser
            ? mainContentElements + [_footer]
            : mainContentElements);
  }

  Widget get _infoCardsContent => StreamBuilder<List<InfoItem>?>(
      stream: _bloc.infos,
      builder: (context, snapshot) {
        var items = snapshot.data ?? List.empty();
        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: items
              .map((item) => InfoCard(
                  title: item.title, icon: item.icon, text: item.message))
              .toList(),
        );
      });

  Widget get _contacts => StreamBuilder<List<ContactItem>>(
        stream: _bloc.contacts,
        builder: (context, snapshot) {
          final items = snapshot.data ?? List.empty();

          return Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 32,
              children: items.map(_contactButton).toList());
        },
      );

  Widget _contactButton(ContactItem item) => ContactButton(
      icon: item.icon,
      text: item.value,
      onPress: () => _bloc.add(ContactSelected(item)));

  Widget get _footer => Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              '© ${DateTime.now().year} SunnyDay.Dev',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
}
