import 'package:esync_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthController extends StatefulWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  _AuthControllerState createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(GoToSignInPageEvent());
            },
            child: const Text("SignIn"),
          ),
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 5,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(GoToSignUpPageEvent());
            },
            child: const Text("SignUp"),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
