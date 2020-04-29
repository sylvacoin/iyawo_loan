import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/card/card_bloc.dart';
import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:iyawo/repositories/card_repository.dart';
import 'package:iyawo/utilities/helpers.dart';

class CardScreen extends StatelessWidget {
  final Customer customer;

  CardScreen({this.customer});

  final cardRepo = CardRepository(authRepo: AuthRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Details'),
        ),
        body: BlocProvider<CardBloc>(
          create: (context) => CardBloc(cardRepository: cardRepo)
            ..add(EventCardsLoadSuccess(customer: customer)),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  padding: EdgeInsets.all(18.0),
                                  margin: EdgeInsets.only(bottom: 15),
                                  color: Colors.blue[100],
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(customer.fullName ?? '',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                      SizedBox(height: 5.0),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(customer.customerNo ?? '',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      SizedBox(height: 15.0),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Withdrawal Balance: " +
                                                Helper.formatCurrency(
                                                    customer.wBalance ?? 0),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          )),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Balance: " +
                                                Helper.formatCurrency(
                                                    customer.balance ?? 0),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 2.5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: RaisedButton(
                                      color: Colors.blue[300],
                                      padding: EdgeInsets.all(18),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/create-card',
                                            arguments: customer);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                              child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 14,
                                          )),
                                          Text(
                                            'New Card',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 2.5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: RaisedButton(
                                      color: Colors.blue[400],
                                      padding: EdgeInsets.all(18),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/withdraw',
                                            arguments:
                                                customer.customerId.toString());
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                              child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 14,
                                          )),
                                          Text('Withdrawal',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 2.5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: RaisedButton(
                                      color: Colors.blue[500],
                                      padding: EdgeInsets.all(18),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/deposit',
                                            arguments:
                                                customer.customerId.toString());
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                              child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 14,
                                          )),
                                          Text(
                                            'Deposit',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(child: Card(elevation: 0, child: _CardList()))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        if (state is StateCardLoading) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is StateCardsLoaded) {
          var cards = state.cards;
          if (cards.length < 1) {
            return Center(child: Text("This customer does not have a card"));
          } else {
            return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(
                              width: 5.0,
                              color: Helper.getCardStatusColor(
                                  cards[index].status))),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius:
                              1.0, // has the effect of softening the shadow
                          spreadRadius:
                              0.2, // has the effect of extending the shadow
                          offset: Offset(
                            1.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          cards[index].cardNo[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(cards[index].cardNo),
                      subtitle:
                          Text(Helper.formatCurrency(cards[index].cardBalance)),
                      onTap: () {
                        print('Card details');
                      },
                    ));
              },
            );
          }
        }
        return Center(child: Text("An error occured"));
      },
    );
  }
}
