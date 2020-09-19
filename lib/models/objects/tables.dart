class Tables {

  final String serverId;
  final String name;
  final String sitCapacity;
  final String position;
  final String description;
  final String userId;
  final String outletId;
  final String companyId;
  final String delStatus;

  Tables({this.serverId, this.name, this.sitCapacity, this.position, this.description,
      this.userId, this.outletId, this.companyId, this.delStatus});

  Tables.fromJson(Map<String, dynamic> json)
  :
    serverId = json['id'],
    name = json['name'],
    sitCapacity = json['sit_capacity'],
    position = json['position'],
    description = json['description'],
    userId = json['user_id'],
    outletId = json['outlet_id'],
    companyId = json['company_id'],
    delStatus = json['del_status'];

  @override
  String toString() {
    return 'Tables{id: $serverId, name: $name, sitCapacity: $sitCapacity, position: $position, description: $description, userId: $userId, outletId: $outletId, companyId: $companyId, delStatus: $delStatus}';
  }
}