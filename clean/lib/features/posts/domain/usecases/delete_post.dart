import 'package:clean/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class DeletePostCase {
  final PostsRepo repo;

  DeletePostCase(this.repo);
  Future<Either<Failure, Unit>> call(int postId) async {
    return await repo.deletePost(postId);
  }
}
