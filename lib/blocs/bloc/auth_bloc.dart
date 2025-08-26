import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {

    // login
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingLoginState());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
        } catch (e) {
          print('catching on in${e.toString()}');
          emit(
            FailureLoginState(errorMessage: 'An unexpected error occurred.'),
          );
        }
      } 
      
    // register 
      
      else if (event is RegisterEvent) {
        try {
          emit(LoadingRegisterState());
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );
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
    });
  }
}
