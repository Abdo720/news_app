import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/data/models/news_model.dart';
import 'package:news_app/home/veiw_model/home_cubit.dart';
import 'package:news_app/widgets/image_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchNews(),
      child: Scaffold(
        backgroundColor: const Color(0xff202020),
        appBar: AppBar(
          backgroundColor: const Color(0xff1877F2),
          title: Text('News App', style: Theme.of(context).textTheme.bodyLarge),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              return Center(
                child: Container(
                  width: 150,
                  height: 100,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text(
                    state.messageError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              );
            }
            if (state is HomeSuccess) {
              List<Articles> articles = state.articles;

              if (articles.isEmpty) {
                return const Center(child: Text("No Articles Found", style: TextStyle(color: Colors.white)));
              }

              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ImageItemWidget(
                    image: articles[index].urlToImage ?? dummyImage,
                    title: articles[index].title ?? "",
                    onTap: () {},
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';