import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final String imageUrl;
  final bool isIconDisplay;
  final double width;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.width,
    this.imageUrl,
    this.isIconDisplay,
    this.textColor = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: width,
        height: 50.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: buttonColor)),
        color: buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isIconDisplay?  Image(
              image: AssetImage(imageUrl),
              height: 25.0,
              width: 25.0,
            ):Container(height: 1.0,width: 1.0,),
            Padding(padding: EdgeInsets.only(left: 10.0),child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),)
          ],
        ),
        elevation: 6.0,
        onPressed: onPressed);
  }
}
