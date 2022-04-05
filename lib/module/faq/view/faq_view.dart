import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import '../../global/view/exception_view.dart';
import '../../global/widget/exception.dart';
import 'package:get/get.dart';
import '../cubit/faq_cubit.dart';
import '../cubit/faq_states.dart';
import '../widget/item.dart';

class FaqView extends StatelessWidget {
  static const String id = 'faq_view';

  const FaqView();

  //method return Horizontal padding
  //it will change returned value if platform is web or mobile to be responsive
  //you can change it
  double _itemHorizontalPadding(BuildContext context) {
    try {
      var padding = MediaQuery.of(context).size.width;
      if (kIsWeb) {
        padding = padding / 10.0;
      } else {
        padding = padding / 40.0;
      }
      return padding;
    } catch (e) {
      log('Exception in FaqView._itemHorizontalPadding : $e'.tr);
      return 10.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return BlocProvider<FaqViewCubit>(
        create: (context) => FaqViewCubit(),
        child: Builder(
          builder: (context) {
            return BlocConsumer<FaqViewCubit, FaqViewStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Help & Support'.tr,
                        style: TextStyle(color: Colors.grey[800])),
                  ),
                  body: _body(context, state),
                );
              },
            );
          },
        ),
      );
    } catch (e) {
      log('Exception in FaqView : $e'.tr);
      return ExceptionView(
        onRefresh: () async {},
        exceptionMsg: e.toString(),
      );
    }
  }

  Widget _body(BuildContext context, FaqViewStates state) {
    final cubit = FaqViewCubit.get(context);
    if (state is InitialState) {
      return const LoadingWidget();
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Faq Found!'.tr,
        svgPath: Assets.images.contact,
        onRefresh: () async {
          await cubit.refresh();
        },
      );
    } else if (state is ExceptionState) {
      return ExceptionWidget(
        onRefresh: () async {
          await cubit.refresh();
        },
        exceptionMsg: state?.e,
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: ListView.builder(
          itemCount: cubit?.faqList?.count ?? 0,
          padding: EdgeInsets.fromLTRB(
            _itemHorizontalPadding(context),
            25.0,
            _itemHorizontalPadding(context),
            70.0,
          ),
          itemBuilder: (context, index) {
            final faq = cubit?.faqList?.items[index];

            if (faq.unusable) return const SizedBox();

            return FaqItem(model: faq);
          },
        ),
      );
    }
  }
}
