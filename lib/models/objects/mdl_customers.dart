class Customers{

   final String serverId;
   final String name;
   final String phone;
   final String email;
   final String address;
   final String gstNumber;
   final String areaId;
   final String userId;
   final String companyId;
   final String delStatus;
   final String dateOfBirth;
   final String dateOfAnniversary;

   Customers.fromJson(Map<String, dynamic> json)
  :
   serverId = json['id'],
   name = json['name'],
   phone = json['phone'],
   email = json['email'],
   address = json['address'],
   gstNumber = json['gst_number'],
   areaId = json['area_id'],
   userId = json['user_id'],
   companyId = json['company_id'],
   delStatus = json['del_status'],
   dateOfBirth = json['date_of_birth'],
   dateOfAnniversary = json['date_of_anniversary'];

   Customers(
      {this.serverId,
      this.name,
      this.phone,
      this.email,
      this.address,
      this.gstNumber,
      this.areaId,
      this.userId,
      this.companyId,
      this.delStatus,
      this.dateOfBirth,
      this.dateOfAnniversary});

   @override
  String toString() {
    return 'Customers{id: $serverId, name: $name, phone: $phone, email: $email, address: $address, gstNumber: $gstNumber, areaId: $areaId, userId: $userId, companyId: $companyId, delStatus: $delStatus, dateOfBirth: $dateOfBirth, dateOfAnniversary: $dateOfAnniversary}';
  }
}