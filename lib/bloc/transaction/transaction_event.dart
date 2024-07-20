part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class TransactionGetTransactions extends TransactionEvent {}

final class TransactionCreateTransaction extends TransactionEvent {
  final String? invoiceNumber;
  final List<ItemDataModel> items;

  const TransactionCreateTransaction(this.invoiceNumber, this.items);

  @override
  List<Object> get props => [invoiceNumber!, items];
}

final class TransactionGetTransactionDetail extends TransactionEvent {
  final int id;

  const TransactionGetTransactionDetail(this.id);

  @override
  List<Object> get props => [id];
}


