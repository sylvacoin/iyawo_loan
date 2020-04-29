import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/customer/customers_bloc.dart';
import 'package:iyawo/screens/customers_page.dart';
import 'package:iyawo/screens/not_found.dart';


class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersBloc, CustomersState>(
        builder: (context, state) {
      if (state is StateCustomersLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is StateCustomersLoaded) {
        var customers = state.customers;
        //return Container( color: Colors.red );
        return CustomersPage(customers: customers,);
      } else if (state is StateCustomersUpdated) {
        var customers = state.customers;
        return Container( color: Colors.blue );
        //return CustomersPage(customers: customers,);
      } else if (state is StateCustomersFailed)
      {
        //return Container( color: Colors.orange );
        return NotFoundPage(error: state.err);
      }
      return Container();
    });
  }
}
