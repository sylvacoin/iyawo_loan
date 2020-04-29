import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/card/card_bloc.dart';
import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/models/card_model.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:iyawo/repositories/card_repository.dart';

// typedef CallbackOnSave = Function (CardModel card);
class CreateCardScreen extends StatelessWidget {
  final Customer customer;
  // final CallbackOnSave onSave;
  CreateCardScreen({@required this.customer});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _cardNoCtrl = new TextEditingController();
  TextEditingController _cardStartCtrl = new TextEditingController();
  TextEditingController _amountCtrl = new TextEditingController();
  final scaffoldStateKey = GlobalKey<ScaffoldState>();

  final cardRepo = CardRepository(authRepo: AuthRepository());

  bool _working = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldStateKey,
        appBar: AppBar(title: Text('Create Card')),
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.all(12),
            child: Card(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: BlocProvider(
                    create: (context) => CardBloc(cardRepository: cardRepo),
                    child: new Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Align(
                              child: Text('Create Card',
                                  style: TextStyle(fontSize: 25)),
                              alignment: Alignment.topRight,
                            ),
                            Expanded(
                              child: ListView(
                                children: <Widget>[
                                  SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: _cardNoCtrl,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.payment),
                                      hintText: 'Card No',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _amountCtrl,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.monetization_on),
                                      labelText: 'Start Amount',
                                      hintText: '100',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: _cardStartCtrl,
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.payment),
                                      labelText: 'Card Count Start',
                                      hintText: '1',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Builder(
                                    builder: (BuildContext context) =>
                                        RaisedButton(
                                      onPressed: () {
                                        var card = new CardModel(
                                          cardId: 0,
                                          cardNo: _cardNoCtrl.text.trim(),
                                          startAmount: int.parse(_amountCtrl.text),
                                          total: 0,
                                          cardBalance: 0,
                                          cardStart: int.parse(_cardStartCtrl.text),
                                          cardWBalance: 0,
                                          customerId: customer.customerId,
                                          status: 'active',
                                          updatedAt: new DateTime.now().toString()
                                        );
                                         BlocProvider.of<CardBloc>(context).add(EventCardAdded(card: card));
                                      },
                                      child: Text(
                                          !_working
                                              ? 'Create Card'
                                              : 'Please wait ...',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.blue,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  )),
            ),
          ),
        ));
  }
}
