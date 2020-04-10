import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;
  final Color tintColor;

  const InfoCard({
    Key key,
    @required this.title,
    @required this.text,
    @required this.icon,
    this.tintColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tintColor = this.tintColor ?? Theme.of(context).accentColor;

    return Container(
      width: 380,
      child: Card(
        elevation: 8,
        //shadowColor: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, size: 48,color: tintColor,),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(title,
                        style: TextStyle(fontSize: 20, color: tintColor)),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 64, top: 16),
                child: Text(text),
              )
            ],
          ),
        ),
      ),
    );
  }
}
