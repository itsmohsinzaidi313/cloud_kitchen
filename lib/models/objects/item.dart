class Item {

   String serverId;
   String code;
   String name;
   String salePrice;
   String photo;
   String categoryName;
   String percentage;
   String quantity;

  Item({this.serverId, this.code, this.name, this.salePrice, this.photo,
      this.categoryName, this.percentage, this.quantity});

  Item.fromJson(Map<String, dynamic> json)
  :
    serverId = json['id'],
    code = json['code'],
    name = json['name'],
    salePrice = json['sale_price'],
    photo = json['photo'],
    categoryName = json['category_name'],
    quantity = 1.toString(),
    percentage = json['percentage'];

  @override
  String toString() {
    return 'ItemMenus{id: $serverId, code: $code, name: $name, salePrice: $salePrice, photo: $photo, categoryName: $categoryName, percentage: $percentage}';
  }


}