import 'package:bloc/bloc.dart';
import 'package:esync_app/core/helpers/validation_helper.dart';
import 'package:esync_app/features/authentication/domain/usecases/sign_in.dart';
import 'package:esync_app/features/authentication/domain/usecases/sign_up.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> with ValidationHelper {
  final SignIn signInUseCase;
  final SignUp signUpUseCase;
  bool isLoggedIn = false;
  String username = "";
  AuthenticationBloc({required this.signInUseCase, required this.signUpUseCase}) : super(AuthenticationInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<GoToSignInPageEvent>(_onGoToSignInPageEvent);
    on<GoToSignUpPageEvent>(_onGoToSignUpPageEvent);
  }

  _onSignInEvent(SignInEvent event, Emitter<AuthenticationState> emit) async {
    String pass = event.params.password;
    String email = event.params.email;

    if (pass.isEmpty || email.isEmpty) {
      emit(ErrorAuthenticationState(message: "Please fill all above info"));
      return false;
    } else if (!validateEmail(text: email)) {
      emit(ErrorAuthenticationState(message: "enter correct email format please"));
      return false;
    } else if (pass.length < 6) {
      emit(ErrorAuthenticationState(message: "password is too short"));
      return false;
    } else {
      emit(LoadingAuthenticationState());
      final result = await signInUseCase.call(params: event.params);
      result.fold(
        (left) => emit(ErrorAuthenticationState(message: left.message)),
        (right) => {
          isLoggedIn = true,
          username = right.username,
          emit(UserSignedInAuthenticationState(username: username)),
        },
      );
    }
  }

  _onSignUpEvent(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    String pass = event.params.password;
    String email = event.params.email;

    if (pass.isEmpty || email.isEmpty) {
      emit(ErrorAuthenticationState(message: "Please fill all above info"));
      return false;
    } else if (!validateEmail(text: email)) {
      emit(ErrorAuthenticationState(message: "enter correct email format please"));
      return false;
    } else if (pass.length < 6) {
      emit(ErrorAuthenticationState(message: "password is too short"));
      return false;
    } else {
      emit(LoadingAuthenticationState());
      final result = await signUpUseCase.call(params: event.params);
      result.fold(
        (left) => emit(ErrorAuthenticationState(message: left.message)),
        (right) => {
          isLoggedIn = true,
          username = right.username,
          emit(UserSignedInAuthenticationState(username: username)),
        },
      );
    }
  }

  _onGoToSignInPageEvent(GoToSignInPageEvent event, Emitter<AuthenticationState> emit) async {
    emit(GoToSignInPageState());
  }

  _onGoToSignUpPageEvent(GoToSignUpPageEvent event, Emitter<AuthenticationState> emit) async {
    emit(GoToSignUpPageState());
  }
}
