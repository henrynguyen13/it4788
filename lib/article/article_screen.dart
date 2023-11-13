import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:it4788/model;s/article.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});
  @override
  State<ArticleScreen> createState() {
    return _ArticleScreenState();
  }
}

class _ArticleScreenState extends State<ArticleScreen> {
  int kudosCount = 10;
  int disappointedCount = 12;
  late int totalFeels;

  int getTotalFeels() {
    totalFeels = kudosCount + disappointedCount;
    return totalFeels;
  }

  bool isClickKudos = false;
  bool isClickDisappointed = false;

  void handleClickKudos() {
    setState(() {
      isClickKudos = !isClickKudos;
      kudosCount = isClickKudos ? kudosCount + 1 : kudosCount - 1;
    });
  }

  void handleClickDisappointed() {
    setState(() {
      isClickDisappointed = !isClickDisappointed;
      disappointedCount =
          isClickDisappointed ? disappointedCount + 1 : disappointedCount - 1;
    });
  }

  String formatTimeDifference(DateTime from, DateTime to) {
    Duration difference = to.difference(from);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      int days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    }
  }

  final List<Article> _articleList = [
    Article(
        id: '1',
        image: [
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        ],
        described:
            '🏸 Sau tiếng trống dài của tiết học cuối cùng vang lên, các lớp học tại khuôn viên Trường THPT Đồng Quan cũng dần tắt đèn. Không khí nhà xe nhộn nhịp hơn bao giờ hết với tiếng cười đùa vui vẻ của các bạn học sinh đang đứng đợi lấy xe dưới bóng cây mát mẻ. Rồi cứ thế thưa dần đi theo thời gian, các bạn dần quay trở về ngôi nhà của mình. Cho đến khi nhà xe thưa bớt, những văn hóasinh hoạt buổi chiều tại Trường Q chính thức được bắt đầu.  Một, hai nhóm chơi bóng chuyền, bóng rổ hay thậm chí là đá cầu, cầu lông,.. Những môn thể thao này từ lâu đã rất được ưa chuộng tại đây. Từ bên ngoài, người ta cũng có thể nghe thấy bầu không khí sôi động từ những bộ môn này vọng ra từ trong sân trường Q đầy huyên náo. 🏐 Đặc biệt trong tháng 11 này, mỗi góc sân trường đều mở một bài hát khác nhau với giai điệu nhẹ nhàng, du dương , đó những bài hát được chuẩn bị cho ngày Nhà Giáo Việt Nam - 20/11 sắp tới. Nó đã góp phần làm tăng lên sự đông đúc, sôi nổi của trường Q sau giờ học. ',
        created: DateTime.now().subtract(const Duration(minutes: 30)),
        feel: 100,
        kudos: 50,
        disappointed: 50,
        author: Author(
            authorId: '1',
            username: 'CLB Sách và Hành Động Trường THPT Đồng Quan',
            avatar: 'https://picsum.photos/250?image=9'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _articleList.length,
        itemBuilder: (context, index) {
          return _buildArticleItem(_articleList[index]);
        },
      ),
    );
  }

  Widget _buildImageSection(List<String> images) {
    if (images.length == 1) {
      return Image.network(images[0],
          height: 400, width: double.infinity, fit: BoxFit.cover);
    } else if (images.length == 2) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Image.network(images[index],
                height: 400, width: double.infinity, fit: BoxFit.cover),
          );
        },
      );
    } else if (images.length == 3) {
      return Row(
        children: [
          Expanded(
            child: Image.network(images[0], height: 400, fit: BoxFit.cover),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Image.network(images[1],
                      height: 198, width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 2),
                  child: Image.network(images[1],
                      height: 198, width: double.infinity, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (images.length >= 4) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1),
            child: Image.network(images[index],
                height: 200, width: double.infinity, fit: BoxFit.cover),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget _buildArticleItem(Article article) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ClipOval(
                  child: CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    radius: 28,
                    child: Image.network(_articleList[0].author.avatar),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 280,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _articleList[0].author.username,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(formatTimeDifference(
                                _articleList[0].created, DateTime.now())
                            .toString()),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('.'),
                        ),
                        const Icon(Icons.public)
                      ],
                    )
                  ],
                ),
              ),
              // const Spacer(),
              const Padding(
                  padding: EdgeInsets.only(right: 8), child: BottomPopup())
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: ExpandableText(
                _articleList[0].described,
                style: const TextStyle(fontSize: 16),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 3,
              ),
            ),
          ),
          _buildImageSection(article.image),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 232, 43, 29),
              ),
              const Icon(
                Icons.mood_bad_rounded,
              ),
              Text(getTotalFeels().toString()),
              Spacer(),
              Text('42 comments')
            ]),
          ),
          const Divider(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleClickKudos();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite,
                                color: isClickKudos
                                    ? Color.fromARGB(255, 232, 43, 29)
                                    : Colors.black),
                            const Padding(padding: EdgeInsets.only(right: 4)),
                            const Text('kudos'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleClickDisappointed();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mood_bad_outlined,
                                color: isClickDisappointed
                                    ? Color.fromARGB(255, 232, 208, 29)
                                    : Colors.black),
                            const Padding(padding: EdgeInsets.only(right: 4)),
                            Text('disappointed'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.message_outlined),
                          Padding(padding: EdgeInsets.only(right: 4)),
                          Text('comment'),
                        ],
                      ),
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

class BottomPopup extends StatelessWidget {
  const BottomPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: TextButton(
          child: const Icon(Icons.more_horiz),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.notifications_off_rounded),
                              ),
                              Text('Tắt thông báo về bài viết này'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.save_alt_rounded),
                              ),
                              Text('Lưu bài viết'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.delete),
                              ),
                              Text('Xóa'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.edit),
                              ),
                              Text('Chỉnh sửa bài viết'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.link),
                              ),
                              Text('Sao chép liên kết'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
