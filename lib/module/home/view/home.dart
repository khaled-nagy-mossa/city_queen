import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/shared_widgets/drawer/drawer_widget.dart';

import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../global/widget/exception.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../widget/home_view_item.dart';

class HomeView extends StatelessWidget {
  static const id = 'home_view';

  const HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewCubit>(
      create: (context) => HomeViewCubit(),
      child: BlocConsumer<HomeViewCubit, HomeViewStates>(
        listener: (context, state) {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     AppRoutes.push(context, const FontsView());
            //   },
            // ),
            appBar: const DefaultAppBar(),
            drawer: const DrawerWidget(),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, HomeViewStates state) {
    final cubit = HomeViewCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: () async {},
        exceptionMsg: state.error,
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 50.0),
        itemCount: cubit?.homeItems?.length ?? 0,
        itemBuilder: (context, index) {
          final homeItem = cubit.homeItems[index];
          return HomeViewItem(model: homeItem);
        },
      );
    }
  }
}
