import 'package:iyawo/models/customer_model.dart';

abstract class BaseCustomerRepository
{
  Future<List<Customer>> getHandlerCustomers(int handlerId);
  Future<List<Customer>> refreshHandlerCustomers(int handlerId);
  Future<Customer> addCustomer(Customer customer);
}