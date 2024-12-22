import 'dart:async';

import 'package:bloc/bloc.dart';

class SignInPasswordCubit extends Cubit<({String? password, String? error})> {
  SignInPasswordCubit() : super((password: null, error: null));
  Timer? _debounce;
  void passwordChanged(String password) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      emit(
        password.isPasswordValid()
            ? (password: password, error: null)
            : (password: password, error: 'Invalid password'),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

extension on String {
  bool isPasswordValid() {
    return length >= 6;
  }
}
