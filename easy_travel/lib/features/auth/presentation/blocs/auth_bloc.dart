import 'package:easy_travel/features/auth/domain/user.dart';
import 'package:easy_travel/features/auth/presentation/blocs/auth_event.dart';
import 'package:easy_travel/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      // Simulate a login process
      await Future.delayed(Duration(seconds: 2));
      // For demonstration, we assume login is always successful
      final user = User(
        firstName: "John",
        lastName: "Doe",
        token: "dummy_token",
        emaill: event.email,
      );
      emit(AuthSuccesState(user: user));
    });
  }
  
}