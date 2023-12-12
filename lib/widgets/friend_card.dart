import 'package:it4788/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:it4788/model/user_friends.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;

  FriendCard({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(friend.avatar!),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.username!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("5 bạn chung"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Palette.facebookBlue)),
                          child: const Row(
                            children: [
                              Icon(Icons.add),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text("Add friend"),
                            ],
                          )),
                      FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Palette.scaffold),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
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
                              Text("Cancel"),
                            ],
                          )),
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
