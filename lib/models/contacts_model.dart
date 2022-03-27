class ContactsModel {
  dynamic id;
  String contact;
  int phone;
  int mobil;
  String addres;
  String nicks;

  ContactsModel({
    this.id,
    required this.contact,
    required this.phone,
    required this.mobil,
    required this.addres,
    required this.nicks,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
        id: json["id"],
        contact: json["contact"] as dynamic,
        phone: json["phone"] as dynamic,
        mobil: json["mobil"] as dynamic,
        addres: json["addres"] as dynamic,
        nicks: json["nicks"] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact": contact,
        "phone": phone,
        "mobil": mobil,
        "addres": addres,
        "nicks": nicks,
      };
}
