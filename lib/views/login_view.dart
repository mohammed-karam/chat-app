import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/cubit/login_cubit/login_states.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();

  static String id = 'loginView';

  bool isLoading = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        // Handle state changes here
        if (state is LoadingLoginState) {
          isLoading = true;
        } else if (state is SuccessLoginState) {
          isLoading = false;
          Navigator.pushNamed(context, ChatView.id);
        } else if (state is FailureLoginState) {
          isLoading = false;
          showSnackBar(context, state.errorMessage);
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
                          'Sign In',
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                      hint: 'Email',
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomFormTextField(
                      hint: 'Password',
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      text: 'Sign In',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // Just trigger the login - the listener will handle the response
                          try {
                            BlocProvider.of<LoginCubit>(
                              context,
                            ).loginUser(email: email!, password: password!);
                          } catch (e) {}
                        } else {
                          showSnackBar(
                            context,
                            'Please fill all fields correctly',
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don\'t have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: Text(
                            'Sign Up',
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
