import 'package:it4788/widgets/notice_card.dart';
import 'package:flutter/widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return const NotificationCard();
          }, childCount: 5),
        )
      ],
    );
  }
}
