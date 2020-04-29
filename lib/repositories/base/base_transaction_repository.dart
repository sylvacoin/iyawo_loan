import 'package:iyawo/models/transaction_model.dart';

abstract class BaseTransactionRepository
{
  Future doDeposit(Transaction depositData);
  Future doWithdrawal(Transaction withdrawalData);
  Future<List<Transaction>> getPendingTransactions();
  Future syncTransactions();
}