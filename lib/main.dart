import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/UI/views/create_item_view.dart';
import 'package:kasirku_mobile/UI/views/create_transaction_view.dart';
import 'package:kasirku_mobile/UI/views/detail_item_view.dart';
import 'package:kasirku_mobile/UI/views/detail_transaction_view.dart';
import 'package:kasirku_mobile/UI/views/edit_item_view.dart';
import 'package:kasirku_mobile/UI/views/list_item_view.dart';
import 'package:kasirku_mobile/UI/views/list_transaction_view.dart';
import 'package:kasirku_mobile/UI/views/login_view.dart';
import 'package:kasirku_mobile/bloc/auth/auth_bloc.dart';
import 'package:kasirku_mobile/bloc/transaction/transaction_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc()..add(AuthGetCurrentUser())),
          BlocProvider(create: (context) => TransactionBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: LoginView.routeName,
          routes: {
            '/': (context) => LoginView(),
            ListItemView.routeName: (context) => ListItemView(),
            DetailItemView.routeName: (context) => DetailItemView(
                  id: ModalRoute.of(context)!.settings.arguments as int,
                ),
            CreateItemView.routeName: (context) => CreateItemView(),
            CreateTransactionView.routeName: (context) =>
                CreateTransactionView(),
            ListTransactionView.routeName: (context) => ListTransactionView(),
            DetailTransactionView.routeName: (context) => DetailTransactionView(
                  id: ModalRoute.of(context)!.settings.arguments as int,
                ),
          },
        ));
  }
}
