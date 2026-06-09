class Medicine {
  final int id;
  final String name;
  final String ingredient;
  final String usage;

  Medicine({required this.id, required this.name, required this.ingredient, required this.usage});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      ingredient: json['ingredient'],
      usage: json['usage'],
    );
  }
}