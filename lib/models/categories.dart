class  Categories{
  final  String id;
  final String nomcat;


  Categories({
      required this.id,
      required this.nomcat
});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
        id: json['_id'] as String,
        nomcat: json['nomcat'] as String
    );
  }
    @override
  String toString() {
    return 'Trans{id: $id, nomcat: $nomcat}';
  }
}