import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/account/auth/ui/widgets/date_field.dart';
import 'package:emotional_app/features/account/user/ui/provider/edit_user_form_provider.dart';
import 'package:emotional_app/features/support_network/ui/widgets/support_network_button.dart';
import 'package:emotional_app/shared/domain/utils/random_color.dart';
import 'package:emotional_app/shared/ui/password_form_field.dart';
import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/ui/provider/disable_form_provider.dart';
import 'package:emotional_app/features/account/user/ui/provider/user_provider.dart';
import 'package:emotional_app/shared/domain/utils/date_time_formatter.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
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
    final Color randomColor = RandomColor.generate();

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
    ref.listen(
      editUserFormProvider,
      (previous, next) {
        if (next.isSuccess) {
          ref.read(userProvider.notifier).getUser();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Usuario actualizado'),
              backgroundColor: appColors.primary,
            ),
          );
        }
        if (next.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Ha ocurrido un error al actualizar el usuario, intente de nuevo",
                style: TextStyle(color: appColors.onError),
              ),
              backgroundColor: appColors.error,
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: OurHiveAppBar(
        title: 'Perfil',
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
                        color: randomColor,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: EditUserButton(),
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
                  const SizedBox(height: 20),
                  SupportNetworkButton(color: randomColor),
                  const SizedBox(height: 20),
                  UserDataGrid(
                    user: user,
                  ),
                  const SizedBox(height: 40),
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

class EditUserButton extends ConsumerWidget {
  const EditUserButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).colorScheme;
    final user = ref.watch(userProvider).currentUser;
    const separator = SizedBox(height: 15);
    return IconButton(
      icon: const Icon(
        Icons.edit,
        size: 30,
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Editar perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              separator,
              _ActiveTextFormField(
                appColors: appColors,
                primaryText: user.userName,
                secondaryText: user.userName,
                onChange: (value) => ref
                    .watch(editUserFormProvider.notifier)
                    .onUserNameChange(value),
              ),
              separator,
              _ActiveTextFormField(
                appColors: appColors,
                primaryText: 'Teléfono',
                secondaryText: user.phoneNumber,
                onChange: (value) => ref
                    .read(editUserFormProvider.notifier)
                    .onPhoneChange(value),
              ),
              separator,
              DateField(
                onChange: (dateTime) => ref
                    .watch(editUserFormProvider.notifier)
                    .onBirthDateChange(dateTime),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                overlayColor: appColors.error,
              ),
              child: Text(
                'Cancelar',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: appColors.error),
              ),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: appColors.primary,
                foregroundColor: appColors.onPrimary,
              ),
              child: const Text('Guardar'),
              onPressed: () {
                ref.read(editUserFormProvider.notifier).onSubmit();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserDataGrid extends StatelessWidget {
  const UserDataGrid({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
      ),
      shrinkWrap: true,
      children: [
        TextGrid(
          text: "Username:",
          crossAxisAlignmentText: CrossAxisAlignment.start,
        ),
        TextGrid(
          text: user.userName,
          crossAxisAlignmentText: CrossAxisAlignment.end,
        ),
        TextGrid(
          text: 'Teléfono:',
          crossAxisAlignmentText: CrossAxisAlignment.start,
        ),
        TextGrid(
          text: user.phoneNumber,
          crossAxisAlignmentText: CrossAxisAlignment.end,
        ),
        TextGrid(
          text: 'Fecha de nacimiento:',
          crossAxisAlignmentText: CrossAxisAlignment.end,
        ),
        TextGrid(
          text: DateTimeFormatter.getFormattedDate(
            user.birthDate,
          ),
          crossAxisAlignmentText: CrossAxisAlignment.end,
        ),
      ],
    );
  }
}

class TextGrid extends StatelessWidget {
  final String text;
  final CrossAxisAlignment crossAxisAlignmentText;

  const TextGrid({
    super.key,
    required this.text,
    required this.crossAxisAlignmentText,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignmentText,
      children: [
        Text(
          text,
          style: textTheme.titleMedium,
        ),
      ],
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
                    ref.read(disableFormProvider.notifier).onSubmit();
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
  final Function(String) onChange;

  const _ActiveTextFormField({
    required this.appColors,
    required this.primaryText,
    required this.secondaryText,
    required this.onChange,
  });

  @override
  State<_ActiveTextFormField> createState() => _ActiveTextFormFieldState();
}

class _ActiveTextFormFieldState extends State<_ActiveTextFormField> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => setState(() => isSelected ? false : true),
      onChanged: widget.onChange,
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
