import 'package:clean/features/posts/domain/entites/post.dart';
import 'package:clean/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class AddPostCase {
  final PostsRepo repo;

  AddPostCase(this.repo);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repo.addPost(post);
  }
}
