import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({super.key});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutesName.profileView);
        break;
      case 1:
        context.goNamed(AppRoutesName.historyView);
        break;
      case 2:
        context.goNamed(AppRoutesName.homeView);
        break;
      case 3:
        context.goNamed(AppRoutesName.infoView);
        break;
      case 4:
        context.goNamed(AppRoutesName.mySpaceView);
        break;
      default:
    }
  }

  int _getCurrentIndex(
    BuildContext context,
  ) {
    final String? path = GoRouterState.of(context).fullPath;
    final String principalPath = path!.split('/')[1];
    switch (principalPath) {
      case 'profile':
        return 0;
      case 'history':
        return 1;
      case 'home':
        return 2;
      case 'info':
        return 3;
      case 'mySpace':
        return 4;
      default:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (indexSelected) => _onItemTapped(context, indexSelected),
      currentIndex: _getCurrentIndex(context),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
          ),
          activeIcon: Icon(
            Icons.person,
          ),
          label: 'Perfil',
          backgroundColor: Color(0xFFDECAAD),
          tooltip: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history_toggle_off_outlined,
          ),
          activeIcon: Icon(
            Icons.history,
          ),
          label: 'Historial',
          backgroundColor: Color(0xffADD7DE),
          tooltip: 'Historial de emociones',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.sentiment_satisfied_outlined,
          ),
          activeIcon: Icon(
            Icons.sentiment_very_satisfied,
          ),
          label: 'Emociones',
          backgroundColor: Color(0xFFADDEB6),
          tooltip: 'Registro de emociones',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.info_outline,
          ),
          activeIcon: Icon(
            Icons.info,
          ),
          label: 'Información',
          backgroundColor: Color(0xffC3ADDE),
          tooltip: 'Información psicológica',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border_outlined,
          ),
          activeIcon: Icon(
            Icons.favorite,
          ),
          label: 'Mi Espacio',
          backgroundColor: Color(0xffDEADCC),
          tooltip: 'Mi espacio',
        ),
      ],
    );
  }
}
