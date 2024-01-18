import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldwidenews/config/themes/app_themes.dart';
import 'package:worldwidenews/injection_container.dart';
import 'package:worldwidenews/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:worldwidenews/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:worldwidenews/presentation/pages/home/daily_news.dart';

import 'config/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => s1()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
