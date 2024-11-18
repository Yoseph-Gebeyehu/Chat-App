import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../components/custom_dialog.dart';
import '../services/auth/auth_service.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key, required this.email});
  String email;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  String _appVersion = '';

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'Version ${packageInfo.version}';
    });
  }

  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 51,
                        backgroundColor: Theme.of(context).primaryColorDark,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 50,
                          child: Text(
                            widget.email[0].toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.email),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  CustomDialog.showConfirmation(
                    context: context,
                    title: 'Logout',
                    desc: 'Are you sure to log out?',
                    onConfirm: () {
                      signOut();
                      Navigator.of(context).pop();
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  title: const Text('Logout'),
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                color: Theme.of(context).primaryColorDark.withOpacity(0.15),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              _appVersion,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: deviceSize.width * 0.036,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
