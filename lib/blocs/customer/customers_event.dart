part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();
  @override
  List<Object> get props => [];
}

class EventReadCustomers extends CustomersEvent {}

class EventReadCustomer extends CustomersEvent {
  final Customer customer;
  EventReadCustomer({@required this.customer});

  @override
  List<Object> get props => [customer];

  @override
  String toString() {
    return "EventReadCustomer {customerId: $customer}";
  }
}

class EventAddCustomer extends CustomersEvent {
  final Customer customer;
  EventAddCustomer({
    @required this.customer
  });
  @override
  List<Object> get props => [customer];

  @override
  String toString() {
    return "EventAddCustomer {customer: $customer}";
  }
}

class EventUpdateCustomer extends CustomersEvent {}

class EventSearchCustomers extends CustomersEvent {
  final String searchTerm;
  final List<Customer> searchHay;
  EventSearchCustomers({this.searchTerm, this.searchHay});

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() {
    return "EventSearchCustomers {searchTerm: $searchTerm}";
  }
}
