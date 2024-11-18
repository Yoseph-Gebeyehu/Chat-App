import 'package:chat_app/pages/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: Theme.of(context).primaryColorDark,
      onRefresh: () async {
        _buildUserListItem;
      },
      child: Scaffold(
        drawer: Drawer(
          child: CustomDrawer(
            email: _auth.currentUser!.email!,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Chat App',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: deviceSize.height * 0.09,
        ),
        body: Container(
          color: Colors.white,
          child: _buildUserList(),
        ),
      ),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            ),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  // build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Size deviceSize = MediaQuery.of(context).size;
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    DateTime now = DateTime.now();
    DateTime exampleDate =
        DateTime.parse(data['lastLogin'] ?? DateTime.now().toString());

    // Format the date based on whether it's today or not
    String formattedDateTime;
    if (now.day == exampleDate.day &&
        now.month == exampleDate.month &&
        now.year == exampleDate.year) {
      // Format as time if the date is today
      formattedDateTime = DateFormat('h:mm a').format(exampleDate);
    } else {
      // Format as 'MMM dd' if the date is not today
      formattedDateTime = DateFormat('MMM dd').format(exampleDate);
    }

    // display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return Column(
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColorDark),
                borderRadius: BorderRadius.circular(25),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 25,
                child: Text(data['email'][0].toString().toUpperCase()),
              ),
            ),
            title: Text(data['email']),
            subtitle: Text(
              data['uid'],
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text(formattedDateTime), // Use the formatted date
            onTap: () {
              // pass the clicked user's UID to the chat page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiveUserEmail: data['email'],
                    receivedUserID: data['uid'],
                  ),
                ),
              );
            },
          ),
          Divider(
            indent: deviceSize.width * 0.15,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
