import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testing/application/news_api_provider.dart';
import 'package:flutter_testing/presentation/article_view.dart';

class NewsView extends ConsumerStatefulWidget {
  const NewsView({super.key});

  @override
  ConsumerState<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends ConsumerState<NewsView> {
  Map<String, dynamic> response = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final api = ref.read(newsApiProvider);
      await api
          .getNews('latest')
          .then((val) {
            setState(() {
              response = val.data;
            });
            print(response);
          })
          .catchError((e) {
            print(e);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: response.isNotEmpty
            ? ListView.builder(
                itemCount: response['results'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = response['results'][index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArticleView(id: data['article_id']),
                        ),
                      );
                    },
                    title: Text(data['title']),
                    subtitle: Text(data['link']),
                  );
                },
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
