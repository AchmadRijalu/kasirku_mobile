import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasirku_mobile/UI/views/detail_transaction_view.dart';
import 'package:kasirku_mobile/UI/widgets/list_transaction_widget.dart';
import 'package:kasirku_mobile/bloc/transaction/transaction_bloc.dart';
import 'package:kasirku_mobile/theme/theme.dart';

class ListTransactionView extends StatefulWidget {
  static const routeName = '/list-transaction';
  const ListTransactionView({super.key});

  @override
  State<ListTransactionView> createState() => _ListTransactionViewState();
}

class _ListTransactionViewState extends State<ListTransactionView> {
  final TransactionBloc transactionBloc = TransactionBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
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
                  "Transactions",
                  style:
                      blackTextStyle.copyWith(fontSize: 32, fontWeight: bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (context) =>
                transactionBloc..add(TransactionGetTransactions()),
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TransactionFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is TransactionSuccess) {
                  return Expanded(
                      child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.transactions.data!.length,
                    itemBuilder: (context, index) {
                      return ListTransactionWidget(
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            DetailTransactionView.routeName,
                            arguments: state.transactions.data?[index].id,
                          );
                        },
                        transactionDataModel: state.transactions.data?[index],
                      );
                    },
                  ));
                }
                return Container(
                  child: Text(""),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
