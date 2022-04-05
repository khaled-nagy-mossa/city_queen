import 'package:flutter/material.dart';
import 'package:softgrow/util/style.dart';

class ButtonW extends StatefulWidget {
  final String buttonName;

  final double width;
  final double height;
  final VoidCallback function;

  final bool cancel;
  final bool isGradient;

  ButtonW(
      {this.buttonName,
      this.height,
      this.width,
      this.function,
      this.cancel = false,
      this.isGradient = false});
  @override
  _ButtonWState createState() => _ButtonWState();
}

class _ButtonWState extends State<ButtonW> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.cancel == false ? primaryColor : hintTextFildColor,
            borderRadius: BorderRadius.circular(16),
            gradient: widget.isGradient == true
                ? const LinearGradient(
                    colors: [
                      Color.fromRGBO(32, 165, 170, 1.0),
                      Color.fromRGBO(25, 152, 116, 1.0)
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  )
                : null),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Text(
                  widget.buttonName,
                  style: widget.isGradient
                      ? normalTextStyleThird
                      : const TextStyle(
                          color: wightColor,
                          fontFamily: "Dubai",
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
