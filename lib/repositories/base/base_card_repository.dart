import 'package:iyawo/models/card_model.dart';

abstract class BaseCardRepository
{
  Future<List<CardModel>> getCustomerCards( int customerId );
  Future addCard(CardModel card);
  Future updateCard(CardModel card);
  
}