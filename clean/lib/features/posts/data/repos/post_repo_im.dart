import 'package:clean/features/posts/domain/entites/post.dart';
import 'package:clean/core/errors/failures.dart';
import 'package:clean/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

class PostRepoImp implements PostsRepo {
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) {
    throw UnimplementedError();
  }
}
