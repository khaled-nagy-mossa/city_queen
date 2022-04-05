import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/assets/assets.dart';

class ProductRate extends StatelessWidget {
  final double ratingAvg;

  const ProductRate({@required this.ratingAvg}) : assert(ratingAvg != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Text(
            (ratingAvg?.toStringAsFixed(2) ?? 0.0).toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 7.0),
        SvgPicture.asset(
          Assets.images.star,
          color: const Color(0xFFFFD750),
        ),
      ],
    );
  }
}
