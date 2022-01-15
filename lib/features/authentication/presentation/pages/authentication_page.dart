import 'package:esync_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:esync_app/features/authentication/presentation/widgets/auth_controller.dart';
import 'package:esync_app/features/authentication/presentation/widgets/profile_controller.dart';
import 'package:esync_app/features/authentication/presentation/widgets/signin_controller.dart';
import 'package:esync_app/features/authentication/presentation/widgets/signup_conroller.dart';
import 'package:esync_app/features/common/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) {
          if (current is LoadingAuthenticationState || current is ErrorAuthenticationState) {
            return false;
          } else {
            return true;
          }
        },
        listener: (context, state) {
          if (state is ErrorAuthenticationState) {
            SnackBarHelper.showErrorSnackBar(context, message: state.message);
          } else if (state is LoadingAuthenticationState) {
            SnackBarHelper.showLoadingSnackBar(context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is GoToSignInPageState) {
                      return const SignInController();
                    } else if (state is GoToSignUpPageState) {
                      return const SignUpController();
                    } else if (state is UserSignedInAuthenticationState) {
                      return ProfileController(username: state.username);
                    } else {
                      return const SignInController();
                    }
                  },
                ),
              ),
              const Expanded(flex: 2, child: AuthController()),
            ],
          );
        },
      ),
    );
  }
}
