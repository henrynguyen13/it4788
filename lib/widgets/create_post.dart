import 'package:it4788/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/post_article/post_article.dart';

class CreatePostContainer extends StatelessWidget {
  final UserInfor currentUser;

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
                  backgroundImage: NetworkImage(currentUser
                          .data.avatar.isNotEmpty
                      ? currentUser.data.avatar
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                MaterialButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostArticle(),
                                  settings: const RouteSettings(name: '/home')))
                        },
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 140, 139, 139)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Text(
                          "Bạn đang nghĩ gì?",
                          style:
                              TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           FilledButton(
          //             onPressed: () => {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => PostArticle()),
          //               )
          //             },
          //             child: const Row(
          //               textBaseline: TextBaseline.alphabetic,
          //               children: [
          //                 Icon(
          //                   Icons.add,
          //                   color: Colors.white,
          //                 ),
          //                 SizedBox(
          //                   width: 15.0,
          //                   height: 5.0,
          //                 ),
          //                 Text(
          //                   "Create Post",
          //                   textAlign: TextAlign.end,
          //                   style: TextStyle(color: Colors.white),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           FilledButton(
          //             onPressed: () => print("Live"),
          //             child: const Icon(Icons.image, color: Colors.white),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
