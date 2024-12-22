import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldState {
  const TextFieldState();
}

class TextFieldCubit<T extends TextFieldState>
    extends Cubit<({String? value, String? error})> {
  TextFieldCubit({required this.validator, required this.action})
      : super((value: null, error: null));
  final bool Function(String) validator;
  final String action;
  Timer? _debounce;

  void onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      emit(
        validator(value)
            ? (value: value, error: null)
            : (value: value, error: 'Invalid $action'),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
