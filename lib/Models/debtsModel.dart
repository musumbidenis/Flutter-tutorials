class Debt {
  final String name, debt;
  final String amount;

  Debt({this.name, this.debt, this.amount});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'debt': debt,
      'amount': amount,
    };
  }
}
