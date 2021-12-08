import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (context) => SettingsViewModel(context.read<CurrentUserInfo>()),
      builder: (context, child) {
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
                  leading: CachedNetworkImage(
                    imageUrl:
                        context.watch<SettingsViewModel>().user?.avatarUrl ??
                            'https://dummyimage.com/96x96/000/fff',
                    height: 64,
                    width: 64,
                    fit: BoxFit.fitHeight,
                  ),
                  onTap: () async {
                    Routes.router
                        .navigateTo(context, Routes.editProfile)
                        .then((value) {
                      return context.read<CurrentUserInfo>().getUserData();
                    });
                  },
                  trailing: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                title:
                    const Text('Setelan Akun', style: TextStyle(fontSize: 18)),
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () =>
                    Routes.router.navigateTo(context, Routes.accountSettings),
              ),
              ListTile(
                  title:
                      const Text('Mode Gelap', style: TextStyle(fontSize: 18)),
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
                title: const Text('Tentang', style: TextStyle(fontSize: 18)),
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Logout',
                    style: TextStyle(color: Colors.red, fontSize: 18)),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  Alert(
                    context: context,
                    style: AlertStyle(
                      isCloseButton: false,
                      animationType: AnimationType.grow,
                      titleStyle: TextStyle(
                        color: Theme.of(context).textTheme.button?.color ??
                            Colors.grey,
                      ),
                      descStyle: TextStyle(
                        color: Theme.of(context).textTheme.button?.color ??
                            Colors.grey,
                      ),
                    ),
                    type: AlertType.info,
                    title: "LOG OUT",
                    desc: "kamu yakin log out dari Gazebo ?",
                    buttons: [
                      DialogButton(
                        child: const Text(
                          "Tidak",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: const Color(0xffF23535),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      ),
                      DialogButton(
                          child: const Text(
                            "Ya",
                            style: TextStyle(fontSize: 20),
                          ),
                          border: Border.all(
                              color:
                                  Theme.of(context).textTheme.button?.color ??
                                      Colors.grey,
                              width: 1),
                          color: Colors.transparent,
                          onPressed: () async {
                            await _auth.signOut();
                            context.read<CurrentUserInfo>().clearUserData();
                            Routes.router.navigateTo(context, Routes.root);
                          })
                    ],
                  ).show();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
