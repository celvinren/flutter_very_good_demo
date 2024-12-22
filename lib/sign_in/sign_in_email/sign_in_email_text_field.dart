import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_demo/sign_in/common/text_field_cubit.dart';

class SignInEmailTextFieldState extends TextFieldState {
  const SignInEmailTextFieldState();
}

class SignInEmailTextField extends StatelessWidget {
  const SignInEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit<SignInEmailTextFieldState>,
        ({String? value, String? error})>(
      builder: (context, state) {
        return TextField(
          onChanged: context
              .read<TextFieldCubit<SignInEmailTextFieldState>>()
              .onChanged,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.error,
          ),
        );
      },
    );
  }
}
