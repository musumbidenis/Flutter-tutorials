class Payment {
  final String name;
  final int total, paid;

  Payment({this.name, this.total, this.paid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'total': total,
      'paid': paid,
    };
  }
}
