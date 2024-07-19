part of 'item_bloc.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemSuccess extends ItemState {
  final ItemModel items;

  const ItemSuccess(this.items);

  @override
  List<Object> get props => [items!];
}

final class ItemFailure extends ItemState {
  final String message;

  const ItemFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ItemDetailSuccess extends ItemState {
  final DetailItemModel item;

  const ItemDetailSuccess(this.item);

  @override
  List<Object> get props => [item];
}

final class ItemCreateSuccess extends ItemState {
  const ItemCreateSuccess();

  @override
  List<Object> get props => [];
}

final class ItemDeleteSuccess extends ItemState {
  const ItemDeleteSuccess();

  @override
  List<Object> get props => [];
}

final class ItemUpdateSuccess extends ItemState {
  const ItemUpdateSuccess();

  @override
  List<Object> get props => [];
}

