import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_email/sign_in_email.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_loading/sign_in_loading.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_password/cubit/sign_in_password_cubit.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_password/view/sign_in_password_text_field.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_submit/sign_in_submit_cubit.dart';

class SignInPage extends HookWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCubit = useState(SignInEmailCubit());
    final passwordCubit = useState(SignInPasswordCubit());
    final submitCubit = useState(
      SignInSubmitCubit(
        emailCubit: emailCubit.value,
        passwordCubit: passwordCubit.value,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInEmailCubit>(create: (_) => emailCubit.value),
        BlocProvider<SignInPasswordCubit>(create: (_) => passwordCubit.value),
        BlocProvider<SignInSubmitCubit>(
          create: (_) => submitCubit.value,
        ),
        BlocProvider<LoadingCubit>(
          create: (_) => LoadingCubit(signInSubmitCubit: submitCubit.value),
        ),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

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
              children: [
                SignInEmailTextField(),
                SizedBox(height: 16),
                SignInPasswordTextField(),
                SizedBox(height: 16),
                SignInSubmitButton(),
              ],
            ),
          ),
          LoadingScreen(),
        ],
      ),
    );
  }
}
