import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:softgrow/common/assets/assets.dart';
import 'package:softgrow/module/home/view/home.dart';
import 'package:softgrow/shared_widgets/language/language_controller.dart';
import 'package:softgrow/shared_widgets/language/supported_locale.dart';
import '../../../widget/custom_shadow.dart';

List<SupportedLocaleModel> supportedLocalesItems = [
  SupportedLocaleModel(
      langCode: 'ar', nativeName: 'عربى', image: Assets.images.egypt),
  SupportedLocaleModel(
      langCode: 'en', nativeName: 'English', image: Assets.images.us),
];

class LanguageWidget extends StatelessWidget {
  const LanguageWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (LanguageController controller) => Scaffold(
              appBar: AppBar(
                title: Text('Language'.tr),
                leading: IconButton(
                    onPressed: () {
                      Get.offAll(() => const HomeView());
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey[800],
                    )),
              ),
              body: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Choose Language'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomShadow(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 0.0,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                controller.changeLanguage();
                              },
                              leading: Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 55.0,
                                  maxWidth: 55.0,
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                    supportedLocalesItems[index].image),
                              ),
                              title:
                                  Text(supportedLocalesItems[index].nativeName),
                              trailing: Get.locale.languageCode ==
                                      supportedLocalesItems[index].langCode
                                  ? SvgPicture.asset(
                                      Assets.images?.done,
                                      height: 25.0,
                                      width: 25.0,
                                    )
                                  : const SizedBox(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
