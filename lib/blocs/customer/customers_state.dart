part of 'customers_bloc.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();
  @override
  List<Object> get props => [];
}

class StateCustomersLoading extends CustomersState {}
class StateCustomersLoaded extends CustomersState {
  final List<Customer> customers;
  StateCustomersLoaded({@required this.customers});

  @override
  List<Object> get props => [customers];

  @override
  String toString() {
    return "CustomerLoaded { customers: ${customers.length}}";
  }
}
class StateCustomersUpdated extends CustomersState {
  final List<Customer> customers;
  StateCustomersUpdated({@required this.customers});

  @override
  List<Object> get props => [customers];

  @override
  String toString() {
    return "StateCustomersUpdated { customers: ${customers.length}}";
  }
}
class StateCustomerLoaded extends CustomersState {
  final Customer customer;
  StateCustomerLoaded({ @required this.customer});

  @override
  String toString() => "CustomerLoaded { customer: $customer }";
}

class StateAddCustomer extends CustomersState {}
class StateCustomersFailed extends CustomersState {
  final String err;
  StateCustomersFailed({ @required this.err});

  @override
  List<Object> get props => [err];

  @override
  String toString() {

    return "StateCustomersFailed { err : $err}";
  }
}
