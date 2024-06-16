import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/core/logger/logger.dart';
import 'package:nightAngle/features/auth/model/user-model.dart';
import 'package:nightAngle/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    // set teh state to loading
    state = const AsyncValue.loading();
    // call the register method from the repository
    final res = await _authRemoteRepository.register(
        email: email, password: password, name: name);

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };

    LoggerHelper.debug(val.toString());
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    // set the state to loading
    state = const AsyncValue.loading();
    // call the login method from the repository
    final res =
        await _authRemoteRepository.login(email: email, password: password);

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };

    LoggerHelper.debug(val.toString());
  }
}
