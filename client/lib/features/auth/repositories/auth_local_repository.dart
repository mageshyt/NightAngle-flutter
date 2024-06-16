import 'package:nightAngle/core/localstorage/storage_utility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  final storage = LocalStorage();

  void setToken(String? token) {
    if (token != null) storage.saveData('token', token);
  }

  String? getToken() {
    return storage.readData('token');
  }
}
