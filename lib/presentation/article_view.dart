import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testing/application/news_api_provider.dart';

class ArticleView extends ConsumerStatefulWidget {
  const ArticleView({super.key, required this.id});
  final String id;
  @override
  ConsumerState<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView> {
  Map<String, dynamic> response = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final api = ref.read(newsApiProvider);
      await api
          .getArticle('latest', widget.id)
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
