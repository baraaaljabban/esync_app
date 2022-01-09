import 'package:dartz/dartz.dart';
import 'package:esync_app/core/base_use_cases.dart';
import 'package:esync_app/core/errors/failures.dart';
import 'package:esync_app/features/products/domain/entities/product_entity.dart';
import 'package:esync_app/features/products/domain/repositories/products_repository.dart';

class GetMoreProducts extends UseCase<List<ProductEntity>, LoadMoreParams> {
  GetMoreProducts({
    required this.repository,
  });

  ProductsRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call({required LoadMoreParams params}) async {
    return await repository.loadMoreProducts(pageNumber: params.pageNumber);
  }
}

class LoadMoreParams {
  const LoadMoreParams({
    required this.pageNumber,
  });
  final int pageNumber;
}
