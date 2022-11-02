import 'package:clean/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/post.dart';

class GetAllPostsCase {
  final PostsRepo repo;
  GetAllPostsCase(this.repo);
  Future<Either<Failure, List<Post>>> call() async {
    return await repo.getAllPosts();
  }
}
