part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class StateCardLoading extends CardState {}

class StateCardsLoaded extends CardState {
  final List<CardModel> cards;
  final Customer customer;

  const StateCardsLoaded([this.cards = const [], this.customer]);

  @override
  List<Object> get props => [cards, customer];

  @override
  String toString() {
    return "StateCardsLoaded { cards : ${json.encode(cards)} }";
  }
}
class StateCardLoaded extends CardState {
  final CardModel card;

  const StateCardLoaded({@required this.card});

  @override
  List<Object> get props => [card];

  @override
  String toString() {
    return "StateCardLoaded { card : $card }";
  }
}
class StateCardFailed extends CardState {}

class StateCardUpdated extends CardState {}
class StateCardForm extends CardState {
  final CardModel card;
  const StateCardForm.update({@required this.card});

  @override
  List<Object> get props => [card];

  @override
  String toString() {
    return "StateCardForm { card : ${jsonEncode(card)} }";
  }
}
