class Modifiers {

  final String serverId;
  final String name;
  final String price;
  final String description;
  final String userId;
  final String companyId;
  final String delStatus;

  Modifiers({this.serverId, this.name, this.price, this.description,
      this.userId, this.companyId, this.delStatus});

  Modifiers.fromJson(Map<String, dynamic> json)
  :
    serverId = json['id'],
    name = json['name'],
    price = json['price'],
    description = json['description'],
    userId = json['user_id'],
    companyId = json['company_id'],
    delStatus = json['del_status'];

  @override
  String toString() {
    return 'Modifiers{id: $serverId, name: $name, price: $price, description: $description, userId: $userId, companyId: $companyId, delStatus: $delStatus}';
  }
}