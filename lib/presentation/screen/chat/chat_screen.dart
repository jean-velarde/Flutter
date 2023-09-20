import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/providers/theme_provider.dart';
import 'package:yes_no_app/presentation/widgets/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/other_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProviderColor>();
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder.jpg"),
            )),
        title: const Text("Chat persona 1"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                themeProvider.changeTheme();
              },
              icon: const Icon(Icons.change_circle_outlined))
        ],
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageLst.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageLst[index];
                return (message.fromWho == FromWho.mine)
                    ? MyMessageBubble(text: message)
                    : OtherMessageBubble(text: message);
              },
            )),
            MessageFieldBox(
              onValue: (value) {
                chatProvider.sendMessage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
