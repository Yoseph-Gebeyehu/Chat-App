import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiveUserEmail;
  final String receivedUserID;
  const ChatPage({
    super.key,
    required this.receiveUserEmail,
    required this.receivedUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send  message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receivedUserID,
        _messageController.text,
      );
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        // backgroundColor: Theme.of(context).primaryColorDark,
        backgroundColor: const Color(0xfff9ead4),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(deviceSize.height * 0.035),
          child: Divider(
            color: Theme.of(context).primaryColorDark,
            thickness: 0.2,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        title: Text(
          widget.receiveUserEmail,
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Chat content on top of the background image
          Column(
            children: [
              // Messages
              Expanded(child: _buildMessageList()),

              // User input
              _buildMessageInput(),
            ],
          ),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receivedUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item

  Widget _buildMessageItem(DocumentSnapshot document) {
    Size deviceSize = MediaQuery.of(context).size;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    // align the messages to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: deviceSize.width * 0.02,
              vertical: 5,
            ),
            child: ChatBubble(
              isUser: data['senderId'] == _firebaseAuth.currentUser!.uid,
              message: data['message'],
              data: data,
            ),
          ),
        ],
      ),
    );
  }

  // build message input

  Widget _buildMessageInput() {
    return Row(
      children: [
        // textfield
        Expanded(
          child: CustomTextField(
            controller: _messageController,
            hintText: 'Enter message',
            obscureText: false,
          ),
        ),
        // send button
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
            size: 40,
          ),
        ),
      ],
    );
  }
}
