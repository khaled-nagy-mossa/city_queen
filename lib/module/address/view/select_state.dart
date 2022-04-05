import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../cubit/country_states_address_cubit/cubit.dart';
import '../cubit/country_states_address_cubit/state.dart';
import '../model/state.dart';

class SelectStateView extends StatelessWidget {
  static const String id = 'select_state_view';

  final int countryId;

  const SelectStateView({@required this.countryId}) : assert(countryId != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryStatesAddressCubit>(
      create: (context) => CountryStatesAddressCubit()..initial(countryId),
      child:
          BlocConsumer<CountryStatesAddressCubit, CountryStatesAddressStates>(
        listener: (context, state) {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Select State'.tr),
            ),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, CountryStatesAddressStates state) {
    if (state is InitialState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No States available'.tr,
        svgPath: Assets.images.country,
        onRefresh: () async {},
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      final filteredData = CountryStatesAddressCubit.get(context).filteredData;
      return Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search For Your State'.tr,
              border: const UnderlineInputBorder(),
            ),
            onChanged: CountryStatesAddressCubit.get(context).search,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10.0, bottom: 50.0),
              itemCount: filteredData.items.length,
              itemBuilder: (context, index) {
                final state = filteredData.items[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop<StateLocation>(context, state);
                    },
                    title: Text(state.name ?? ''.tr),
                  ),
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
