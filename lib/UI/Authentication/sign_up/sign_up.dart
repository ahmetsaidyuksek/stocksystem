import 'package:flutter/material.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Core/Database/database.dart';
import 'package:stocksystem/UI/Authentication/sign_in/components/components.dart';
import 'package:stocksystem/UI/Authentication/sign_up/components/components.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignUpComponents().appBar(context),
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
                      textEditingController: nameController,
                      hintText: "Name",
                      label: "Name",
                      obscureText: false,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SignInComponents().textFormField(
                      textEditingController: phoneController,
                      hintText: "Phone Number",
                      label: "Phone Number",
                      obscureText: false,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SignInComponents().textFormField(
                      textEditingController: passwordController,
                      hintText: "Password",
                      label: "Password",
                      obscureText: true,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty & phoneController.text.isNotEmpty & emailController.text.isNotEmpty & passwordController.text.isNotEmpty) {
                        Authentication().signUp(email: emailController.text.toString(), password: passwordController.text.toString()).then((isAuthenticated) {
                          if (isAuthenticated) {
                            Database().createUserFirestore(name: nameController.text.toString(), phoneNumber: int.parse(phoneController.text.toString()), email: emailController.text.toString()).then((isUserCreated) {
                              if (isUserCreated) Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
                            });
                          }
                        });
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
