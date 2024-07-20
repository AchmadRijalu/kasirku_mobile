import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/UI/widgets/list_item_selectable_widget.dart';
import 'package:kasirku_mobile/bloc/item/item_bloc.dart';
import 'package:kasirku_mobile/bloc/transaction/transaction_bloc.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class CreateTransactionView extends StatefulWidget {
  static const routeName = '/create-transaction';
  const CreateTransactionView({super.key});

  @override
  State<CreateTransactionView> createState() => _CreateTransactionViewState();
}

class _CreateTransactionViewState extends State<CreateTransactionView> {
  final TransactionBloc transactionBloc = TransactionBloc();
  final ItemBloc itemBloc = ItemBloc();

  TextEditingController invoiceController = TextEditingController(text: '');
  List<ItemDataModel> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        appBar: AppBar(
          actions: <Widget>[
            BlocListener<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is CreateTransactionSuccess) {
                  Navigator.pop(context);
                }
              },
              child: TextButton.icon(
                  onPressed: () async {
                    context.read<TransactionBloc>().add(
                        TransactionCreateTransaction(
                            invoiceController.text, selectedItems));
                  },
                  label: Text("Buat",
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.w700, color: blackColor)),
                  icon: Icon(Icons.add, color: blackColor)),
            ),
          ],
          backgroundColor: secondaryColor,
          title: const Text('Create Transaction'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                child: Form(
                    child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        controller: invoiceController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.task),
                            label: Text(
                              "Nomer Invoice",
                              style: primaryTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade500),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                )),
              ),
              Expanded(
                child: BlocProvider(
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
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: state.items.data!.length,
                          itemBuilder: (context, index) {
                            final item = state.items.data?[index];
                            final isSelected = selectedItems.contains(item);
                            return ListItemSelectableWidget(
                              item: item,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedItems.remove(item);
                                  } else {
                                    selectedItems.add(item!);
                                  }
                                });
                              },
                            );
                          },
                        );
                      }
                      return Container(
                        child: Text(""),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
