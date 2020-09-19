class ItemModifiers {

  final String serverId;
  final String modifierId;
  final String foodMenuId;
  final String userId;
  final String outletId;
  final String companyId;
  final String delStatus;
  final String name;
  final String price;


  ItemModifiers({this.serverId, this.modifierId, this.foodMenuId, this.userId,
      this.outletId, this.companyId, this.delStatus, this.name, this.price});

  ItemModifiers.fromJson(Map<String, dynamic> json)
  :
    serverId = json['id'],
    modifierId = json['modifier_id'],
    foodMenuId = json['food_menu_id'],
    userId = json['user_id'],
    outletId = json['outlet_id'],
    companyId = json['company_id'],
    name = json['name'],
    price = json['price'],
    delStatus = json['del_status'];

  @override
  String toString() {
    return 'ItemModifiers{id: $serverId, modifierId: $modifierId, foodMenuId: $foodMenuId, userId: $userId, outletId: $outletId, companyId: $companyId, delStatus: $delStatus, name: $name, price: $price}';
  }
}