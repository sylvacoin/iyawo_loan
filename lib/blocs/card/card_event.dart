part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
  @override
  List<Object> get props => [];
}

class EventSingleCardLoadSuccess extends CardEvent {
  final Customer customer;

  const EventSingleCardLoadSuccess({@required this.customer});
  @override
  List<Object> get props => [customer];

  @override
  String toString() {
    return "EventSingleCardLoadSuccess { customer: ${customer.fullName}}";
  }
}
class EventCardsLoadSuccess extends CardEvent {
  final Customer customer;

  const EventCardsLoadSuccess({@required this.customer});
  @override
  List<Object> get props => [customer];

  @override
  String toString() {
    return "EventCardsLoadSuccess { customer: ${customer.fullName}}";
  }

}
class EventCardAdded extends CardEvent{
  final CardModel card;

  const EventCardAdded({ @required this.card });

  @override
  List<Object> get props => [card];

  @override
  String toString() {
    return "EventCardAdded { card: ${jsonEncode(card)}}";
  }
}
class EventCardUpdated extends CardEvent{
  final CardModel card;

  const EventCardUpdated({ @required this.card });

  @override
  List<Object> get props => [card];

  @override
  String toString() {
    return "EventCardUpdated { card: $card}";
  }
}
class EventCardDeleted extends CardEvent{
  final CardModel card;

  const EventCardDeleted({ @required this.card });

  @override
  List<Object> get props => [card];

  @override
  String toString() {
    return "EventCardDeleted { card: $card}";
  }
}
