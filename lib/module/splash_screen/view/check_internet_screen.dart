import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/exception_view.dart';
import '../../global/view/no_internet_view.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CheckInternetScreen extends StatelessWidget {
  final Widget child;

  const CheckInternetScreen({@required this.child}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashScreenCubit>(
      create: (context) => SplashScreenCubit(context),
      child: Builder(
        builder: (context) {
          return BlocConsumer<SplashScreenCubit, SplashScreenStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(body: _body(context, state)),
                  if (state is LoadingState) const LoadingWidget(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, SplashScreenStates state) {
    if (state is HasInitState) {
      return child;
    } else if (state is NoInternetState) {
      return NoInternetView(
        onRefresh: () async {
          await SplashScreenCubit.get(context).refresh(context);
        },
      );
    } else if (state is ExceptionState) {
      return ExceptionView(
        exceptionMsg: state?.error ?? '',
        onRefresh: () async {
          await SplashScreenCubit.get(context).refresh(context);
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
