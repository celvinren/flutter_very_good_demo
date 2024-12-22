part of '../sign_in_page.dart';

enum _SignInSubmitStatus { invalid, valid, submitting, success, error }

class _SignInSubmitCubit extends Cubit<_SignInSubmitStatus> {
  _SignInSubmitCubit({
    required this.emailCubit,
    required this.passwordCubit,
  }) : super(_SignInSubmitStatus.invalid) {
    _submitSubscription = CombineLatestStream.combine2(
      emailCubit.stream,
      passwordCubit.stream,
      (email, password) => (email: email, password: password),
    ).listen((event) {
      final email = event.email;
      final password = event.password;
      emit(
        email.error != null || password.error != null
            ? _SignInSubmitStatus.invalid
            : _SignInSubmitStatus.valid,
      );
    });
  }
  final TextFieldCubit<_SignInEmailTextFieldState> emailCubit;
  final TextFieldCubit<_SignInPasswordTextFieldState> passwordCubit;
  StreamSubscription<
      ({
        ({String? value, String? error}) email,
        ({String? value, String? error}) password
      })>? _submitSubscription;

  void onSubmit() {
    emit(_SignInSubmitStatus.submitting);
    Future.delayed(const Duration(seconds: 2), () {
      emit(_SignInSubmitStatus.error);
    });
  }

  @override
  Future<void> close() {
    _submitSubscription?.cancel();
    return super.close();
  }
}

class _SignInSubmitButton extends StatelessWidget {
  const _SignInSubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<_SignInSubmitCubit, _SignInSubmitStatus>(
      listener: (context, state) {
        if (state == _SignInSubmitStatus.error) {
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
            _SignInSubmitStatus.invalid => null,
            _ => context.read<_SignInSubmitCubit>().onSubmit
          },
          child: const Text('Submit'),
        );
      },
    );
  }
}
