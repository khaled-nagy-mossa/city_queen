import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_picker/place_picker.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/custom_shadow.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import '../../auth/cubit/auth/cubit.dart';
import '../../auth/cubit/auth/cubit_extension.dart';
import '../../global/view/empty_view.dart';
import 'package:get/get.dart';
import '../cubit/user_addresses_cubit/cubit.dart';
import '../cubit/user_addresses_cubit/states.dart';
import '../model/address.dart';
import '../widget/address_item.dart';
import 'address_picker.dart';

class UserAddressesView extends StatelessWidget {
  static const String id = 'user_addresses_view';

  final String title;
  final void Function(Address address) onSelect;

  const UserAddressesView({
    @required this.title,
    @required this.onSelect,
  })  : assert(title != null),
        assert(onSelect != null);

  Future<void> _addAddress(BuildContext context) async {
    final result = await AppRoutes.push<LocationResult>(
        context, const AddressPickerView());

    if (result != null) {
      await UserAddressesCubit.get(context).addAddress(
        location: result,
        userData: AuthCubit?.get(context)?.userData,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthListener(
      child: BlocProvider<UserAddressesCubit>(
        create: (context) => UserAddressesCubit(),
        child: BlocConsumer<UserAddressesCubit, UserAddressesState>(
          listener: (context, state) {
            if (state is IneffectiveErrorState) {
              AppSnackBar.error(context, state.error);
            } else if (state is AddressAddedState) {
              onSelect(state.address);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    title: Text(title ?? 'Saved Addresses'.tr,
                        style: TextStyle(color: Colors.grey[800])),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _addAddress(context);
                        },
                      ),
                    ],
                  ),
                  body: _body(context, state),
                ),
                if (state is LoadingState) const LoadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, UserAddressesState state) {
    final cubit = UserAddressesCubit?.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Addresses Found!'.tr,
        svgPath: Assets.images.location,
        onRefresh: () async {},
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: [
          const SizedBox(height: 40.0),
          CustomShadow(
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 0.0,
              child: Column(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit?.addressList?.count ?? 0,
                    itemBuilder: (context, index) {
                      final address = cubit?.addressList?.lines[index];

                      if (address == null) return const SizedBox();

                      return AddressItem(
                        onTab: () {
                          onSelect(address);
                        },
                        address: address,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _addAddress(context);
            },
            child: Text('Add New Address'.tr),
          ).toGradient(context),
          const SizedBox(height: 40.0),
        ],
      );
    }
  }
}
