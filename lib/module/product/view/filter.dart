import 'package:app_routes/app_routes.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/module/global/widget/exception.dart';
import 'package:softgrow/module/product/model/helper/product_list_params.dart';
import 'package:softgrow/module/product/view/search.dart';
import 'package:softgrow/widget/loading_widget.dart';

import '../cubit/filter/cubit.dart';
import '../cubit/filter/states.dart';

class FilterView extends StatelessWidget {
  const FilterView(
      {this.initParams, this.comingFromSearchScreen = false, Key key})
      : super(key: key);
  static const routeName = 'filter';
  final bool comingFromSearchScreen;
  final ProductListParams initParams;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilterCubit>(
      create: (context) => FilterCubit(params: initParams),
      child: Builder(
        builder: (context) {
          return BlocConsumer<FilterCubit, FilterStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = FilterCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title:
                      Text('Filter', style: TextStyle(color: Colors.grey[800])),
                  actions: [
                    TextButton(
                      onPressed: () {
                        final params = ProductListParams(
                          attrsValueIds: cubit.selectedIds,
                          categoryId: cubit?.selectedCategory?.id,
                        );
                        if (comingFromSearchScreen) {
                          Navigator.pop<ProductListParams>(context, params);
                        } else {
                          AppRoutes.pushReplacement(
                            context,
                            SearchView(params: params),
                          );
                        }
                      },
                      child: const Text(
                        'apply',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                body: const _Body(),
              );
            },
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterCubit, FilterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = FilterCubit.get(context);
        if (state is InitState || state is FetchingDataState) {
          return const LoadingWidget();
        } else if (state is ExceptionState) {
          return ExceptionWidget(exceptionMsg: state.error);
        } else {
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 20.0,
            ),
            children: [
              ExpandablePanel(
                header: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.4)),
                    ),
                  ),
                  child: Text(
                    'Category',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                collapsed: const Text(''),
                expanded: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.filter.categories.length
                    // < 5
                    //     ? cubit.filter.categories.length
                    //     : 5
                    ,
                    itemBuilder: (context, index) {
                      final category = cubit.filter.categories[index];
                      return RadioListTile(
                        value: category.id,
                        groupValue: cubit.selectedCategory.id,
                        onChanged: (int id) {
                          // cubit. selectedCategory(id);
                        },
                      );
                      // return CheckboxListTile(
                      //   title: Text(valueId.name),
                      //   value: cubit.selectedIds.contains(valueId.id),
                      //   onChanged: (bool value) {
                      //     cubit.addId(valueId.id);
                      //   },
                      // );
                    },
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.filter.attributes.length,
                itemBuilder: (context, index) {
                  final attribute = cubit.filter.attributes[index];

                  return ExpandablePanel(
                    controller: ExpandableController()
                      ..expanded = cubit.fun(attribute),
                    header: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Colors.grey.withOpacity(0.4)),
                        ),
                      ),
                      child: Text(
                        attribute.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    collapsed: const Text(''),
                    expanded: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: attribute.valueIds.length,
                        itemBuilder: (context, index) {
                          final valueId = attribute.valueIds[index];
                          return CheckboxListTile(
                            title: Text(valueId.name),
                            value: cubit.selectedIds.contains(valueId.id),
                            onChanged: (bool value) {
                              cubit.addId(valueId.id);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Text('');
                },
              ),
            ],
          );
        }
      },
    );
  }
}
