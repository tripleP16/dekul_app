import 'package:communitary_service_app/config/router/app_router.dart';
import 'package:communitary_service_app/config/services/expiration_service.dart';
import 'package:communitary_service_app/config/services/token_service.dart';
import 'package:communitary_service_app/domain/repositories/auth/auth_repository.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_event.dart';
import 'package:communitary_service_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(InitialState()) {
    on<AppStartedEvent>(_onAppStarted);
    on<LoginSuccessEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  void _onAppStarted(AppStartedEvent event, Emitter<AuthState> emit) async {
    final refreshToken = await TokenService.getRefreshToken();
    final accessToken = await TokenService.getToken();
    if (refreshToken.isEmpty || refreshToken == '') {
      emit(Unauthenticated());
      return;
    }

    if (ExpirationService.isTokenAboutToExpire(refreshToken)) {
      emit(Unauthenticated());
      return;
    }

    if (accessToken.isEmpty || accessToken == '') {
      await _refreshTokens();
    }

    if (ExpirationService.isTokenAboutToExpire(accessToken)) {
      await _refreshTokens();
    }

    emit(Authenticated());
    appRouter.go('/home');
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await TokenService.deleteTokens();
    emit(Unauthenticated());
  }

  void _onLogin(LoginSuccessEvent event, Emitter<AuthState> emit) async {
    await TokenService.setRefreshToken(event.tokens.refreshToken);

    await TokenService.setToken(event.tokens.accessToken);

    emit(Authenticated());
    appRouter.go('/home');
  }

  Future<void> _refreshTokens() async {
    final refreshToken = await TokenService.getRefreshToken();

    final newTokens = await authRepository.refreshToken(refreshToken);

    await TokenService.setRefreshToken(newTokens.refreshToken);

    await TokenService.setToken(newTokens.accessToken);
  }
}
