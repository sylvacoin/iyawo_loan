import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/account/account_bloc.dart';
import 'package:iyawo/blocs/customer/customers_bloc.dart';
import 'package:iyawo/blocs/dashboard/dashboard_bloc.dart';
import 'package:iyawo/utilities/helpers.dart';
import 'package:iyawo/widgets/custom_cards.dart';


class DashboardScreen extends StatelessWidget {
  String username;
  int customerCount;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AccountBloc>(context).listen((state) {
      if (state is StateAccountLoaded) {
        username = state.user.name;
      }
    });
    BlocProvider.of<CustomersBloc>(context).listen((state) {
      if (state is StateCustomersLoaded) {
        customerCount = state.customers.length;
      }else{
        customerCount = 0;
      }
    });
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DashboardLoaded) {
          final data = state.dashboardData;

          return Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Color(0x261f54c3),
                                  offset: Offset(0, 6),
                                  blurRadius: 20,
                                  spreadRadius: 4,
                                ),
                              ]),
                              child: Card(
                                color: Colors.deepPurple,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.deepPurple,
                                            size: 80.0,
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        )),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text('Welcome',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 30.0)),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text(
                                                    username ?? '',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20.0),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      GCards(
                        title: 'Daily Profit',
                        body: Helper.formatCurrency(
                            data.dailyProfit != null ? data.dailyProfit : 0),
                      ),
                      GCards(
                        title: 'Overall Monthly Profit',
                        body: Helper.formatCurrency(data.monthlyProfit != null
                            ? data.monthlyProfit
                            : 0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      GCards(
                        title: 'Total Daily',
                        body: Helper.formatCurrency(
                            data.todaysTotal != null ? data.todaysTotal : 0),
                      ),
                      GCards(
                        title: 'Clients',
                        body: customerCount.toString(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      GCards(
                        title: 'Overall Balance',
                        body: Helper.formatCurrency(
                            data.totalBalance != null ? data.totalBalance : 0),
                        cardBgColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      GCards(
                        title: 'Overall Profit',
                        body: Helper.formatCurrency(
                            data.totalProfit != null ? data.totalProfit : 0),
                        cardBgColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(color: Colors.blueGrey);
        }
      },
    );
  }
}
