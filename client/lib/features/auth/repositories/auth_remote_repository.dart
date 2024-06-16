import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/logger/logger.dart';

class AuthRemoteRepository {
  final client = DioClient();

  Future<void> login(String email, String password) async {
    try {
      final response = await client.post('/auth/signup', {
        'email': email,
        'password': password,
      });

      LoggerHelper.info(response.toString());
    } catch (e) {
      LoggerHelper.error(e.toString());
    }
  }
}
