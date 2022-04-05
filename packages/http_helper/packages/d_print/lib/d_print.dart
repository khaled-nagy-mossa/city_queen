library d_print;

import 'dart:developer';

import 'package:flutter/foundation.dart';

//----------------------------------------------------------------------------
// Please read README.md Carefully before using or modify ,thanks
//----------------------------------------------------------------------------

/// logs a string representation of the object to the console => (((in debug Mode)))
/// have 2 algorithm to log data
/// Do not log if it is in release mode
/// It can log over 100 million characters

void dPrint(Object obj) {
  //check if client in release mode to log object or not
  if (!kReleaseMode) {
    if (obj == null) {
      log(obj.toString());
      return;
    } else {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern
          .allMatches(obj.toString())
          .forEach((match) => log(match.group(0)));
    }
  }
}

void dPrint2(Object obj) {
  //check if client in release mode to log object or not
  if (!kReleaseMode) {
    const defaultLogLength = 1020;
    if (obj == null || obj.toString().length <= defaultLogLength) {
      log(obj.toString());
    } else {
      String l = obj.toString();
      int start = 0;
      int endIndex = defaultLogLength;
      int logLength = l.length;
      int tmpLogLength = l.length;
      while (endIndex < logLength) {
        log(l.substring(start, endIndex));
        endIndex += defaultLogLength;
        start += defaultLogLength;
        tmpLogLength -= defaultLogLength;
      }
      if (tmpLogLength > 0) {
        log(l.substring(start, logLength));
      }
    }
  }
}
