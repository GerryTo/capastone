import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/settings/provider/theme_notifier.dart';
import 'package:capstone/modules/settings/viewmodel/settings_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Setelan'),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(context.watch<SettingsViewModel>().user?.name ??
                      'no name'),
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                        context.watch<SettingsViewModel>().user?.avatarUrl ??
                            'https://dummyimage.com/96x96/000/fff'),
                  ),
                  onTap: () => Routes.router
                      .navigateTo(context, Routes.editProfile)
                      .then((value) {
                    context.read<CurrentUserInfo>().getUserData();
                  }),
                  trailing: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                title: const Text('Setelan Akun'),
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () =>
                    Routes.router.navigateTo(context, Routes.accountSettings),
              ),
              ListTile(
                  title: const Text('Mode Gelap'),
                  leading: Icon(
                    Icons.dark_mode,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  trailing: DropdownButton(
                    onChanged: (themeMode) => context
                        .read<ThemeNotifier>()
                        .saveThemePref(themeMode as ThemeMode),
                    value: context.watch<ThemeMode>(),
                    items: const [
                      DropdownMenuItem(
                        child: Text('Setelan sistem'),
                        value: ThemeMode.system,
                      ),
                      DropdownMenuItem(
                        child: Text('Gelap'),
                        value: ThemeMode.dark,
                      ),
                      DropdownMenuItem(
                        child: Text('Cerah'),
                        value: ThemeMode.light,
                      )
                    ],
                  )),
              ListTile(
                title: const Text('Tentang'),
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {},
              ),
              ListTile(
                title:
                    const Text('Logout', style: TextStyle(color: Colors.red)),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () async {
                  await _auth.signOut();
                  Routes.router.navigateTo(context, Routes.root);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
