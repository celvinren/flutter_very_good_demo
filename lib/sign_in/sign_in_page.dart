import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_very_good_demo/sign_in/common/text_field_cubit.dart';
import 'package:rxdart/rxdart.dart';

part 'widgets/sign_in_email_text_field.dart';
part 'widgets/sign_in_loading.dart';
part 'widgets/sign_in_password_text_field.dart';
part 'widgets/sign_in_submit_button.dart';

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCubit = useState(
      TextFieldCubit<_SignInEmailTextFieldState>(
        validator: (value) => value.contains('@'),
        action: 'email',
      ),
    );
    final passwordCubit = useState(
      TextFieldCubit<_SignInPasswordTextFieldState>(
        validator: (value) => value.length > 6,
        action: 'password',
      ),
    );
    final submitCubit = useState(
      _SignInSubmitCubit(
        emailCubit: emailCubit.value,
        passwordCubit: passwordCubit.value,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextFieldCubit<_SignInEmailTextFieldState>>(
          create: (_) => emailCubit.value,
        ),
        BlocProvider<TextFieldCubit<_SignInPasswordTextFieldState>>(
          create: (_) => passwordCubit.value,
        ),
        BlocProvider<_SignInSubmitCubit>(
          create: (_) => submitCubit.value,
        ),
        BlocProvider<_LoadingCubit>(
          create: (_) => _LoadingCubit(signInSubmitCubit: submitCubit.value),
        ),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                _SignInEmailTextField(),
                _SignInPasswordTextField(),
                _SignInSubmitButton(),
              ],
            ),
          ),
          _LoadingScreen(),
        ],
      ),
    );
  }
}
