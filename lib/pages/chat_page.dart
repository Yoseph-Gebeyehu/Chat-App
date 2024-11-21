import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/custom_send_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: deviceSize.height * 0.09,
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: const Color(0xFFf0c0bf),
        // backgroundColor: const Color(0xfff9ead4),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF4B2D2D),
            ),
          )
        ],
        iconTheme: const IconThemeData(color: Color(0xFF4B2D2D)),
        title: Text(
          widget.receiveUserEmail.split('@')[0],
          style: const TextStyle(color: Color(0xFF4B2D2D)),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 1,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
            color: Color(0xFF4B2D2D),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/image.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          // Foreground content
          Container(
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: [
                Expanded(child: _buildMessageList()),
                _buildMessageInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // build message list
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
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            ),
          );
        }

        // Group messages by date
        Map<String, List<DocumentSnapshot>> groupedMessages = {};
        for (var document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String date = DateFormat('MMM d')
              .format((data['timestamp'] as Timestamp).toDate());
          groupedMessages.putIfAbsent(date, () => []).add(document);
        }

        return ListView.builder(
          itemCount: groupedMessages.keys.length,
          itemBuilder: (context, index) {
            String date = groupedMessages.keys.elementAt(index);
            List<DocumentSnapshot> dateMessages = groupedMessages[date]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Date separator row

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    date,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Messages under this date
                ...dateMessages
                    .map((document) => _buildMessageItem(document))
                    .toList(),
              ],
            );
          },
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
    return CustomSendField(
      messageController: _messageController,
      onTap: sendMessage,
    );
  }
}
