class Debtor {
  final String name;
  final String phone;

  Debtor({this.name, this.phone});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }
}
