import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/bloc/StatementsBloc.dart';
import 'package:flutter_assignment/generated/assets.dart';
import 'package:flutter_assignment/models/AccountsModel.dart';
import 'package:flutter_assignment/ui/screens/MainScreen.dart';
import 'package:flutter_assignment/ui/screens/TransactionsScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:json_theme/json_theme.dart';
import 'GraphQL/Connection.dart';
import 'bloc/AccountsBloc.dart';
import 'bloc/HomeBloc.dart';
import 'bloc/TransactionsBloc.dart';
import 'ui/screens/LoginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/screens/StatementsScreen.dart';

ThemeData? theme;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

  SchemaValidator.enabled = false;
  String jsonString = await rootBundle.loadString(Assets.assetsThemeAppTheme);
  Map<String, dynamic> themeJson = json.decode(jsonString);

  theme = ThemeDecoder.decodeThemeData(themeJson) ?? ThemeData();

  runApp(MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'main_screen',
          builder: (BuildContext context, GoRouterState state) {
            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return MainScreen();
              },
            );
          },
        ),
        GoRoute(
          path: 'transactions_screen',
          builder: (BuildContext context, GoRouterState state) {
            return BlocBuilder<TransactionsBloc, TransactionsState>(
              builder: (context, state1) {
                return TransactionsScreen(accountsModel: state.extra as AccountsModel,);
              },
            );
          },
        ),
        GoRoute(
          path: 'statements_screen',
          builder: (BuildContext context, GoRouterState state) {
            return BlocBuilder<StatementsBloc, StatementsState>(
              builder: (context, state) {
                return StatementsScreen();
              },
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeAPIs homeRepository = new HomeAPIs();
  AccountsAPIs accountRepository = new AccountsAPIs();
  TransactionsAPIs transactionsRepository = new TransactionsAPIs();
  StatementsAPIs statementsRepository = new StatementsAPIs();

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(homeRepository)
              ..add(
                HomeRequested(),
              ),
          ),
          BlocProvider<AccountsBloc>(
            create: (context) => AccountsBloc(accountRepository)
              ..add(
                AccountsRequested(),
              ),
          ),
          BlocProvider<TransactionsBloc>(
            create: (context) => TransactionsBloc(transactionsRepository)
              ..add(
                TransactionsRequested(),
              ),
          ),
          BlocProvider<StatementsBloc>(
            create: (context) => StatementsBloc(statementsRepository)
              ..add(
                StatementsRequested(),
              ),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Assignment',
          theme: theme,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
