import 'package:esync_app/features/products/data/datasources/products_remote_data_source.dart';
import 'package:esync_app/features/products/data/repositories/products_repository_impl.dart';
import 'package:esync_app/features/products/domain/repositories/products_repository.dart';
import 'package:esync_app/features/products/domain/usecases/get_more_products.dart';
import 'package:esync_app/features/products/domain/usecases/get_products.dart';
import 'package:esync_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> productsDependencies(GetIt sl) async {
  sl.registerFactory(() => GetProducts(repository: sl()));
  sl.registerFactory(() => GetMoreProducts(repository: sl()));

  sl.registerFactory<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerFactory<ProductsRepository>(
    () => ProductsRepositoryImpl(
      productsRemoteDataSource: sl(),
    ),
  );

  sl.registerFactory(
    () => ProductsBloc(
      getProductsUsecase: sl(),
      moreProductsUsecase: sl(),
    ),
  );
}
