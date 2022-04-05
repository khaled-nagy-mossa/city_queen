import 'package:app_routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/module/auth/widget/already_have_account.dart';
import 'package:softgrow/module/home/view/home.dart';
import 'package:get/get.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';
import '../../../model/user/user.dart';
import '../../../model/user/user_data.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../address/model/country.dart';
import '../../address/model/state.dart';
import '../../address/view/select_country.dart';
import '../../address/view/select_state.dart';
import '../../notification/repositories/service.dart';
import '../cubit/auth/cubit.dart';
import '../cubit/sign_up/cubit.dart';
import '../cubit/sign_up/states.dart';
import '../widget/auth_background.dart';

class SignUpView extends StatelessWidget {
  static const String id = 'sign_up_view';

  SignUpView({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const SizedBox _itemPadding = SizedBox(height: 15.0);

  Future<void> _onSignUp(BuildContext context) async {
    try {
      final cubit = SignUpViewCubit.get(context);
      final Object result = await cubit.signUp(_formKey);

      if (result is User && result.usable) {
        await AuthCubit.get(context).signIn(result);

        final Object userData = await NotificationService.setFirebaseToken(
          fcmToken: await FirebaseMessaging.instance.getToken(),
        );
        if (userData is UserData && userData.usable) {
          await AuthCubit.get(context)
              .signIn(result.copyWith(usermodel: userData));
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
    return BlocProvider<SignUpViewCubit>(
      create: (context) => SignUpViewCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<SignUpViewCubit, SignUpViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.e);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    body: Form(
                      key: _formKey,
                      child: AuthBackground(
                        child: Container(
                          height: 620.0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 40.0),
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              _itemPadding,
                              _fields(context),
                              _itemPadding,
                              ElevatedButton(
                                onPressed: () {
                                  _onSignUp(context);
                                },
                                child: Text('Sign Up'.tr),
                              ).toGradient(context),
                              const Center(child: AlreadyHaveAccount()),
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

  Widget _fields(BuildContext context) {
    final cubit = SignUpViewCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              cubit.model.name = value;
            },
            validator: cubit.model.nameValidator,
            decoration: InputDecoration(
              labelText: 'FULL NAME'.tr,
            ),
          ),
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
            onChanged: (value) {
              cubit.model.phone = value;
            },
            keyboardType: TextInputType.phone,
            validator: cubit.model.phoneValidator,
            decoration: InputDecoration(
              labelText: 'PHONE NUMBER'.tr,
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
          TextFormField(
            onChanged: cubit.onConfirmPasswordChanged,
            validator: cubit.model.confirmPasswordValidator,
            decoration: InputDecoration(
              labelText: 'CONFIRM PASSWORD'.tr,
              suffix: GestureDetector(
                onTap: () {
                  cubit.changeConfirmPasswordVisibility;
                },
                child: cubit.notVisibleConfirmPassword
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
              ),
              suffixIcon: (cubit.model.confirmPassword == null ||
                      cubit.model.confirmPassword.isEmpty)
                  ? null
                  : (cubit.model.validConfirmPassword)
                      ? const Icon(Icons.done, color: Colors.green)
                      : const Icon(Icons.clear, color: Colors.red),
            ),
            obscureText: cubit.notVisibleConfirmPassword,
          ),
          _itemPadding,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Text(
                cubit.model.country?.name ?? 'Country'.tr,
              ),
              onTap: () async {
                final temp =
                    await AppRoutes.push(context, const SelectCountryView());
                cubit.changeCountry(temp as Country);
              },
            ),
          ),
          _itemPadding,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Text(
                cubit.model.state?.name ?? 'State'.tr,
              ),
              onTap: () async {
                if (cubit.model.country != null) {
                  final temp = await AppRoutes.push(context,
                      SelectStateView(countryId: cubit.model.country.id));
                  if (temp != null) {
                    cubit.changeState(temp as StateLocation);
                  }
                } else {
                  AppSnackBar.error(
                    context,
                    'You must Select Country First'.tr,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
