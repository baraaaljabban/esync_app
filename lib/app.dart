import 'package:esync_app/core/dependency_registrar/dependencies.dart';
import 'package:esync_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:esync_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:esync_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/products/presentation/pages/products_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        title: "TEST",
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }

  List<BlocProviderSingleChildWidget> get providers {
    return [
      BlocProvider<HomeBloc>(
        create: (BuildContext context) => sl.get<HomeBloc>(),
        child: const HomePage(),
      ),
      BlocProvider<ProductsBloc>(
        create: (BuildContext context) => sl.get<ProductsBloc>(),
        child: const ProductsPage(),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => sl.get<AuthenticationBloc>(),
        child: const AuthenticationPage(),
      ),
    ];
  }
}
