import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softgrow/widget/loading_widget.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../global/view/empty_view.dart';
import '../cubit/contact_us/cubit.dart';
import '../cubit/contact_us/states.dart';
import '../widget/branch_address_data.dart';
import '../widget/branch_contact_data.dart';
import '../widget/social_media_list.dart';
import 'package:get/get.dart';

class ContactUsView extends StatelessWidget {
  static const String id = 'contact_us_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactUsViewCubit>(
      create: (context) => ContactUsViewCubit(),
      child: BlocConsumer<ContactUsViewCubit, ContactUSViewStates>(
        listener: (context, state) {
          if (state is IneffectiveErrorState) {
            AppSnackBar.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                    title: Text('Contact Us'.tr,
                        style: TextStyle(color: Colors.grey[800]))),
                body: _body(context, state),
              ),
              if (state is LoadingState) const LoadingWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, ContactUSViewStates state) {
    if (state is InitialState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmptyState) {
      return EmptyView(
        onRefresh: () async {},
        title: 'No Data Found!'.tr,
        svgPath: Assets.images.contact,
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      final cubit = ContactUsViewCubit.get(context);
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints(),
              height: MediaQuery.of(context).size.width - 150.0,
              width: MediaQuery.of(context).size.width - 150.0,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     fit: BoxFit.contain,
              //     image: NetworkImage('https://delphsoft.com/wp-content/uploads/2019/11/contactus-1.jpg'.tr,
              //   ),
              // ),
            ),
          ),
          BranchContactData(contactUs: cubit.contactUs),
          const SizedBox(height: 20.0),
          BranchAddressData(contactUs: cubit.contactUs),
          const SizedBox(height: 20.0),
          SocialMediaList(
            contactUs: cubit.contactUs,
            onTap: (url) {
              cubit.launchUrl(context, url);
            },
          ),
        ],
      );
    }
  }
}
