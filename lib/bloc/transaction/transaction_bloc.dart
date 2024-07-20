import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasirku_mobile/models/detail_transaction_model.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:kasirku_mobile/models/transaction_model.dart';
import 'package:kasirku_mobile/repositories/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is TransactionCreateTransaction) {
        try {
          emit(TransactionLoading());
          await TransactionRepository().createTransaction(
            event.invoiceNumber,
            event.items,
          );
          emit(CreateTransactionSuccess());
        } catch (e) {
          emit(TransactionFailure(e.toString()));
        }
      }

      if (event is TransactionGetTransactions) {
        try {
          emit(TransactionLoading());
          final transactions = await TransactionRepository().getTransactions();
          emit(TransactionSuccess(transactions));
        } catch (e) {
          emit(TransactionFailure(e.toString()));
        }
      }

      if (event is TransactionGetTransactionDetail) {
        try {
          emit(TransactionLoading());
          final detailTransaction =
              await TransactionRepository().getTransactionDetail(event.id);
          emit(TransactionDetailSuccess(detailTransaction));
        } catch (e) {
          emit(TransactionFailure(e.toString()));
        }
      }
    });
  }
}
