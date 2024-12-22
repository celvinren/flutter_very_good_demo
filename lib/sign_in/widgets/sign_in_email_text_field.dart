part of '../sign_in_page.dart';

class _SignInEmailTextFieldState extends TextFieldState {
  const _SignInEmailTextFieldState();
}

class _SignInEmailTextField extends StatelessWidget {
  const _SignInEmailTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit<_SignInEmailTextFieldState>,
        ({String? value, String? error})>(
      builder: (context, state) {
        return TextField(
          onChanged: context
              .read<TextFieldCubit<_SignInEmailTextFieldState>>()
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
