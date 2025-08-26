import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    
  }
}
