import 'dart:async';

import 'package:bloc/bloc.dart';

class SignInEmailCubit extends Cubit<({String? email, String? error})> {
  SignInEmailCubit() : super((email: null, error: null));
  Timer? _debounce;
  void emailChanged(String email) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      emit(
        email.isEmailValid()
            ? (email: email, error: null)
            : (email: email, error: 'Invalid email'),
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
  bool isEmailValid() {
    return contains('@');
  }
}
