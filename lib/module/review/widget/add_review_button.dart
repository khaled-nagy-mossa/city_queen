import 'package:flutter/material.dart';
import '../../../widget/elevated_button_extension.dart';
import 'package:get/get.dart';

class AddReviewButton extends StatelessWidget {
  final VoidCallback onPressed;
  final EdgeInsets margin;

  const AddReviewButton({@required this.onPressed, this.margin})
      : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          minimumSize: const Size(0.0, 45.0),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Theme.of(context).primaryColor),
            Text(
              'Write a Review'.tr,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ).toGradient(context),
    );
  }
}
