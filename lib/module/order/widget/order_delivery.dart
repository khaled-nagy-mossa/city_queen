import 'dart:developer';

import 'package:app_launcher/app_launcher.dart';
import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets/assets.dart';
import '../../../common/config/api.dart';
import '../../../common/const/app_data.dart';
import '../../../model/order/order_delivery_man.dart';
import '../../../widget/custom_shadow.dart';
import '../../chat/cubit/chat/cubit.dart';
import '../../chat/model/chat_user.dart';
import '../../chat/view/conversation.dart';

class OrderDeliveryListTile extends StatelessWidget {
  final OrderDeliveryMan delivery;
  final bool showContactData;

  const OrderDeliveryListTile(
      {@required this.delivery, this.showContactData = false, Key key})
      : assert(delivery != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (delivery == null || delivery.unusable) return const SizedBox();

    return Column(
      children: [
        Text('Delivery', style: Theme.of(context).textTheme.headline6),
        CustomShadow(
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: Container(
                constraints:
                    const BoxConstraints(maxHeight: 55.0, maxWidth: 55.0),
                decoration: BoxDecoration(
                  gradient: AppData.customGradient,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(API.imageUrl(delivery.image)),
                  ),
                ),
              ),
              title: Text(
                delivery?.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(delivery?.email ?? ''),
              trailing: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _contactItem(
                      onTap: () {
                        AppLauncher.launchToPhone(delivery?.phone ?? '');
                      },
                      svgPath: Assets.images.telephone,
                    ),
                    _contactItem(
                      onTap: () async {
                        log(delivery?.id?.toString());
                        final cubit = ChatCubit.get(context);

                        final conversation = await cubit.startChatWith(
                          ChatUser(
                            id: delivery.id.toString(),
                            name: delivery.name,
                            avatar: API.imageUrl(delivery.image),
                          ),
                        );
                        if (conversation != null && conversation.usable) {
                          await AppRoutes.push(
                            context,
                            ConversationView(conversation: conversation),
                          );
                        }
                      },
                      svgPath: Assets.images.chat,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactItem({
    @required VoidCallback onTap,
    @required String svgPath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          gradient: AppData.customGradient,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(svgPath, color: Colors.white, width: 22.0),
      ),
    );
  }
}
