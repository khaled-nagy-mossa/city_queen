import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/assets/assets.dart';

// ignore: must_be_immutable
class SimpleCounter extends StatefulWidget {
  int counter;
  final int maxCount;
  final Future<bool> Function(int index) onChanged;

  //style
  final double counterSize, buttonSize;
  final Color counterColor, incrementButtonColor, decrementButtonColor;

  SimpleCounter({
    @required this.onChanged,
    @required this.counter,
    this.maxCount,
    this.counterSize = 10.0,
    this.buttonSize = 25.0,
    this.decrementButtonColor,
    this.incrementButtonColor,
    this.counterColor,
  }) : assert(onChanged != null && counter != null);

  @override
  _SimpleCounterState createState() => _SimpleCounterState();
}

class _SimpleCounterState extends State<SimpleCounter> {
  Timer timer;

  Future<void> _increment() async {
    if (widget.maxCount == null || widget.maxCount > widget.counter) {
      ++widget.counter;
      final succeeded = await widget.onChanged(widget.counter);
      if (!succeeded) --widget.counter;
      setState(() {});
    }
  }

  Future<void> _decrement() async {
    if (widget.counter > 0) {
      --widget.counter;
      final succeeded = await widget.onChanged(widget.counter);
      if (!succeeded) ++widget.counter;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buttonNode(
          svg: Assets.images.minus,
          onTap: _decrement,
          enabled: widget.counter > 0,
          disabledColor: Colors.grey,
          color: widget.incrementButtonColor ?? Theme.of(context).primaryColor,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            widget.counter.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.counterColor ?? Colors.white,
            ),
          ),
        ),
        _buttonNode(
          svg: Assets.images.add,
          onTap: _increment,
          enabled:
              (widget.maxCount == null) || widget.maxCount > widget.counter,
          //enabled: (widget.maxCount == null)
          //               ? true
          //               : widget.maxCount > widget.counter,
          disabledColor: Colors.grey,
          color: widget.incrementButtonColor ?? Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Widget _buttonNode({
    @required String svg,
    @required void Function() onTap,
    @required Color color,
    @required Color disabledColor,
    bool enabled,
  }) {
    return GestureDetector(
      onTap: () {
        // timer = Timer.periodic(Duration(milliseconds: 200), (t) {
        if (enabled) onTap();
        // });
      },
      // onTapUp: (TapUpDetails details) {
      //   timer.cancel();
      // },
      // onTapCancel: () {
      //   timer.cancel();
      // },
      child: Container(
        height: widget.buttonSize,
        width: widget.buttonSize,
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled ? color : disabledColor,
        ),
        child: SvgPicture.asset(
          svg,
          height: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

// import 'package:softgrow/controller/asset/asset.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// // ignore: must_be_immutable
// class SimpleCounter extends StatefulWidget {
//   //operation
//   int counter;
//   final int maxCount;
//   final Future<bool> Function(int index) onChanged;
//
//   //style
//   final double counterSize, buttonSize;
//   final Color counterColor, incrementButtonColor, decrementButtonColor;
//   final bool enabled;
//
//   SimpleCounter({
//     @required  onChanged,
//      counter,
//      maxCount,
//      enabled = true,
//      counterSize = 10.0,
//      buttonSize = 25.0,
//      decrementButtonColor,
//      incrementButtonColor,
//      counterColor,
//   }) : assert(onChanged != null && counter != null);
//
//   @override
//   _SimpleCounterState createState() => _SimpleCounterState();
// }
//
// class _SimpleCounterState extends State<SimpleCounter> {
//   Future<void> _increment() async {
//     if ( widget.maxCount == null ||
//          widget.maxCount >  widget.counter) {
//       ++ widget.counter;
//       bool succeeded = await  widget.onChanged( widget.counter);
//       if (!succeeded) -- widget.counter;
//       setState(() {});
//     }
//   }
//
//   Future<void> _decrement() async {
//     if ( widget.counter > 0) {
//       -- widget.counter;
//       bool succeeded = await  widget.onChanged( widget.counter);
//       if (!succeeded) ++ widget.counter;
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//          _buttonNode(
//           svg: Assets.images.minus,
//           onTap: () =>  _decrement(),
//           enabled:  widget.counter > 0,
//           disabledColor: Colors.grey,
//           color:  widget.incrementButtonColor ??
//               Theme.of(context).primaryColor,
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 10.0),
//           child: Text(
//              widget.counter.toString(),
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color:  widget.counterColor ?? Colors.white,
//             ),
//           ),
//         ),
//          _buttonNode(
//           svg: Assets.images.add,
//           onTap: () =>  _increment(),
//           enabled: ( widget.maxCount == null)
//               ? true
//               :  widget.maxCount > widget.counter,
//           disabledColor: Colors.grey,
//           color:  widget.incrementButtonColor ??
//               Theme.of(context).primaryColor,
//         ),
//       ],
//     );
//   }
//
//   Widget _buttonNode({
//     @required String svg,
//     @required void Function() onTap,
//     @required Color color,
//     @required Color disabledColor,
//     bool enabled,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         if (enabled) onTap();
//       },
//       child: Container(
//         height:  widget.buttonSize,
//         width:  widget.buttonSize,
//         padding: EdgeInsets.all(7.0),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: (enabled) ? color : disabledColor,
//         ),
//         child: SvgPicture.asset(
//           svg,
//           height: 20.0,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
