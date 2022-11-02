import 'package:clean/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/post.dart';

class UpdatePostCase {
  final PostsRepo repo;

  UpdatePostCase(this.repo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return repo.updatePost(post);
  }
}
