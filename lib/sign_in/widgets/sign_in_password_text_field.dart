part of '../sign_in_page.dart';

class _SignInPasswordTextFieldState extends TextFieldState {
  const _SignInPasswordTextFieldState();
}

class _SignInPasswordTextField extends StatelessWidget {
  const _SignInPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit<_SignInPasswordTextFieldState>,
        ({String? value, String? error})>(
      builder: (context, state) {
        return TextField(
          onChanged: context
              .read<TextFieldCubit<_SignInPasswordTextFieldState>>()
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
