import 'package:flutter/material.dart';
import 'package:via_cep/model/post_model.dart';
import 'package:via_cep/pages/comments_page.dart';

import 'package:via_cep/repositories/posts/posts_dio_repository.dart';
import 'package:via_cep/repositories/posts/posts_repository.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  PostRepository postsRepository = PostDioRepository();
  var posts = <PostModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    posts = await postsRepository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
          centerTitle: true,
        ),
        body: posts.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (_, index) {
                  var post = posts[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Card(
                      elevation: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              post.body,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 5),
                            InkWell(
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: Colors.indigo,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Comentários",
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommentsPage(
                                    postId: post.id,
                                  ),
                                ));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
