import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../cubit/country_picker_cubit/cubit.dart';
import '../cubit/country_picker_cubit/state.dart';
import '../model/country.dart';
import '../widget/country_item.dart';

class SelectCountryView extends StatelessWidget {
  const SelectCountryView();

  static const String id = 'select_country_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryPickerViewCubit>(
      create: (context) => CountryPickerViewCubit()..initial(),
      child: BlocConsumer<CountryPickerViewCubit, CountryPickerViewStates>(
        listener: (context, state) {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('Select Country'.tr)),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, CountryPickerViewStates state) {
    if (state is InitialState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No countries available'.tr,
        svgPath: Assets.images.country,
        onRefresh: () async {},
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      final filteredData = CountryPickerViewCubit.get(context).filteredData;
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search For Your Country'.tr,
              border: const UnderlineInputBorder(),
            ),
            onChanged: CountryPickerViewCubit.get(context).search,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10.0, bottom: 50.0),
              itemCount: filteredData.items.length,
              itemBuilder: (context, index) {
                final country = filteredData.items[index];
                return CountryItem(
                  country: country,
                  onTap: () {
                    Navigator.pop<Country>(context, country);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0.0);
              },
            ),
          ),
        ],
      );
    }
  }
}
