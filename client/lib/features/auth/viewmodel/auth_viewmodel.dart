import 'package:fpdart/fpdart.dart';
import 'package:nightAngle/core/http/failure.dart';
import 'package:nightAngle/core/logger/logger.dart';
import 'package:nightAngle/core/providers/current_user_notifier.dart';
import 'package:nightAngle/features/auth/model/user-model.dart';
import 'package:nightAngle/features/auth/repositories/auth_local_repository.dart';
import 'package:nightAngle/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

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
    LoggerHelper.error('ERROR ' + res.toString());
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
      Right(value: final r) => _loginSuccess(r),
    };

    LoggerHelper.debug(val.toString());
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getCurrentUser() async {
    state = const AsyncValue.loading();

    final token = _authLocalRepository.getToken();
    LoggerHelper.debug('[TOKEN]: $token');
    if (token == null) {
      return null;
    }

    final res = await _authRemoteRepository.getCurrentUser(token);

    final val = switch (res) {
      Left(value: final l) => _handleFailure(l),
      Right(value: final r) => _getDataSuccess(r),
    };

    return val?.when(
      data: (data) => data,
      loading: () => null,
      error: (error, stackTrace) => null,
    );
  }

  AsyncValue<UserModel>? _handleFailure(HttpFailure failure) {
    _currentUserNotifier.removeUser();
    return state = AsyncValue.error(failure.message, StackTrace.current);
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);

    return state = AsyncValue.data(user);
  }
}
