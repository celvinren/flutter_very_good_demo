import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_email/sign_in_email.dart';

class SignInEmailTextField extends StatelessWidget {
  const SignInEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInEmailCubit, ({String? email, String? error})>(
      builder: (context, state) {
        return TextField(
          onChanged: context.read<SignInEmailCubit>().emailChanged,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.error,
          ),
        );
      },
    );
  }
}
