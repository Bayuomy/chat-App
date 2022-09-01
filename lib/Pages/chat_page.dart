import 'package:chatapp/helper/constant.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_buble.dart';

class Chat_page extends StatefulWidget {
  Chat_page({Key? key}) : super(key: key);
  static String Id = ' Chat_page';

  @override
  State<Chat_page> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Chat_page> {
  final ScrollController _controller = ScrollController();
  CollectionReference Messages =
      FirebaseFirestore.instance.collection(KmessageCollections);

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: Messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagelist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagelist.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: Colors.blueGrey,
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    const Text("Chat"),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messagelist.length,
                          itemBuilder: (context, index) {
                            return messagelist[index].id == email
                                ? Chat_buble(
                                    message: messagelist[index],
                                  )
                                : Chat_bubleForFriend(
                                    message: messagelist[index],
                                  );
                          })),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: ((data) {
                        Messages.add({
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          "id": email,
                        });
                        controller.clear();

                        _controller.animateTo(
                          0,
                          duration: Duration(microseconds: 2),
                          curve: Curves.fastOutSlowIn,
                        );
                      }),
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: Icon(
                            Icons.send,
                            color: KprimiryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: KprimiryColor),
                          )),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('is loading');
          }
        }));
  }
}
