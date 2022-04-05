import '../../../product/model/product_review.dart';

abstract class AddReviewStates {
  final double rate;

  const AddReviewStates({this.rate});
}

class InitialState extends AddReviewStates {
  const InitialState(double rate) : super(rate: rate);
}

class ChangedRateState extends AddReviewStates {
  const ChangedRateState(double rate) : super(rate: rate);
}

class LoadingState extends AddReviewStates {
  const LoadingState(double rate) : super(rate: rate);
}

class ReviewSubmittedState extends AddReviewStates {
  final ProductReview review;

  const ReviewSubmittedState(this.review, double rate) : super(rate: rate);
}

class IneffectiveError extends AddReviewStates {
  final String error;

  const IneffectiveError(this.error, double rate) : super(rate: rate);
}
