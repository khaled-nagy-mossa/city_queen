import 'package:flutter/material.dart';
import 'package:softgrow/module/category/model/category.dart';

abstract class FilterStates {
  const FilterStates();
}

class InitState extends FilterStates {
  const InitState() : super();
}

class FetchingDataState extends FilterStates {
  const FetchingDataState() : super();
}

class FetchedDataState extends FilterStates {
  const FetchedDataState() : super();
}

class CategorySelectedState extends FilterStates {
  const CategorySelectedState({@required this.category})
      : assert(category != null, 'categoryId must not be null'),
        super();
  final Category category;
}

class SelectedIdsChangedState extends FilterStates {
  const SelectedIdsChangedState({@required this.selectedIds})
      : assert(selectedIds != null, 'screen ids must not be null'),
        super();
  final List<int> selectedIds;
}


class ExceptionState extends FilterStates {
  const ExceptionState({@required this.error})
      : assert(error != null, 'error must not be null'),
        super();

  /// error message
  final String error;
}
