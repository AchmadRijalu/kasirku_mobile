part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionFailure extends TransactionState {
  final String message;

  const TransactionFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class TransactionLoading extends TransactionState {}

final class CreateTransactionSuccess extends TransactionState {
  const CreateTransactionSuccess();

  @override
  List<Object> get props => [];
}

final class TransactionSuccess extends TransactionState {
  final TransactionModel transactions;

  const TransactionSuccess(this.transactions);

  @override
  List<Object> get props => [transactions];
}

final class TransactionDetailSuccess extends TransactionState {
  final DetailTransactionModel detailTransactionModel;

  const TransactionDetailSuccess(this.detailTransactionModel);

  @override
  List<Object> get props => [detailTransactionModel];
}

