import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iyawo/blocs/auth/auth_bloc.dart';
import 'package:iyawo/models/account_model.dart';
import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/repositories/customer_repository.dart';
import 'package:meta/meta.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomerRepository customersRepository;
  final AuthBloc authBloc;
  StreamSubscription todosSubscription;

  CustomersBloc({  @required this.authBloc, @required this.customersRepository });

  @override
  CustomersState get initialState => StateCustomersLoading();

  @override
  Stream<CustomersState> mapEventToState(
    CustomersEvent event,
  ) async* {
    if (event is EventReadCustomers) {
      try {
        yield StateCustomersLoading();
        Account handler = await authBloc.authRepo.getCurrentUser();
        List<Customer> customers = await customersRepository.getHandlerCustomers(handler.ssid);
        if (customers.length > 0) {
          yield StateCustomersLoaded(customers: customers);
        } else {
          yield StateCustomersFailed(err: "No customers found");
        }
      } catch (ex) {
        yield StateCustomersFailed(err: ex.toString());
      }
    }

    if (event is EventReadCustomer) {
      yield StateCustomersLoading();
      yield StateCustomerLoaded(customer: event.customer);
    }

    if (event is EventAddCustomer) {
      yield StateCustomersLoading();
      Customer customer = await customersRepository.addCustomer(event.customer);
      yield StateCustomerLoaded(customer: customer);
    }

    if (event is EventSearchCustomers) {
      yield StateCustomersLoading();
      String term = event.searchTerm;
      List<Customer> hay = event.searchHay;

      if (term.length > 0) {
        List<Customer> filteredCustomers = hay.where((c) {
          return c.customerNo.toLowerCase().contains(term.toLowerCase()) ||
              c.fullName.toLowerCase().contains(term.toLowerCase());
        }).toList();

        if (filteredCustomers.length > 0) {
          yield StateCustomersUpdated(customers: filteredCustomers);
        } else {
          yield StateCustomersFailed(err: "No customers found");
        }
      } else {
        yield StateCustomersLoading();
        try {
          Account handler = await authBloc.authRepo.getCurrentUser();
          List<Customer> customers = await customersRepository.getHandlerCustomers(handler.ssid);

          if (customers.length > 0) {
            yield StateCustomersLoaded(customers: customers);
          } else {
            yield StateCustomersFailed(err: "No customers found");
          }
        } catch (ex) {
          yield StateCustomersFailed(err: ex.toString());
        }
      }
      return;
    }
  }
}
