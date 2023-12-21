import 'package:flutter/material.dart';
import 'package:it4788/core/pallete.dart';
import 'package:it4788/model/notification_list.dart';
import 'package:it4788/service/notification_service.dart';
import 'package:it4788/widgets/notice_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  int index = 0;
  int count = 20;
  bool isLoading = false;
  late NotificationService notificationService;
  List<ItemNotification> notificationList = <ItemNotification>[];
  Future<ListNotification?>? _future;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreData();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        index += count; // Increment the index to load the next set of data
      });
      var tmp = await notificationService.getNotiList(index, count);

      if (tmp != null) {
        setState(() {
          notificationList.addAll(tmp.data!);
          isLoading = false;
        });
      }
    }
  }

  void getData() async {
    notificationService = NotificationService();
    _future = notificationService.getNotiList(index, count);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              notificationList.isEmpty) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Palette.facebookBlue,
                ));
          } else if (snapshot.hasData) {
            if (notificationList.isEmpty) {
              notificationList.addAll(snapshot.data!.data!);
            }
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return NotificationCard(
                      itemNotification: notificationList[index],
                    );
                  }, childCount: notificationList.length),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }
}
