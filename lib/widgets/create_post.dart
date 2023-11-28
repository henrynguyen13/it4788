import 'package:it4788/core/pallete.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage(currentUser.imageUrl!),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FilledButton(
                        onPressed: () => print("Live"),
                        child:const Row(
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Icon(Icons.add, color: Colors.white,),
                            SizedBox(width: 15.0, height: 5.0,),
                            Text("Create Post",
                                textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                          ],
                        ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () => print("Live"),
                      child:const Icon(Icons.image, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
