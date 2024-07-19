part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

final class ItemGetItems extends ItemEvent {}

final class ItemCreateItem extends ItemEvent {
  final String? name;
  final String? price;
  final String? description;

  const ItemCreateItem(this.name, this.price, this.description);

  @override
  List<Object> get props => [name!, price!, description!];
}

final class ItemUpdateItem extends ItemEvent {
  final int? id;
  final String? name;
  final int? price;
  final String? description;

  const ItemUpdateItem(this.id, this.name, this.price, this.description);

  @override
  List<Object> get props => [id!, name!, price!, description!];
}

final class ItemDeleteItem extends ItemEvent {
  final int id;

  const ItemDeleteItem(this.id);

  @override
  List<Object> get props => [id];
}

final class ItemGetItemDetail extends ItemEvent {
  final int id;

  const ItemGetItemDetail(this.id);

  @override
  List<Object> get props => [id];
}

final class ItemUpdateItemDetail extends ItemEvent {
  final String? name;
  final int? price;
  final String? description;

  const ItemUpdateItemDetail(this.name, this.price, this.description);

  @override
  List<Object> get props => [name!, price!, description!];
}
