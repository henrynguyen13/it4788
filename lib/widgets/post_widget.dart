import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/post_model.dart';




class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(post.user.imageUrl!),
                )
                ,
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      post.timeAgo,
                      style:const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:const EdgeInsets.all(8.0),
            child: Text(post.caption),
          ),
          if (post.imageUrl != null) Image.network(post.imageUrl!),
          const Divider(height: 10.0, thickness: 1.0),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        print("Press Like");
                      },
                      style:const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.thumb_up),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(post.likes.toString()),
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: TextButton(
                      style:const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.grey)
                      ),
                      onPressed: () {
                        print("Press Comment!");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.comment),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(post.comments.toString()),
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                  ),
                  Expanded(
                    child: TextButton(
                      style:const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(Colors.grey)
                      ),
                      onPressed: () {
                        print("Press shared");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.share),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(post.shares.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
