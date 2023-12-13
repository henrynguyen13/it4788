import 'package:it4788/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:it4788/model/request_friends.dart';
import 'package:it4788/service/friend_service.dart';

class RequestFriendCard extends StatefulWidget {
  final RequestFriend friend;
  const RequestFriendCard({super.key, required this.friend});

  @override
  State<RequestFriendCard> createState() => _RequestFriendCardState();
}

class _RequestFriendCardState extends State<RequestFriendCard> {
  RequestFriend? friend;
  FriendService? friendService;

  @override
  void initState() {
    super.initState();
    friend = widget.friend;
    friendService = FriendService();
  }

  Future setAcceptFriend(String id) async {
    try {
      await friendService?.setAcceptFriend(id);
      setState(() {
        friend!.isAccept = true;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future deleteFriend(String id) async {
    try {
      await friendService?.setDeleteFriend(id);
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
              radius: 45.0,
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
                        fontWeight: FontWeight.w700, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(friend!.sameFriends),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !friend!.isAccept
                          ? (FilledButton(
                              onPressed: () {
                                setAcceptFriend(friend!.id);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Palette.facebookBlue)),
                              child: const Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Chấp nhận"),
                                ],
                              )))
                          : const Text("Đã chấp nhận"),
                      !friend!.isCancel
                          ? FilledButton(
                              onPressed: () {
                                deleteFriend(friend!.id);
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
                          : const Text("Đã hủy"),
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
