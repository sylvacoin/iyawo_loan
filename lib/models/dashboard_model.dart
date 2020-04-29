import 'package:equatable/equatable.dart';

class Dashboard extends Equatable {
  final num todaysTotal;
  final num weeklyTotal;
  final num monthlyTotal;
  final num yearlyTotal;
  final num totalProfit;
  final num totalWithdrawalBalance;
  final num pendingWithdrawalCount;
  final num totalBalance;
  final num dailyProfit;
  final num dailyTotal;
  final num monthlyProfit;

  Dashboard(
      {this.todaysTotal,
      this.weeklyTotal,
      this.monthlyTotal,
      this.yearlyTotal,
      this.totalProfit,
      this.totalWithdrawalBalance,
      this.pendingWithdrawalCount,
      this.totalBalance,
      this.dailyProfit,
      this.dailyTotal,
      this.monthlyProfit});

  @override
  List<Object> get props => [
        todaysTotal,
        weeklyTotal,
        monthlyTotal,
        yearlyTotal,
        totalProfit,
        totalWithdrawalBalance,
        pendingWithdrawalCount,
        totalBalance,
        dailyProfit,
        dailyTotal,
        monthlyProfit
      ];

  @override
  String toString() {
    return "Dashboard {todaysTotal: $todaysTotal,weeklyTotal: $weeklyTotal,monthlyTotal: $monthlyTotal,yearlyTotal: $yearlyTotal,totalProfit: $totalProfit,totalWithdrawalBalance: $totalWithdrawalBalance,pendingWithdrawalCount: $pendingWithdrawalCount,totalBalance: $totalBalance,dailyProfit: $dailyProfit,dailyTotal: $dailyTotal,monthlyProfit: $monthlyProfit}";
  }

  factory Dashboard.fromJson(json) {
    return Dashboard(
        dailyProfit: json['dailyProfit'] as num,
        monthlyProfit: json['monthlyProfit'] as num,
        pendingWithdrawalCount: json['PendingWithdrawalCount'] as num,
        todaysTotal: json['todaysTotal'] as num,
        totalBalance: json['totalBalance'] as num,
        totalProfit: json['totalProfit'] as num,
        dailyTotal: json['dailyTotal'] as num,
        monthlyTotal: json['monthlyTotal'] as num,
        totalWithdrawalBalance: json['totalWithdrawalBalance'] as num,
        weeklyTotal: json['weeklyTotal'] as num,
        yearlyTotal: json['yearlyTotal'] as num);
  }

  toJson() {
    return {
      "todaysTotal": todaysTotal ?? 0,
      "weeklyTotal": weeklyTotal ?? 0,
      "monthlyTotal": monthlyTotal ?? 0,
      "yearlyTotal": yearlyTotal ?? 0,
      "totalProfit": totalProfit ?? 0,
      "totalWithdrawalBalance": totalWithdrawalBalance ?? 0,
      "PendingWithdrawalCount": pendingWithdrawalCount ?? 0,
      "totalBalance": totalBalance ?? 0,
      "dailyProfit": dailyProfit ?? 0,
      "dailyTotal": dailyTotal ?? 0,
      "monthlyProfit": monthlyProfit ?? 0
    };
  }
}
