import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';

class App extends StatefulWidget {
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
      providers: blocProviders,
      child: MaterialApp(
        title: "TEST",
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }

  List<BlocProviderSingleChildWidget> get blocProviders {
    return [
      // BlocProvider<RelatedArticleBloc>(
      //   create: (BuildContext context) => locator<RelatedArticleBloc>(),
      //   child: const RelatedArticlePage(),
      // ),
    ];
  }
}
