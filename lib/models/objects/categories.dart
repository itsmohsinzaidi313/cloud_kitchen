class Categories {

  final String serverId;
  final String categoryName;
  final String description;
  final String userId;
  final String companyId;
  final String delStatus;

  Categories({this.serverId, this.categoryName, this.description,
      this.userId, this.companyId, this.delStatus});

  Categories.fromJson(Map<String, dynamic> json)
  :
    serverId = json['id'],
    categoryName = json['category_name'],
    description = json['description'],
    userId = json['user_id'],
    companyId = json['company_id'],
    delStatus = json['del_status'];

  @override
  String toString() {
    return 'Categories{id: $serverId, categoryName: $categoryName, description: $description, userId: $userId, companyId: $companyId, delStatus: $delStatus}';
  }
}