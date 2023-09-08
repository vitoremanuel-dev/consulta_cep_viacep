import 'package:flutter/material.dart';
import 'package:via_cep/model/comment_model.dart';
import 'package:via_cep/repositories/comments_http_repository.dart';

class CommentsPage extends StatefulWidget {
  final int postId;
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  var commentsRepository = CommentsHttpRepository();
  var comments = <CommentModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    comments = await commentsRepository.retornarComentarios(widget.postId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Comentários do Post: ${widget.postId}'),
        centerTitle: true,
      ),
      body: comments.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                var comment = comments[index];
                return Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      children: [
                        Text(
                          comment.name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(comment.email),
                        const SizedBox(height: 5),
                        Text(
                          comment.body,
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    ));
  }
}
