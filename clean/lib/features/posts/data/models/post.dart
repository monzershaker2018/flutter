import 'package:clean/features/posts/domain/entites/post.dart';

// create a class and extends form entity Post
class PostModel extends Post {
  // create a const form class postModel
  const PostModel(
      {required int id, required String title, required String body})
      : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, "body": body};
  }
}
