import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_manager.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/widgets/image_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {
    "status": "ok",
    "totalResults": 10167,
    "articles": [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        backgroundColor: Color(0xff1877F2),
        title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: FutureBuilder<NewsModel>(
        future: Api.getData(),
        builder: (context, snapshot) {
          List <Articles> articles = snapshot.data?.articles ?? [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Text(
                  "is error",
                  textAlign:TextAlign.center ,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) {
              return ImageItemWidget(
                image: articles[index].urlToImage ?? dummyImage,
                title: articles[index].title ?? "",
                onTap: () {},
              );
            },
            itemCount: articles.length,
          );
        },
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';