import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/shared/domain/utils/random_color.dart';
import 'package:emotional_app/shared/ui/password_form_field.dart';
import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/ui/provider/disable_form_provider.dart';
import 'package:emotional_app/features/account/user/ui/provider/user_provider.dart';
import 'package:emotional_app/shared/domain/utils/date_time_formatter.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_multicolor_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).getUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ref.watch(userProvider).currentUser;
    final appColors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    ref.listen(userProvider, (previous, next) {
      if (next.status == UserStatus.disabled) {
        context.goNamed(AppRoutesName.logInScreen);
      }
      if (next.status == UserStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.errorMessage,
              style: TextStyle(color: appColors.onError),
            ),
            backgroundColor: appColors.error,
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      OurHiveColorIcon(
                        color: RandomColor.generate(),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 30,
                          ),
                          onPressed: () => print('Pressed'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Hola\r${user.firstName}\r${user.lastName}',
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontWeight: textTheme.titleMedium!.fontWeight,
                      fontSize: textTheme.titleMedium!.fontSize,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // todo: organize with a grid
                  Text(
                    'Username: ${user.userName}',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Teléfono: ${user.phoneNumber}',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Fecha de nacimiento: ${DateTimeFormatter.getFormattedDate(
                      user.birthDate,
                    )}',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: appColors.onSecondary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FilledButton.icon(
                      onPressed: () => print('Pressed'),
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.secondary,
                        foregroundColor: appColors.onSecondary,
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar perfil'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  FilledButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => _DisableAccountDialog(
                        appColors: appColors,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: appColors.error,
                      foregroundColor: appColors.onError,
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text('Deshabilitar cuenta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DisableAccountDialog extends ConsumerWidget {
  final ColorScheme appColors;
  const _DisableAccountDialog({
    required this.appColors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      icon: Icon(
        Icons.warning,
        color: appColors.error,
        size: 50,
      ),
      title: const Text(
        'Esta seguro de deshabilitar la cuenta?',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Para deshabilitar su cuenta ingrese su contraseña.',
      ),
      actions: <Widget>[
        PasswordFormField(
          onChangedCallBack: (value) => ref
              .watch(disableFormProvider.notifier)
              .onSecurityPasswordChanged(value.trim().toLowerCase()),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final isValidated =
                    ref.read(disableFormProvider.notifier).onSummit();
                if (isValidated) {
                  ref.read(userProvider.notifier).disableUser(
                        ref.read(disableFormProvider).securityPassword,
                      );
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: appColors.error,
                foregroundColor: appColors.onError,
              ),
              child: const Text('Deshabilitar'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActiveTextFormField extends StatefulWidget {
  final ColorScheme appColors;
  final String primaryText;
  final String secondaryText;

  const _ActiveTextFormField({
    required this.appColors,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  State<_ActiveTextFormField> createState() => _ActiveTextFormFieldState();
}

class _ActiveTextFormFieldState extends State<_ActiveTextFormField> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () => setState(() => isSelected ? false : true),
      decoration: InputDecoration(
        labelText: isSelected ? widget.primaryText : widget.secondaryText,
        hintText: !isSelected ? widget.primaryText : widget.secondaryText,
        labelStyle: TextStyle(color: widget.appColors.primary),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.appColors.primary,
          ),
        ),
      ),
    );
  }
}
