import 'package:app_routes/app_routes.dart';
import 'package:code_fields/code_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';
import '../../home/view/home.dart';

//ignore: must_be_immutable
class OTPView extends StatelessWidget {
  OTPView({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const int codeLength = 4;
  String code;

  String validateCode(String code) {
    if (code.length < codeLength) {
      return 'Please complete the code'.tr;
    } else {
      final isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return 'Please enter a valid code'.tr;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmation'.tr)),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              CodeFields(
                length: codeLength,
                validator: validateCode,
                onChanged: (value) {
                  code = value;
                },
                inputDecoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState.validate()) {
                  //   _formKey.currentState.save();
                  //   log('Code : $code'.tr;
                  // }
                  AppRoutes.push(context, const HomeView());
                },
                child: Text('Continue'.tr),
              ).toGradient(context),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "don't get it?".tr,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Resend code'.tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
