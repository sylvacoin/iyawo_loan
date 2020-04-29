import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/customer/customers_bloc.dart';
import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/utilities/helpers.dart';

class CustomersPage extends StatefulWidget {
  final List<Customer> customers;
  CustomersPage({@required this.customers});

  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  TextEditingController searchCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Customer> customers = widget.customers;
    List<Customer> filteredCustomers = customers;
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
        child: Column(
          children: <Widget>[
            Text('My Customers',
                style: TextStyle(fontSize: 25), textAlign: TextAlign.left),
            SizedBox(
              height: 30,
            ),
            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: searchCtrl,
                      decoration: new InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: (value) {
                        BlocProvider.of<CustomersBloc>(context).add(
                            EventSearchCustomers(
                                searchTerm: searchCtrl.text,
                                searchHay: customers));
                      },
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        searchCtrl.clear();
                        BlocProvider.of<CustomersBloc>(context).add(
                            EventSearchCustomers(
                                searchTerm: searchCtrl.text,
                                searchHay: customers));
                      },
                    ),
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<CustomersBloc>(context).add(
                            EventReadCustomers());
              },
              child: Expanded(
                child: ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (BuildContext context, item) {
                      if (filteredCustomers != null &&
                          filteredCustomers.length > 0) {
                        return Card(
                            color: Colors.white,
                            elevation: 0.4,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(Helper.getColor(
                                    filteredCustomers[item].fullName[0] +
                                        filteredCustomers[item].fullName[1])),
                                child: Text(
                                  "${filteredCustomers[item].fullName[0].toUpperCase()}${filteredCustomers[item].fullName.split(' ').length > 1 ? filteredCustomers[item].fullName.split(' ')[1][0].toUpperCase() ?? '' : filteredCustomers[item].fullName[1].toUpperCase() ?? ''}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(filteredCustomers[item].fullName),
                              subtitle:
                                  Text(filteredCustomers[item].customerNo),
                              onTap: () {
                                //BlocProvider.of<CardBloc>(context).add(EventReadCards(customer: filteredCustomers[item]));
                                Navigator.pushNamed(context, '/profile',
                                    arguments: filteredCustomers[item]);
                              },
                            ));
                      } else {
                        return Card(
                            color: Colors.white,
                            elevation: 0.4,
                            child: ListTile(
                                subtitle: Text(
                                    "No customer with name '${searchCtrl.text}' exist")));
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
