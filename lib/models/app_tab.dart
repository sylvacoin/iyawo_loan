import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iyawo/screens/account_screen.dart';
import 'package:iyawo/screens/customers_screen.dart';
import 'package:iyawo/screens/dashboard_screen.dart';
import 'package:iyawo/screens/transactions_screen.dart';


enum AppTab {
  dashboard,
  customers,
  accounts,
  transactions,
}

class TabMenu {
  IconData icon;
  String title;
  Widget tab;

  TabMenu({this.icon, this.title, this.tab});
}

final List<TabMenu> tabMenus = [
  TabMenu(icon: Icons.home, title: 'Dashboard', tab: DashboardScreen()),
  TabMenu(icon: Icons.people, title: 'Customers', tab: CustomerScreen()),
  TabMenu(icon: Icons.account_box, title: 'Accounts', tab: AccountScreen()),
  TabMenu(icon: Icons.track_changes, title: 'Transactions', tab: TransactionsScreen()),
];
