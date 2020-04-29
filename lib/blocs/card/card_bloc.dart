import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iyawo/models/card_model.dart';
import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/repositories/card_repository.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({@required this.cardRepository});
  
  @override
  CardState get initialState => StateCardLoading();

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {
    if (event is EventCardsLoadSuccess) {
      yield* _mapEventCardLoadSuccessToState(event);
    } else if (event is EventCardAdded) {
      yield* _mapEventCardAddedToState(event);
    } else if (event is EventCardUpdated) {
      yield* _mapEventCardUpdatedToState(event);
    } else if (event is EventCardDeleted) {
      yield* _mapEventCardDeletedToState(event);
    }
  }

  Stream<CardState> _mapEventCardLoadSuccessToState(event) async* {
    List<CardModel> cards =
         await cardRepository.getCustomerCards(event.customer.customerId);
    yield StateCardsLoaded(cards, event.customer);
    print(state);
  }

  Stream<CardState> _mapEventCardAddedToState(EventCardAdded event) async* {
    if (state is StateCardsLoaded) {
      final List<CardModel> cardList =
          List.from((state as StateCardsLoaded).cards)..add(event.card);
          cardRepository.addCard(event.card);
      yield StateCardsLoaded(cardList);
      
    }
  }

  Stream<CardState> _mapEventCardUpdatedToState(EventCardUpdated event) async* {
    if (state is StateCardsLoaded) {
      final List<CardModel> cardList =
          (state as StateCardsLoaded).cards.map((f) {
        return f.cardId == event.card.cardId ? event.card : f;
      }).toList();
      yield StateCardsLoaded(cardList);
      //TODO: Validate this
      cardRepository.updateCard(event.card);
    }
  }

  Stream<CardState> _mapEventCardDeletedToState(EventCardDeleted event) async* {
    if (state is StateCardsLoaded) {
      final cardList = (state as StateCardsLoaded)
          .cards
          .where((card) => card.cardId != event.card.cardId)
          .toList();
      yield StateCardsLoaded(cardList);
      //cardRepository.delete
    }
  }

}
