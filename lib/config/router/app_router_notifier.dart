import 'package:emotional_app/features/account/auth/ui/provider/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider<GoRouterNotifier>(
  (ref) {
    final authNotifier = ref.read(authProvider.notifier);
    return GoRouterNotifier(authNotifier);
  },
);

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.verifying;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
