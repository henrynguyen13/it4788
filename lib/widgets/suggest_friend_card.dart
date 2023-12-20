import 'package:it4788/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:it4788/model/suggest_friends.dart';
import 'package:it4788/service/friend_service.dart';

class SuggestedFriendCard extends StatefulWidget {
  final SuggestedFriend friend;
  SuggestedFriendCard({super.key, required this.friend});

  @override
  State<SuggestedFriendCard> createState() => _SuggestedFriendCardState();
}

class _SuggestedFriendCardState extends State<SuggestedFriendCard> {
  SuggestedFriend? friend;
  FriendService? friendService;

  @override
  void initState() {
    super.initState();
    friend = widget.friend;
    friendService = FriendService();
  }

  Future setRequestFriend(String id) async {
    try {
      await friendService?.setRequestFriend(id);
      setState(() {
        friend!.isRequested = true;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRequestFriend(String id) async {
    try {
      setState(() {
        friend!.isCancel = true;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(friend!.avatar),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend!.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      !friend!.isRequested
                          ? (FilledButton(
                              onPressed: () {
                                setRequestFriend(friend!.id);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Palette.facebookBlue)),
                              child: const Row(
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                    "Thêm bạn bè",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              )))
                          : const Text("Đã gửi lời mời"),
                      const Expanded(child: SizedBox()),
                      !friend!.isCancel
                          ? FilledButton(
                              onPressed: () {
                                deleteRequestFriend(friend!.id);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Palette.scaffold),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.grey;
                                    }
                                    return Palette.scaffold;
                                  },
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.cancel),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Gỡ"),
                                ],
                              ))
                          : const Text("Đã gỡ"),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
