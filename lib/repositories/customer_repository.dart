import 'dart:convert';

import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/repositories/base/base_auth_repository.dart';
import 'package:iyawo/repositories/base/base_customer_repository.dart';
import 'package:http/http.dart' as http;
import 'package:iyawo/utilities/http_routes.dart';
import 'package:meta/meta.dart';

class CustomerRepository implements BaseCustomerRepository {
  
  final BaseAuthRepository authRepo;
  CustomerRepository({@required this.authRepo, http.Client httpClient});

  @override
  Future<Customer> addCustomer(Customer customer) async {
    try {
      String token = await authRepo.getToken();

      var response = await http.post(createCustomer_link,
          body: customer.toJson(), headers: {'Authorization': token});
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == 200) {
          return customer;
        }
      }
      return null;
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<List<Customer>> getHandlerCustomers(int handlerId) async {
    List<Customer> customers = [];
    try {
      String token = await authRepo.getToken();
      var response = await http.post(
          handlerCustomerList_link.replaceAll('@', handlerId.toString()),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == 200) {
          customers = (result['data'] as List)
              .map((item) => Customer.fromJson(item))
              .toList();
        }
      }
    } catch (err) {
      throw err;
    }

    return customers;
  }

  @override
  Future<List<Customer>> refreshHandlerCustomers(int handlerId) async {
    return await getHandlerCustomers(handlerId);
  }
}
