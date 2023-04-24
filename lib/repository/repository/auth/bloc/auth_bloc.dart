import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:prototype3/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../auth_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignInRequested>((event, emit) async {
      emit(AuthenticationInitial());
      if (event is SignInRequested){
        UserModel user = await authRepository.getCurrentUser().first;
        if (user.uid != "uid") {
          String? displayName = await authRepository.retrieveUserName(user);
          emit(Authenticated(displayName: displayName));
        } else {
          emit(UnAuthenticated());
        }
      }
    // When User Presses the SignUp Button, we will send the SignUpRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    else if(event is SignOutRequested){
      await authRepository.signOut();
        emit(UnAuthenticated());
      }
    });
    // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    // on<GoogleSignInRequested>((event, emit) async {
    //   emit(Loading());
    //   try {
    //     await authRepository.signInWithGoogle();
    //     emit(Authenticated());
    //   } catch (e) {
    //     emit(AuthError(e.toString()));
    //     emit(UnAuthenticated());
    //   }
    // });
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(AuthenticationInitial());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
