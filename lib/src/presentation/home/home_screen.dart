import 'package:flutter/material.dart';
import 'package:office_buddy/src/data/model/post/feed_model.dart';
import 'package:office_buddy/src/data/repositories/feed_repositories.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:office_buddy/src/presentation/core/widget/custom_cache_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FeedModel>> _feedFuture;

  @override
  void initState() {
    super.initState();
    _feedFuture = FeedRepositories().getFeed(); // API call
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder<List<FeedModel>>(
        future: _feedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          final feeds = snapshot.data!;
          
          return ListView.builder(
            itemCount: feeds.length,
            itemBuilder: (context, index) {
              final feed = feeds[index];
              debugPrint('this is the ${feed.media}');
              return ListTile(
                title: Html(data: feed.description?.html ?? 'No Title'),
                subtitle: CustomCacheImage(imageUrl: feed.media??'http://192.168.1.42:8001/media/imagedata/user/Screenshot_2025-05-26_at_4.54.04PM.png',height: 200),
              );
            },
          );
        },
      ),
    );
  }
}
