import 'package:via_cep/model/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
}
