import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/widget/linear_progress_indicator.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../cubit/branches/branches_cubit.dart';
import '../cubit/branches/branches_states.dart';
import '../model/branches_list.dart';
import '../widget/branch_item.dart';

class BranchesView extends StatelessWidget {
  static const String id = 'branches_view';

  final BranchList initialData;

  const BranchesView({this.initialData});

  static final ScrollController _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 250.0) {
          BranchesViewCubit.get(context).fetchMore();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BranchesViewCubit>(
      create: (context) => BranchesViewCubit(initData: initialData),
      child: Builder(
        builder: (context) {
          return BlocConsumer<BranchesViewCubit, BranchesViewStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
              if (state is HasInitState) {
                _setupScrollController(context);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'All Branches'.tr,
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                    body: _body(context, state),
                  ),
                  if (state is FetchingDataState) const AppLinearIndicator(),
                  if (state is LoadingState) const LoadingWidget(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, BranchesViewStates state) {
    final cubit = BranchesViewCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Branches Found!'.tr,
        svgPath: Assets.images.branches,
        onRefresh: () async {
          await cubit.refresh();
        },
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 50.0),
          itemCount: cubit?.branchList?.branches?.length ?? 0,
          itemBuilder: (context, index) {
            final branch = cubit?.branchList?.branches[index];
            return BranchItem(branch: branch);
          },
        ),
      );
    }
  }
}
