

import 'package:esync_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> productsDependencies(GetIt sl) async {

  sl.registerFactory(
        () => ProductsBloc(
      // tillListUseCase: sl(),
      // closeTillUseCase: sl(),
    ),
  );
}