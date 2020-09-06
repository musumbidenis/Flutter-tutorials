class Payment {
  final String name, total, paid;

  Payment({this.name, this.total, this.paid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'total': total,
      'paid': paid,
    };
  }
}
