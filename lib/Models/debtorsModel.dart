class Debtors {
  final String name;
  final int phone;

  Debtors(this.name, this.phone);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }
}
