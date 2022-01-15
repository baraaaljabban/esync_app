import 'package:esync_app/core/errors/error_handler.dart';
import 'package:esync_app/features/authentication/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthenticationModel> signIn({required String email, required String password});
  Future<AuthenticationModel> signUp({required String email, required String password});
}

class AuthenticationRemoteDataSourceImpl extends AuthenticationRemoteDataSource with ErrorHandler {
  @override
  Future<AuthenticationModel> signIn({required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return AuthenticationModel(usernameModel: userCredential.user?.email ?? "");
  }

  @override
  Future<AuthenticationModel> signUp({required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return AuthenticationModel(usernameModel: userCredential.user?.email ?? "");
  }
}
