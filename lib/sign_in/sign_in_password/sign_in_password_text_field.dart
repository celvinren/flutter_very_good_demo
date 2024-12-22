import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_demo/sign_in/common/text_field_cubit.dart';

class SignInPasswordTextFieldState extends TextFieldState {
  const SignInPasswordTextFieldState();
}

class SignInPasswordTextField extends StatelessWidget {
  const SignInPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit<SignInPasswordTextFieldState>,
        ({String? value, String? error})>(
      builder: (context, state) {
        return TextField(
          onChanged: context
              .read<TextFieldCubit<SignInPasswordTextFieldState>>()
              .onChanged,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.error,
          ),
        );
      },
    );
  }
}
