import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/auth_result.dart';
import 'auth_state_provider.dart';

part 'is_logged_in_provider.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) => ref.watch(authStateProvider).result == AuthResult.success;
  // return authProvider.result == AuthResult.success;

