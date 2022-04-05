import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'states.dart';

class FontsCubit extends Cubit<FontsStates> {
  FontsCubit() : super(const InitState()) {
    _filteredFonts = _allFonts;
  }

  String _selectedFonts;

  TextStyle get font {
    final temp = _selectedFonts ?? 'Abel';
    return GoogleFonts.getFont(temp);
  }

  String get selectedFonts => _selectedFonts;

  set selectedFonts(String value) {
    _selectedFonts = value;
    emit(SelectedFontChangeStatus(font: value));
  }

  List<String> _filteredFonts;

  factory FontsCubit.get(BuildContext context) {
    return BlocProvider.of<FontsCubit>(context);
  }

  /// All Filtered google fonts data as a list
  List<String> get fonts {
    return _filteredFonts ?? [];
  }

  /// All Google fonts as a list
  List<String> get _allFonts {
    return GoogleFonts.asMap().keys.toList();
  }

  Future<void> search(String value) async {
    _filteredFonts = [];

    if (value.isEmpty) {
      emit(SearchValueChangeStatus(value: value));
      return;
    }

    _filteredFonts =
        _allFonts.where((element) => element.startsWith(value)).toList();

    emit(SearchValueChangeStatus(value: value));
  }
}
