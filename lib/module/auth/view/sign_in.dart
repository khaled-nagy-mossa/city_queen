import 'package:app_routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/module/home/view/home.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';

import '../../../model/user/user.dart';
import '../../../model/user/user_data.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../notification/repositories/service.dart';
import '../cubit/auth/cubit.dart';
import '../cubit/sign_in/cubit.dart';
import '../cubit/sign_in/states.dart';
import '../widget/auth_background.dart';
import '../widget/need_account.dart';
import 'forget_password.dart';
import 'package:get/get.dart';

class SignInView extends StatelessWidget {
  static const String id = 'sign_in_view';

  SignInView({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const SizedBox _itemPadding = SizedBox(height: 15.0);

  Future<void> _onLogin(BuildContext context) async {
    try {
      final cubit = SignInViewCubit.get(context);
      final Object result = await cubit.login(_formKey);
      if (result is User && result.usable) {
        await AuthCubit.get(context).signIn(result);

        final Object userData = await NotificationService.setFirebaseToken(
          fcmToken: await FirebaseMessaging.instance.getToken(),
        );

        if (userData is UserData && userData.usable) {
          await AuthCubit.get(context)
              .signIn(result.copyWith(usermodel: userData));
          print("fcm token is : ${result.data.firebaseToken}");
          print(" token is: ${result.token}");
        } else {
          AppSnackBar.error(context, 'fcm token cannot update : $userData'.tr);
        }

        await AppRoutes.pushAndRemoveUntil(context, const HomeView());
      }
    } catch (e) {
      AppSnackBar.error(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInViewCubit>(
      create: (context) => SignInViewCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<SignInViewCubit, SignInViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.e);
              }
            },
            builder: (context, state) {
              final cubit = SignInViewCubit.get(context);

              return Stack(
                children: [
                  Scaffold(
                    body: Form(
                      key: _formKey,
                      child: AuthBackground(
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _itemPadding,
                              _itemPadding,
                              //email and password fields
                              _fields(cubit),
                              TextButton(
                                onPressed: () {
                                  AppRoutes.push(
                                    context,
                                    const ForgetPasswordView(),
                                  );
                                },
                                child: Text(
                                  'forget password?'.tr,
                                ),
                              ),
                              _itemPadding,
                              ElevatedButton(
                                onPressed: () {
                                  _onLogin(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize:
                                      const Size(double.infinity, 35.0),
                                ),
                                child: Text('Login'.tr),
                              ).toGradient(context),
                              _itemPadding,
                              const Center(child: NeedAccountWidget()),
                            ],
                          ),
                        ),
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

  Widget _fields(SignInViewCubit cubit) {
    return Column(
      children: [
        TextFormField(
          onChanged: cubit.onEmailChanged,
          validator: cubit.model.emailValidator,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'EMAIL ADDRESS'.tr,
            suffixIcon: (cubit.model.email == null)
                ? null
                : (cubit.model.validEmail)
                    ? const Icon(Icons.done, color: Colors.green)
                    : const Icon(Icons.clear, color: Colors.red),
          ),
        ),
        TextFormField(
          onChanged: cubit.onPasswordChanged,
          validator: cubit.model.passwordValidator,
          decoration: InputDecoration(
            labelText: 'PASSWORD'.tr,
            suffix: GestureDetector(
              onTap: () {
                cubit.changePasswordVisibility;
              },
              child: cubit.notVisiblePassword
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
            ),
            suffixIcon: (cubit.model.password == null)
                ? null
                : (cubit.model.validPassword)
                    ? const Icon(Icons.done, color: Colors.green)
                    : const Icon(Icons.clear, color: Colors.red),
          ),
          obscureText: cubit.notVisiblePassword,
        ),
      ],
    );
  }
}
