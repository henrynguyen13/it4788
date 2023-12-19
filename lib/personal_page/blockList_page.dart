import 'package:flutter/material.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/block_service.dart';

import '../model/blocked_user.dart';
import '../service/post_sevice.dart';

class BlockListPage extends StatefulWidget {
  const BlockListPage({super.key});

  @override
  State<BlockListPage> createState() => _BlockListPageState();
}

class _BlockListPageState extends State<BlockListPage> {
  late Future<List<BlockedUser>?>? _future;

  Future<void> getData() async {
    _future = getBlockList(0, 10);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<BlockedUser> listBlocked = snapshot.data!;
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Danh sách chặn"),
                ),
                body: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      10,
                      0,
                      0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      for (var i = listBlocked.length - 1; i >= 0; i--)
                        BlockUserWidget(
                          blockedUser: listBlocked[i],
                        ),
                    ]));
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

class BlockUserWidget extends StatefulWidget {
  const BlockUserWidget({super.key, required this.blockedUser});
  final blockedUser;
  @override
  State<StatefulWidget> createState() => _BlockUserWidgetState();
}

class _BlockUserWidgetState extends State<BlockUserWidget> {
  String blockStateText = "Bỏ chặn";
  bool isBlock = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 222, 222, 222),
            borderRadius: BorderRadius.all(Radius.circular(60))),
        child: Row(children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 10, 0),
            child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.blockedUser.avatar),
                )),
          ),
          Text(widget.blockedUser.name),
          const Expanded(
              child: SizedBox(
            height: 60,
          )),
          TextButton(
              onPressed: () {
                if (isBlock) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Bỏ chặn ${widget.blockedUser.name} ?',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            setUnBlock(int.parse(widget.blockedUser.userID));
                            Navigator.pop(context, 'OK');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Đã bỏ chặn ${widget.blockedUser.name}'),
                            ));
                            setState(() {
                              blockStateText = "Đã bỏ chặn";
                              isBlock = false;
                            });
                          },
                          child: const Text('Đồng ý'),
                        ),
                      ],
                      surfaceTintColor:
                          const Color.fromARGB(255, 162, 162, 162),
                    ),
                  );
                }
              },
              child: Text(
                blockStateText,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
              )),
        ]),
      ),
    );
  }
}
