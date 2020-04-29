import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/account/account_bloc.dart';
import 'package:iyawo/blocs/auth/index.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      if (state is StateAccountLoaded) {
        var account = state.user;
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                //padding: EdgeInsets.only(left: 12, right: 12),
                color: Colors.grey[200],
                child: Card(
                  elevation: 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text( account.name??'' ),
                          alignment: Alignment.topLeft,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.grey[200],
                //padding: EdgeInsets.only(left: 12, right: 12),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.all(1),
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text( account.email??''),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.all(1.0),
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('09074483515'),
                      ),
                    ),
                    Card(
                      elevation: 0.5,
                      margin: EdgeInsets.all(1.0),
                      child: ListTile(
                        leading: Icon(Icons.recent_actors),
                        title: Text('Administrator'),
                      ),
                    ),
                    Builder(
                        builder: (context) => FlatButton(
                              child: Text('Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(LoggedOut());
                              },
                            ))
                  ],
                ),
              ),
            )
          ],
        );
      }
      return Container();
    });
  }
}
