import 'package:flutter/material.dart';

class CustomSendField extends StatefulWidget {
  const CustomSendField({
    super.key,
    required this.messageController,
    required this.onTap,
  });

  final TextEditingController messageController;
  final void Function()? onTap;

  @override
  State<CustomSendField> createState() => _CustomSendFieldState();
}

class _CustomSendFieldState extends State<CustomSendField> {
  bool isMessageEmpty = true;

  @override
  void initState() {
    super.initState();
    // Add a listener to the controller
    widget.messageController.addListener(_onMessageChanged);
  }

  void _onMessageChanged() {
    // Check if the message is empty and update state
    final isEmpty = widget.messageController.text.isEmpty;
    if (isMessageEmpty != isEmpty) {
      setState(() {
        isMessageEmpty = isEmpty;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    widget.messageController.removeListener(_onMessageChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).primaryColorDark.withOpacity(0.1),
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 1),
      padding: EdgeInsets.symmetric(
        horizontal: deviceSize.width * 0.05,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: 4,
              minLines: 1,
              controller: widget.messageController,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                hintText: 'Write message here...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: isMessageEmpty ? null : widget.onTap,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: isMessageEmpty
                    ? Theme.of(context).primaryColorDark.withOpacity(0.3)
                    : Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
