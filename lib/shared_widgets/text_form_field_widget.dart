import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:softgrow/util/style.dart';

class TextFormFieldW extends StatefulWidget {
  final TextInputType textInputType;
  TextEditingController controller;
  String Function(String) validator;
  String hintText;
  bool isPrice;
  bool isphone;
  TextFormFieldW(
      {this.textInputType,
      this.controller,
      this.validator,
      this.hintText,
      this.isPrice = false,
      this.isphone = false});
  @override
  _TextFormFieldWState createState() => _TextFormFieldWState();
}

class _TextFormFieldWState extends State<TextFormFieldW> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border:
          //     Border.all(width: 1, color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(8),
          color: wightColor),
      height: 50,
      child: Row(
        textDirection: ui.TextDirection.ltr,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(193, 194, 202, 1.0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                style: normalTextStyleblack,
                keyboardType: widget.textInputType,
                textDirection: widget.isphone == true
                    ? ui.TextDirection.ltr
                    : ui.TextDirection.rtl,
                controller: widget.controller,
                validator: widget.validator,
                decoration: InputDecoration(
                  suffix: widget.isPrice == true
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "SAR",
                            style: normalTextStyleblack,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      right: 16.0, top: 0.0, left: 16, bottom: 0),
                  hintText: widget.hintText,
                  hintStyle: hintTextFildStyle,
                  errorStyle: const TextStyle(
                      fontSize: 14.0, color: Colors.red, fontFamily: 'Tajawal'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
