import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactButton extends StatelessWidget {
  final VoidCallback onPress;
  final IconData icon;
  final String text;

  const ContactButton({Key key,
    this.onPress,
    @required this.icon,
    @required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPress,
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
  }
}
