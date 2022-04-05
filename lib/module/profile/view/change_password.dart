import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/const/app_data.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../cubit/reset_password/cubit.dart';
import '../cubit/reset_password/states.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatelessWidget {
  static const routeName = '/change_password';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: BlocProvider<ChangePasswordViewCubit>(
        create: (context) => ChangePasswordViewCubit(),
        child: BlocConsumer<ChangePasswordViewCubit, ChangePasswordViewStates>(
          listener: (context, state) {
            if (state is IneffectiveErrorState) {
              AppSnackBar.error(context, state.error);
            } else if (state is PasswordChangedState) {
              Navigator.pop(context);
              AppSnackBar.error(context, 'Password Changed Successfully'.tr);
            }
          },
          builder: (context, state) {
            final cubit = ChangePasswordViewCubit.get(context);
            return Scaffold(
              appBar: DefaultAppBar(title: Text('Reset Password'.tr)),
              body: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 50.0),
                      children: [
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Old Password'.tr,
                          ),
                          validator: cubit.model.oldPasswordValidator,
                          onChanged: (v) => cubit.model.oldPassword = v,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'New Password'.tr,
                          ),
                          validator: cubit.model.newPasswordValidator,
                          onChanged: (v) => cubit.model.newPassword = v,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password'.tr,
                          ),
                          validator: cubit.model.confirmPasswordValidator,
                          onChanged: (v) => cubit.model.confirmPassword = v,
                        ),
                        const SizedBox(height: 40.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await cubit.changePassword();
                              }
                            },
                            child: Text(
                              'Reset Password'.tr,
                              style: const TextStyle(
                                color: AppData.btnTextColor,
                              ),
                            ),
                          ).toGradient(context),
                        ),
                      ],
                    ),
                  ),
                  if (state is LoadingState) const LoadingWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
