import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.amber,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 1.0),
  ),
);

const textInputDecorationDropdown = InputDecoration(
  fillColor: Colors.pink,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 1.0),
  ),
);

BoxDecoration boxBorder = new BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border.all(width: 5.0, color: Colors.deepOrangeAccent[100]),
);

Image kitchenLogo = new Image(
    image: new ExactAssetImage("images/mykitchen.png"),
    height: 30.0,
    width: 25.0,
    //color: Colors.transparent,
    colorBlendMode: BlendMode.hardLight,
    alignment: FractionalOffset.centerLeft);

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.all(5.0),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: isPassword ? true : false,
      validator: validator,
      onSaved: onSaved,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 10;
  static const double avatarRadius = 0;
}
