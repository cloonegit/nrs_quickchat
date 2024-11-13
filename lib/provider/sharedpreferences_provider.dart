import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/getsharedpreferences.dart';

final sharedPrefsProvider = Provider<GetSharedPreferences>((ref) {
  return GetSharedPreferences();
});

// User info providers
final userIDProvider = Provider<String>((ref) {
  return ref.watch(sharedPrefsProvider).getUserID();
});

final lastLoginStatusProvider = Provider<bool>((ref) {
  return ref.watch(sharedPrefsProvider).getLastLoginStatus();
});

// If you need state notifier for managing login state
final loginStateProvider =
    StateNotifierProvider<LoginStateNotifier, bool>((ref) {
  return LoginStateNotifier(ref.watch(sharedPrefsProvider));
});

class LoginStateNotifier extends StateNotifier<bool> {
  final GetSharedPreferences _prefs;

  LoginStateNotifier(this._prefs) : super(_prefs.getLastLoginStatus());

  Future<void> setLoginStatus(bool status) async {
    await _prefs.setLastLoginStatus(status);
    state = status;
  }
}
