import 'dart:convert';

import 'package:iyawo/models/card_model.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:iyawo/repositories/base/base_card_repository.dart';
import 'package:http/http.dart' as http;
import 'package:iyawo/utilities/http_routes.dart';
import 'package:meta/meta.dart';

class CardRepository implements BaseCardRepository
{
  final AuthRepository authRepo;
  
  const CardRepository({ @required this.authRepo});

  @override
  Future addCard(CardModel card) async {
    try {
      String token = await authRepo.getToken();
      final response = await http.post(createCard_link, body: card.toJson(), headers: {'Authorization': token});
      if (response.statusCode == 200)
      {
        return card;
      }
    }catch(err)
    {
      throw err;
    }
    return null;
  }

  @override
  Future<List<CardModel>> getCustomerCards(int customerId) async {
    List<CardModel> cards = [];
    try {
      String token = await authRepo.getToken();
      final response = await http.post(customerCardList_link, headers: {'Authorization':token});
      if (response.statusCode == 200 )
      {
        final responseJson = jsonDecode(response.body);
        cards = (responseJson['data'] as List).map((item) => CardModel.fromJson(item)).toList();
      }
    }catch(ex){
      throw ex;
    }
    return cards;
  }

  @override
  Future updateCard(CardModel card) {
    // TODO: implement updateCard
    return null;
  }

  

}