import 'package:clean/features/posts/domain/entites/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> deletePost(int id);
}
