import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(widget.email[0].toUpperCase()),
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
            title: Text('Logout'),
          ),
        ),
      ],
    );
  }
}
