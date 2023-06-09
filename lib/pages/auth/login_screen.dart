import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storys_apps/provider/auth_provider.dart';
import 'package:storys_apps/utils/style.dart';
import 'package:storys_apps/widget/button_widget.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/story.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Story Apps',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      return null;
                    },
                    cursorColor: secondaryColor,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: secondaryColor,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      if (value.length < 6) {
                        return 'Your password less than six character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  context.watch<AuthProvider>().isLoadingLogin
                      ? const Center(
                          child: CircularProgressIndicator(
                          backgroundColor: secondaryColor,
                        ))
                      : ButtonWidget(
                          text: 'Login',
                          radius: 8,
                          paddingHorizontal: 15,
                          paddingVertical: 15,
                          width: double.infinity,
                          height: 50,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              final authRead = context.read<AuthProvider>();

                              final result = await authRead.login(
                                emailController.text,
                                passwordController.text,
                              );
                              if (result.error == false) {
                                widget.onLogin();
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    backgroundColor: successColor,
                                    content: Text("Success Login akun"),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => widget.onRegister(),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
