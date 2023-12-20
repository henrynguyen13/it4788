import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:it4788/core/pallete.dart';
import 'package:flutter/material.dart';
import 'package:it4788/home/add_friend_screen.dart';
import 'package:it4788/home/post_detail_screen.dart';
import 'package:it4788/model/notification_list.dart';
import 'package:it4788/personal_page/personal_page.dart';

class NotificationCard extends StatefulWidget {
  final ItemNotification itemNotification;
  const NotificationCard({super.key, required this.itemNotification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late ItemNotification itemNotification;

  @override
  void initState() {
    super.initState();
    itemNotification = widget.itemNotification;
  }

  void handleClickNotification() {
    switch (itemNotification.type) {
      case "1":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddFriendScreen()),
        );
        break;
      case "2":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PersonalPage(id: itemNotification.user!.id!)),
        );
        break;
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "9":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PostDetailScreen(id: itemNotification.post!.id!)),
        );
        break;
      case "8":
        break;
      default:
    }
  }

  String formatTimeDifference(DateTime from, DateTime to) {
    Duration difference = to.difference(from);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${difference.inDays} ngày trước';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.grey,
        child: InkWell(
          onTap: () {
            handleClickNotification();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage((itemNotification.avatar !=
                            null)
                        ? (itemNotification.avatar!)
                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
                    radius: 30.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${itemNotification.user!.username} ${itemNotification.getNotificationTypeText()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          formatTimeDifference(
                                  itemNotification.created!, DateTime.now())
                              .toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
