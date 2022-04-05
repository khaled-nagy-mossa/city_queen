import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:softgrow/widget/elevated_button_extension.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/loading_widget.dart';
import '../../auth/auth_observer/auth_builder.dart';
import 'package:get/get.dart';
import '../../product/model/product.dart';
import '../../product/model/product_review.dart';
import '../cubit/add_review/cubit.dart';
import '../cubit/add_review/states.dart';

class AddReviewView extends StatelessWidget {
  final double rate;
  final Product product;

  AddReviewView({@required this.product, this.rate = 0.0})
      : assert(product != null);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (product?.usable != true) return const SizedBox();
    return AuthListener(
      child: BlocProvider<AddReviewCubit>(
        create: (context) => AddReviewCubit(productId: product?.id),
        child: BlocConsumer<AddReviewCubit, AddReviewStates>(
          listener: (context, state) {
            if (state is IneffectiveError) {
              AppSnackBar.error(context, state.error);
            }
            if (state is ReviewSubmittedState) {
              AppSnackBar.error(context, 'Review Submitted (${state.rate})'.tr);
              Navigator.pop<ProductReview>(context, state.review);
            }
          },
          builder: (context, state) {
            final cubit = AddReviewCubit.get(context);

            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(title: Text(product?.name)),
                  body: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 50.0,
                      ),
                      children: [
                        Text(
                          '${'Your Rating'.tr} * (${state.rate})',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: SmoothStarRating(
                                size: 35.0,
                                color: const Color(0xFFFFE9A0),
                                borderColor: Colors.yellow,
                                rating: cubit.rate,
                                onRated: (value) {
                                  cubit.rate = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Your Review'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          onSaved: (value) {
                            cubit.review = value;
                          },
                          validator: cubit.reviewValidator,
                          minLines: 5,
                          maxLines: 5,
                          maxLength: 500,
                          decoration: InputDecoration(
                            hintText: 'Write Your Review Here'.tr,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              cubit.submitReview();
                            }
                          },
                          child: Text('Submit'.tr),
                        ).toGradient(context)
                      ],
                    ),
                  ),
                ),
                if (state is LoadingState) const LoadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
