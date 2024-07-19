import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasirku_mobile/models/detail_item_model.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:kasirku_mobile/repositories/item_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is ItemGetItems) {
        try {
          emit(ItemLoading());
          final items = await ItemRepository().getItems();
          emit(ItemSuccess(items));
        } catch (e) {
          emit(ItemFailure(e.toString()));
        }
      }

      if (event is ItemGetItemDetail) {
        try {
          emit(ItemLoading());
          final item = await ItemRepository().getItemDetail(event.id);
          print(item);
          emit(ItemDetailSuccess(item));
        } catch (e) {
          emit(ItemFailure(e.toString()));
        }
      }

      if (event is ItemCreateItem) {
        try {
          emit(ItemLoading());
          await ItemRepository().createItem(
            event.name,
            event.price,
            event.description,
          );
          emit(ItemCreateSuccess());
        } catch (e) {
          emit(ItemFailure(e.toString()));
        }
      }

      if (event is ItemDeleteItem) {
        try {
          emit(ItemLoading());
          await ItemRepository().deleteItem(event.id);
          emit(ItemDeleteSuccess());
        } catch (e) {
          emit(ItemFailure(e.toString()));
        }
      }

      if (event is ItemUpdateItem) {
        try {
          emit(ItemLoading());
          await ItemRepository().updateItem(
            event.id,
            event.name,
            event.price,
            event.description,
          );
          emit(ItemUpdateSuccess());
        } catch (e) {
          emit(ItemFailure(e.toString()));
        }
      }
    });
  }
}
