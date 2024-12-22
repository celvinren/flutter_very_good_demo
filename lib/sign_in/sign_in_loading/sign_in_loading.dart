import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_demo/sign_in/sign_in_submit/sign_in_submit_cubit.dart';

class LoadingCubit extends Cubit<bool> {
  LoadingCubit({required this.signInSubmitCubit}) : super(false) {
    _submitSubscription = signInSubmitCubit.stream.listen((event) {
      emit(event == SignInSubmitStatus.submitting);
    });
  }

  final SignInSubmitCubit signInSubmitCubit;
  StreamSubscription<SignInSubmitStatus>? _submitSubscription;

  @override
  Future<void> close() {
    _submitSubscription?.cancel();
    return super.close();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder: (context, state) {
        return state
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.2),
                child: const Center(
                  child: CircularProgressIndicator(
                      // backgroundColor: Colors.black12,
                      ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
