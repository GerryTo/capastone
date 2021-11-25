import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/modules/settings/provider/theme_notifier.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setelan'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView(
        children: [
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
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
