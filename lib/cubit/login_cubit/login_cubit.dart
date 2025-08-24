import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/login_cubit/login_states.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitailLoginState());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoadingLoginState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SuccessLoginState());
    } on PlatformException catch (e) {
      String errorMessage = e.message ?? 'A platform error occurred.';
      emit(FailureLoginState(errorMessage: errorMessage));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address format.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        default:
          errorMessage = 'Authentication failed. Please try again.';
      }
      print(e.code);
      emit(FailureLoginState(errorMessage: errorMessage));
    } on PlatformException catch (e) {
      print('-----------------------------------------${e.toString()}');
    } catch (e) {
      print('catching on in${e.toString()}');
      emit(FailureLoginState(errorMessage: 'An unexpected error occurred.'));
    }
  }
}
