class Debt {
  final String name, debt;
  final String amount;
  final String timestamp;

  Debt({this.timestamp, this.name, this.debt, this.amount});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'debt': debt,
      'amount': amount,
      'timestamp': timestamp,
    };
  }
}
