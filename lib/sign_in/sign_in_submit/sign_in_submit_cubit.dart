import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_email/cubit/sign_in_email_cubit.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_password/cubit/sign_in_password_cubit.dart';
import 'package:rxdart/rxdart.dart';

enum SignInSubmitStatus { invalid, valid, submitting, success, error }

class SignInSubmitCubit extends Cubit<SignInSubmitStatus> {
  SignInSubmitCubit({
    required this.emailCubit,
    required this.passwordCubit,
  }) : super(SignInSubmitStatus.invalid) {
    _submitSubscription = CombineLatestStream.combine2(
      emailCubit.stream,
      passwordCubit.stream,
      (email, password) => (email: email, password: password),
    ).listen((event) {
      final email = event.email;
      final password = event.password;
      emit(
        email.error != null || password.error != null
            ? SignInSubmitStatus.invalid
            : SignInSubmitStatus.valid,
      );
    });
  }
  final SignInEmailCubit emailCubit;
  final SignInPasswordCubit passwordCubit;
  StreamSubscription<
      ({
        ({String? email, String? error}) email,
        ({String? error, String? password}) password
      })>? _submitSubscription;

  void onSubmit() {
    emit(SignInSubmitStatus.submitting);
    Future.delayed(const Duration(seconds: 2), () {
      emit(SignInSubmitStatus.error);
    });
  }

  @override
  Future<void> close() {
    _submitSubscription?.cancel();
    return super.close();
  }
}

class SignInSubmitButton extends StatelessWidget {
  const SignInSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInSubmitCubit, SignInSubmitStatus>(
      listener: (context, state) {
        if (state == SignInSubmitStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign in failed')),
            );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: switch (state) {
            SignInSubmitStatus.invalid => null,
            _ => context.read<SignInSubmitCubit>().onSubmit
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}
