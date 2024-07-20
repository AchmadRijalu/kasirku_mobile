import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/UI/views/create_item_view.dart';
import 'package:kasirku_mobile/UI/views/create_transaction_view.dart';
import 'package:kasirku_mobile/UI/views/detail_item_view.dart';
import 'package:kasirku_mobile/UI/views/list_transaction_view.dart';
import 'package:kasirku_mobile/UI/views/login_view.dart';
import 'package:kasirku_mobile/UI/widgets/list_item_widget.dart';
import 'package:kasirku_mobile/bloc/auth/auth_bloc.dart';
import 'package:kasirku_mobile/bloc/item/item_bloc.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class ListItemView extends StatefulWidget {
  static const routeName = "/list-item-view";
  const ListItemView({super.key});

  @override
  State<ListItemView> createState() => _ListItemViewState();
}

class _ListItemViewState extends State<ListItemView> {
  String role = "";
  final ItemBloc itemBloc = ItemBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      role = authState.userDataModel.user.role;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        actions: <Widget>[
          role == "cashier"
              ? IconButton(
                  icon: Icon(
                    Icons.dock_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // do something
                    Navigator.pushNamed(context, ListTransactionView.routeName);
                  },
                )
              : SizedBox(),
          BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginView.routeName, (route) => false);
              },
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  // do something
                  context.read<AuthBloc>().add(AuthLogout());
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: secondaryColor,
        onPressed: () async {
          if (role == "admin") {
            await Navigator.pushNamed(context, CreateItemView.routeName);
            itemBloc.add(ItemGetItems());
          } else {
            Navigator.pushNamed(context, CreateTransactionView.routeName);
          }
        },
        label: Text('Tambah ${role == "admin" ? "Item" : "Transaksi"}'),
        icon: Icon(Icons.add),
      ),
      backgroundColor: lightBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                Text(
                  "Items",
                  style:
                      blackTextStyle.copyWith(fontSize: 40, fontWeight: bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (context) => itemBloc..add(ItemGetItems()),
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ItemFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is ItemSuccess) {
                  return Expanded(
                      child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.items.data!.length,
                    itemBuilder: (context, index) {
                      return ListItemWidget(
                        item: state.items.data?[index],
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            DetailItemView.routeName,
                            arguments: state.items.data?[index].id,
                          );
                          itemBloc.add(ItemGetItems());
                        },
                      );
                    },
                  ));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
