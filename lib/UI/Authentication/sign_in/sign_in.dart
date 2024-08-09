import 'package:flutter/material.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/UI/Authentication/sign_in/components/components.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignInComponents().appBar(),
      body: SafeArea(
        child: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 48),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SignInComponents().textFormField(
                      textEditingController: emailController,
                      hintText: "E-mail",
                      label: "E-mail",
                      obscureText: false,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SignInComponents().textFormField(
                      textEditingController: passwordController,
                      hintText: "Password",
                      label: "Password",
                      obscureText: true,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty & passwordController.text.isNotEmpty) {
                        Authentication().signIn(email: emailController.text.toString(), password: passwordController.text.toString()).then((isAuthenticated) {
                          if (isAuthenticated) Navigator.pushNamedAndRemoveUntil(context, "/", (context) => false);
                        });
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SignInComponents().floatingActionButton(context),
    );
  }
}
