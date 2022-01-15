import 'package:esync_app/features/authentication/domain/entities/auth_entity.dart';

class AuthenticationModel extends AuthenticationEntity {
  final String usernameModel;

  AuthenticationModel({required this.usernameModel}) : super(username: usernameModel);

  @override
  String toString() => 'AuthenticationModel(usernameModel: $usernameModel)';
}
