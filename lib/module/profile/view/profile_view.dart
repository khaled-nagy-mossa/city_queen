import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/const/app_data.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../global/view/exception_view.dart';
import '../../global/view/not_authorized_view.dart';
import '../cubit/account/cubit.dart';
import '../cubit/account/cubit_extension.dart';
import '../cubit/account/states.dart';
import '../widget/image_profile_view.dart';
import 'change_password.dart';
import 'edit_profile.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  static const routeName = '/profile_view';

  const ProfileView();

  static const _sizedBox = SizedBox(height: 20.0, width: 20.0);
  static const _fieldPadding = SizedBox(height: 10.0, width: 10.0);

  @override
  Widget build(BuildContext context) {
    final cubit = AccountCubit.get(context);

    return AuthListener(
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (cubit?.signed != true) return const NotAuthorizedView();

          try {
            return Stack(
              children: [
                Scaffold(
                  appBar: DefaultAppBar(
                      title: Text(
                    cubit?.user?.data?.name ?? ''.tr,
                  )),
                  body: ListView(
                    padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 70.0),
                    children: [
                      Center(
                        child: ImageProfileView(
                          onChangeImage: () {
                            AppRoutes.pushReplacement(
                              context,
                              const ProfileView(),
                            );
                          },
                        ),
                      ),
                      _sizedBox,
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'USER NAME'.tr,
                        ),
                        initialValue: cubit?.user?.data?.name ?? '',
                      ),
                      _fieldPadding,
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'EMAIL ADDRESS'.tr,
                        ),
                        initialValue: cubit?.user?.data?.email ?? '',
                      ),
                      _fieldPadding,
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'PHONE'.tr,
                        ),
                        initialValue: cubit?.user?.data?.phone ?? '',
                      ),
                      _fieldPadding,
                      _sizedBox,
                      _sizedBox,
                      ElevatedButton(
                        onPressed: () {
                          AppRoutes.push(context, ChangePasswordView());
                        },
                        child: Text(
                          'Change Password'.tr,
                          style: const TextStyle(color: AppData.btnTextColor),
                        ),
                      ).toGradient(context),
                      _sizedBox,
                      ElevatedButton(
                        onPressed: () async {
                          await AppRoutes.push(context, EditProfileView());
                          //to refresh screen and refresh initial text field data
                          await AppRoutes.pushReplacement(
                              context, const ProfileView());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 1.0,
                        ),
                        child: Text(
                          'Edit Account'.tr,
                          style: const TextStyle(color: AppData.secondaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is UpdatingProfileDataState) const LoadingWidget(),
              ],
            );
          } catch (e) {
            return ExceptionView(
              exceptionMsg: e.toString(),
              onRefresh: () async {},
            );
          }
        },
      ),
    );
  }
}
