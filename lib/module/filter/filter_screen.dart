import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:softgrow/module/filter/filter_controller.dart';
import 'package:get/get.dart';
import 'package:softgrow/module/product/widget/products_grid_view.dart';
import 'package:softgrow/widget/loading_widget.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen();

  static const routeName = 'filter';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
        init: FilterController(),
        builder: (FilterController controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:
                  Text('FILTER'.tr, style: TextStyle(color: Colors.grey[800])),
              actions: [
                TextButton(
                  onPressed: () {
                    if (controller.isFilter == true) {
                      controller.changeFilterStatus(false);
                    } else {
                      controller.fetchProductsFiltred();
                      controller.changeFilterStatus(true);
                    }
                  },
                  child: controller.isLoading == true
                      ? CircularProgressIndicator()
                      : Text(
                          controller.isFilter == true
                              ? 'CANCEL'.tr
                              : 'APPLY'.tr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
            body: controller.isLoading == true
                ? LoadingWidget()
                : controller.isFilter == true
                    ? SingleChildScrollView(
                        child: ProductsGridView(
                            productList: controller.productList))
                    : ListView(
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
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.4)),
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
                                itemCount:
                                    controller.filter.categories.length > 5
                                        ? 5
                                        : controller.filter.categories.length,
                                itemBuilder: (context, indexCategories) {
                                  return RadioListTile<int>(
                                    value: indexCategories,
                                    groupValue: controller.selectedValue,
                                    title: Text(
                                        "${controller.filter.categories[indexCategories].name}"),
                                    onChanged: (change) {
                                      controller.selecteCategory(
                                          indexCategories,
                                          controller.filter
                                              .categories[indexCategories].id);
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
                            itemCount: controller.filter.attributes.length,
                            itemBuilder: (context, indexAttributes) {
                              return ExpandablePanel(
                                header: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.withOpacity(0.4)),
                                    ),
                                  ),
                                  child: Text(
                                    "${controller.filter.attributes[indexAttributes].name}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .filter
                                        .attributes[indexAttributes]
                                        .valueIds
                                        .length,
                                    itemBuilder: (context, index) {
                                      List<String> list = [];
                                      list.add(controller
                                          .filter
                                          .attributes[indexAttributes]
                                          .valueIds[index]
                                          .name);
                                      return CheckboxGroup(
                                          labels: list,
                                          onSelected: (List<String> checked) {
                                            controller.addId(controller
                                                .filter
                                                .attributes[indexAttributes]
                                                .valueIds[index]
                                                .id);
                                          });
                                      //  CheckboxListTile(
                                      //   title: Text(
                                      //       "${controller.filter.attributes[indexAttributes].valueIds[index].name}"),
                                      //   value: controller.value,
                                      //   onChanged: (bool value) {
                                      //     controller.selecteCheckBox(value);
                                      //   },
                                      // );
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
                      )));
  }
}
