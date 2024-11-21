import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final Map<String, dynamic> data;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
        minWidth: MediaQuery.of(context).size.width * 0.2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              border: Border.all(
                color: Theme.of(context).primaryColorDark,
                width: 0.1,
              ),
              color: isUser
                  ? const Color(0xfff9ead4)
                  : Theme.of(context).primaryColor,
            ),
            child: SelectableText(
              message,
              style: TextStyle(
                fontSize: 16,
                color: isUser ? Colors.black : Colors.black,
              ),
            ),
          ),
          Text(
            data['timestamp'] != null
                ? DateFormat('h:mm a').format(
                    (data['timestamp'] as Timestamp).toDate(),
                  )
                : 'No timestamp',
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
