import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softgrow/common/assets/assets.dart';
import 'package:softgrow/module/auth/auth_observer/auth_builder.dart';
import 'package:softgrow/module/wallet/wallet_controller.dart';
import 'package:softgrow/shared_widgets/button_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen();

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: GetBuilder<WalletController>(
          init: WalletController(),
          builder: (WalletController controller) => Scaffold(
              backgroundColor: Colors.grey[50],
              appBar: AppBar(
                  title: Text('Wallet',
                      style: TextStyle(color: Colors.grey[800]))),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                    ),
                    Container(
                      width: Get.width,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey[800], blurRadius: 5.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "EGP 350",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Available credit",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 22,
                    ),
                    ButtonW(
                      buttonName: "Top Up Credit",
                      height: 50,
                      width: Get.width,
                      function: () {},
                    ),
                    Container(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Text(
                          "Cards",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: 16,
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey[800], blurRadius: 5.0)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.asset("assets/images/visa.png"),
                                title: Text(
                                  "50000000000000",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[800],
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
