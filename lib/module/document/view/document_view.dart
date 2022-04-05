import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import 'package:get/get.dart';
import '../cubit/document/cubit.dart';
import '../cubit/document/states.dart';

class DocumentView extends StatelessWidget {
  static const String id = 'document_view';
  final String title;
  final String endPoint;

  const DocumentView({
    @required this.title,
    @required this.endPoint,
  })  : assert(title != null),
        assert(endPoint != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentViewCubit>(
      create: (context) => DocumentViewCubit(endPoint: endPoint),
      child: BlocConsumer<DocumentViewCubit, DocumentViewStates>(
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
                  title: Text(title, style: TextStyle(color: Colors.grey[800])),
                ),
                body: _body(context, state),
              ),
              if (state is LoadingState) const LoadingWidget()
            ],
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, DocumentViewStates state) {
    final cubit = DocumentViewCubit.get(context);

    if (state is InitialState) {
      return const LoadingWidget();
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 15.0,
          ),
          child: HtmlWidget(cubit.htmlData),
        ),
      );
    }
  }
}
