import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/const/app_data.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../global/view/exception_view.dart';
import '../cubit/account/cubit.dart';
import '../cubit/account/states.dart';
import '../cubit/edit_profile/cubit.dart';
import '../cubit/edit_profile/states.dart';
import '../model/edit_profile_extension.dart';
import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  static const routeName = '/editProfile_view';

  static const _fieldPadding = SizedBox(height: 10.0, width: 10.0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = AccountCubit?.get(context);
    final userData = cubit?.user?.data;

    return AuthListener(
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is UpdatedProfileDataState) Navigator.pop(context);
        },
        builder: (context, authState) {
          try {
            return BlocProvider<EditProfileViewCubit>(
              create: (_) => EditProfileViewCubit(
                AccountCubit?.get(context)?.user?.data,
              ),
              child: BlocConsumer<EditProfileViewCubit, EditProfileViewStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  final cubit = EditProfileViewCubit.get(context);

                  return Stack(
                    children: [
                      Scaffold(
                        appBar: DefaultAppBar(
                          title: Text('Edit Account'.tr),
                        ),
                        body: Form(
                          key: _formKey,
                          child: ListView(
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 40.0, 15.0, 70.0),
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'USER NAME'.tr,
                                ),
                                initialValue: userData?.name ?? '',
                                onChanged: cubit.changeName,
                                validator: cubit.model.nameValidator,
                              ),
                              _fieldPadding,
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'EMAIL ADDRESS'.tr,
                                ),
                                initialValue: userData?.email ?? '',
                                onChanged: cubit.changeEmail,
                                validator: cubit.model.emailValidator,
                              ),
                              _fieldPadding,
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'PHONE'.tr,
                                ),
                                initialValue: userData?.phone ?? '',
                                onChanged: cubit.changePhone,
                                validator: cubit.model.phoneValidator,
                              ),
                              _fieldPadding,
                              _fieldPadding,
                              _fieldPadding,
                              _fieldPadding,
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    await AccountCubit.get(context)
                                        .updateUserData(cubit.model);
                                  }
                                },
                                child: Text(
                                  'Save'.tr,
                                  style: const TextStyle(
                                    color: AppData.btnTextColor,
                                  ),
                                ),
                              ).toGradient(context),
                            ],
                          ),
                        ),
                      ),
                      if (authState is UpdatingProfileDataState)
                        const LoadingWidget(),
                    ],
                  );
                },
              ),
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
