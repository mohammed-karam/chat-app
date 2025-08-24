import 'package:chat_app/cubit/register_cubit/register_states.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitailRegisterState());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoadingRegisterState());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SuccessRegisterState());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        default:
          errorMessage = 'Firebase error: ${e.code}';
      }
      emit(FailureRegisterState(errorMessage: errorMessage));
    } catch (e) {
      emit(FailureRegisterState(errorMessage: e.toString()));
    }
  }
}
