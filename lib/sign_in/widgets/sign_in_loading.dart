part of '../sign_in_page.dart';

class _LoadingCubit extends Cubit<bool> {
  _LoadingCubit({required this.signInSubmitCubit}) : super(false) {
    _submitSubscription = signInSubmitCubit.stream.listen((event) {
      emit(event == _SignInSubmitStatus.submitting);
    });
  }

  final _SignInSubmitCubit signInSubmitCubit;
  StreamSubscription<_SignInSubmitStatus>? _submitSubscription;

  @override
  Future<void> close() {
    _submitSubscription?.cancel();
    return super.close();
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_LoadingCubit, bool>(
      builder: (context, state) {
        return state
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.2),
                child: const Center(child: CircularProgressIndicator()),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
