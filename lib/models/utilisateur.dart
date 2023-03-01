class  Utilisateur{
 final String id;
 final String nom;
 final String prenom;
 final String adresse;
 final String telephone;
 final String email;
 final String username;
 final String password;
 final String role;


  Utilisateur({
      required this.id,
      required this.nom,
      required this.prenom,
      required this.adresse,
      required this.telephone,
      required this.email,
      required this.username,
      required this.password,
       required this.role
});

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
        id: json['_id'],
        nom: json['nom'],
        prenom: json['prenom'],
        adresse: json['adresse'],
        telephone: json['telephone'],
        email: json['email'],
        username: json['username'],
        password: json['password'],
        role: json['role']

    );
  }

  void set password(String password) {
    password =  password;
  }
  void set email(String email) {
    email = email;
  }
     @override
  String toString() {
    return 'Trans{id: $id, nom: $nom, prenom: $prenom,adresse: $adresse,telephone: $telephone,email: $email,username: $username,password: $password,role: $role }';
  }
}