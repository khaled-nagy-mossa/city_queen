import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';
import 'package:softgrow/widget/loading_widget.dart';

import '../../../widget/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';
import '../cubit/forget_password/cubit.dart';
import '../cubit/forget_password/states.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({Key key}) : super(key: key);

  static const SizedBox _itemPadding = SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordViewCubit>(
      create: (context) => ForgetPasswordViewCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ForgetPasswordViewCubit,
              ForgetPasswordViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.e);
              }
              if (state is MessageSendState) {
                AppSnackBar.error(context, state.model.message);
              }
            },
            builder: (context, state) {
              final cubit = ForgetPasswordViewCubit.get(context);
              return Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: Text('Forget Password'.tr),
                    ),
                    body: Container(
                      constraints: const BoxConstraints.expand(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: cubit.onEmailChanged,
                            validator: cubit.emailValidator,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'EMAIL ADDRESS'.tr,
                              suffixIcon: (cubit.email == null)
                                  ? null
                                  : (cubit.validEmail)
                                      ? const Icon(Icons.done,
                                          color: Colors.green)
                                      : const Icon(Icons.clear,
                                          color: Colors.red),
                            ),
                          ),
                          _itemPadding,
                          _itemPadding,
                          ElevatedButton(
                            onPressed: cubit.inValidEmail
                                ? null
                                : cubit.forgetPassword,
                            child: Text('Send'.tr),
                          ).toGradient(context),
                          _itemPadding,
                          if (cubit.showSendAgainButton)
                            Row(
                              children: [
                                Text(
                                  "Didn't receive?".tr,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.sendAgain();
                                  },
                                  child: Text('Send Again'.tr),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (state is LoadingState) const LoadingWidget(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
