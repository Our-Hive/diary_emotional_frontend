import 'package:emotional_app/config/router/app_router_notifier.dart';
import 'package:emotional_app/features/account/auth/ui/provider/auth_provider.dart';
import 'package:emotional_app/features/account/auth/ui/screens/login_screen.dart';
import 'package:emotional_app/features/account/auth/ui/screens/sign_up_multi_step/step_account_screen.dart';
import 'package:emotional_app/features/account/auth/ui/screens/sign_up_multi_step/step_contact_screen.dart';
import 'package:emotional_app/features/account/user/ui/screens/profile_view.dart';
import 'package:emotional_app/features/history/ui/layout/history_layout.dart';
import 'package:emotional_app/features/home/ui/layouts/home_layout.dart';
import 'package:emotional_app/features/home/ui/screens/home_view.dart';
import 'package:emotional_app/features/home/ui/screens/primary_emotion_screen.dart';
import 'package:emotional_app/features/info/ui/screens/info_view.dart';
import 'package:emotional_app/features/my_space/ui/screens/my_space_view.dart';
import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
  (ref) {
    final goRouterNotifier = ref.read(goRouterNotifierProvider);
    return GoRouter(
      initialLocation: '/login',
      refreshListenable: goRouterNotifier,
      routes: [
        GoRoute(
          path: '/login',
          name: AppRoutesName.logInScreen,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signUp',
          name: AppRoutesName.signUpAccount,
          builder: (context, state) => const SignUpStepAccountScreen(),
          routes: [
            GoRoute(
              path: 'contact',
              name: AppRoutesName.signUpContact,
              builder: (context, state) => const SignUpStepContactScreen(),
            ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) => HoneLayout(childView: child),
          routes: [
            GoRoute(
              path: '/profile',
              name: AppRoutesName.profileView,
              builder: (context, state) => const ProfileView(),
            ),
            GoRoute(
              path: '/history',
              name: AppRoutesName.historyView,
              builder: (context, state) => const HistoryLayout(),
            ),
            GoRoute(
              path: '/home',
              name: AppRoutesName.homeView,
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'diary',
                  name: AppRoutesName.diaryScreen,
                  builder: (context, state) => const PrimaryEmotionScreen(),
                ),
                GoRoute(
                  path: 'transcendentalEmotions',
                  name: AppRoutesName.transcendentalScreen,
                  builder: (context, state) => const InfoView(),
                ),
              ],
            ),
            GoRoute(
              path: '/info',
              name: AppRoutesName.infoView,
              builder: (context, state) => const InfoView(),
            ),
            GoRoute(
              path: '/mySpace',
              name: AppRoutesName.mySpaceView,
              builder: (context, state) => const MySpaceView(),
            ),
          ],
        )
      ],
      redirect: (context, state) {
        final isGoingTo = state.matchedLocation;
        final authStatus = goRouterNotifier.authStatus;

        if ((isGoingTo == '/login' || isGoingTo == '/signUp') &&
            authStatus == AuthStatus.authenticated) {
          return '/home';
        }

        if ((isGoingTo == '/login' || isGoingTo == '/signUp') &&
            authStatus == AuthStatus.unAuthenticated) {
          return null;
        }

        return null;
      },
    );
  },
);
