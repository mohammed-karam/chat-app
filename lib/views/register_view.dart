import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatelessWidget {
  static String id = 'registerView';

  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (BuildContext context, state) {
        if (state is LoadingRegisterState) {
          isLoading = true;
        } else if (state is FailureRegisterState) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        } else if (state is SuccessRegisterState) {
          isLoading = false;
          Navigator.pushNamed(context, ChatView.id);
        }
      },
      builder: (BuildContext context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 75),
                    Image.asset(kLogo, height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar App',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 75),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                      hint: 'Email',
                      onChanged: (data) {
                        email = data;
                        // print(email);
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomFormTextField(
                      hint: 'Password',
                      onChanged: (data) {
                        password = data;
                        // print(password);
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      text: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await BlocProvider.of<AuthCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
                        } else {
                          showSnackBar(context, 'Sign up failed');
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
