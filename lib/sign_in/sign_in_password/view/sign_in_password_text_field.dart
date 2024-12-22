import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_password/sign_in_password.dart';

class SignInPasswordTextField extends StatelessWidget {
  const SignInPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInPasswordCubit,
        ({String? password, String? error})>(
      builder: (context, state) {
        return TextField(
          onChanged: context.read<SignInPasswordCubit>().passwordChanged,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.error,
          ),
        );
      },
    );
  }
}
