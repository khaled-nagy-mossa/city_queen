import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/account/cubit.dart';
import 'cubit/account/states.dart';

class AccountBlocConsumer extends StatelessWidget {
  final Widget child;

  const AccountBlocConsumer({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return child;
      },
    );
  }
}
