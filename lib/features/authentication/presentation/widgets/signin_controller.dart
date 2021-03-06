import 'package:esync_app/features/authentication/domain/usecases/sign_in.dart';
import 'package:esync_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInController extends StatefulWidget {
  const SignInController({Key? key}) : super(key: key);

  @override
  _SignInControllerState createState() => _SignInControllerState();
}

class _SignInControllerState extends State<SignInController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign-in",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: const InputDecoration(filled: true, hintText: "email"),
              controller: _emailController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(filled: true, hintText: "password"),
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => dispatchLogin(),
              child: const Text("sgin-in"),
            ),
          ],
        ),
      ),
    );
  }

  void dispatchLogin() {
    BlocProvider.of<AuthenticationBloc>(context).add(
      SignInEvent(
        params: SignInParams(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      ),
    );
  }
}
