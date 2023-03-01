class  Transaction{
  String id;
  String day;
  String montant;
  String descriptions;
  String type;




  Transaction({
      required this.id,
      required this.day,
      required this.montant,
      required this.descriptions,
      required this.type
});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json['_id'],
        day: json['day'],
        montant: json['montant'],
        descriptions: json['descriptions'],
        type: json['type'],
    );
  }
   @override
  String toString() {
    return 'Trans{id: $id, day: $day,montant: $montant,descriptions: $descriptions,type: $type }';
  }
}