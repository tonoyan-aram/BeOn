import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final bool validate;
  final String hint;
  final String errorText;
  final bool isPassword;
  final int marginTop;
  final TextInputType inputType;
  final int maxLength;
  final int ishint;
  final int isspace;

  CustomTextInput(
      {this.controller,
      this.validate,
      this.hint,
      this.errorText,
      this.isPassword,
      this.marginTop,
      this.inputType,
      this.maxLength,
      this.ishint,
      this.isspace});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * marginTop / 808),
      child: TextField(
        maxLength: maxLength,
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        inputFormatters: isspace == 0
            ? [BlacklistingTextInputFormatter(RegExp(r"\s"))]
            : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 18 / 375),
          filled: true,
          fillColor: kInput,
          helperText: validate ? errorText : null,
          helperStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          labelText: ishint == 0 ? "" : hint,
          counterText: "",

          alignLabelWithHint: true,
          // hintText: hint,
          labelStyle: TextStyle(
              color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.w700),
          hintStyle: TextStyle(
              color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.w700),
          //prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

class CustomTextInputMulti extends StatelessWidget {
  final TextEditingController controller;
  final bool validate;
  final String hint;
  final String errorText;
  final bool isPassword;
  final int marginTop;
  final TextInputType inputType;

  CustomTextInputMulti(
      {this.controller,
      this.validate,
      this.hint,
      this.errorText,
      this.isPassword,
      this.marginTop,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * marginTop / 808),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 3 / 375),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: 32,
              color: kPrimaryColor,
            ),
          ),
          contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 18 / 375),
          filled: true,
          fillColor: kInput,
          helperText: validate ? errorText : null,
          helperStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          labelText: hint,

          alignLabelWithHint: true,
          // hintText: hint,
          labelStyle: TextStyle(
              color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.w700),
          hintStyle: TextStyle(
              color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.w700),
          //prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

class CustomEmailInput extends StatelessWidget {
  final TextEditingController controller;
  final bool validate;
  final String hint;
  final String errorText;
  final bool isPassword;
  final int marginTop;
  final TextInputType inputType;

  CustomEmailInput(
      {this.controller,
      this.validate,
      this.hint,
      this.errorText,
      this.isPassword,
      this.marginTop,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * marginTop / 808),
      child: TextField(
        //validator: validateEmail,
        //onSaved: (value)=> _userName = value,
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 18 / 375),
          filled: true,
          fillColor: kInput,
          helperText: !validate ? errorText : null,
          helperStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          labelText: hint,

          alignLabelWithHint: true,
          // hintText: hint,
          labelStyle: TextStyle(
              color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.w700),
          hintStyle: TextStyle(
              color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.w700),
          //prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

class CustomCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final bool validate;
  final String hint;
  final String errorText;
  final bool isPassword;
  final int marginTop;
  final TextInputType inputType;

  CustomCodeInput(
      {this.controller,
      this.validate,
      this.hint,
      this.errorText,
      this.isPassword,
      this.marginTop,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * marginTop / 808),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: kInput,
      ),
      padding:
          EdgeInsets.only(left: MediaQuery.of(context).size.width * 18 / 375),
      child: TextFormField(
        autofocus: true,
        textAlign: TextAlign.center,
        maxLength: 6,

        //validator: validateEmail,
        //onSaved: (value)=> _userName = value,
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,

        decoration: InputDecoration(
          errorText: validate ? errorText : null,
          border: InputBorder.none,
          hintText: hint,
          counterText: "",
          hintStyle: TextStyle(
              color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w700),
          //prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

class DetailsField extends StatelessWidget {
  final String hint;
  final String title;

  DetailsField({
    this.hint,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 21 / 375),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: kInput,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            height: MediaQuery.of(context).size.width * 45 / 375,
            width: double.infinity,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Positioned(
            left: 10,
            top: -2,
            child: Text(
              hint,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

class DetailsFieldNew extends StatelessWidget {
  final String hint;
  final String title;
  final Function func;

  DetailsFieldNew({this.hint, this.title, this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 21 / 375),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: kInput,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            height: MediaQuery.of(context).size.width * 45 / 375,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: func,
                )
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: -2,
            child: Text(
              hint,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
