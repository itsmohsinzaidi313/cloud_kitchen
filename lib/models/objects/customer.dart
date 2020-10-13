import 'package:food_app/database/table_object/customer_table.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Customer {
  String remoteId;
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
  final String isUpload;

  Customer.fromJson(Map<String, dynamic> json)
      : remoteId = json['local_id'].toString(),
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
        dateOfAnniversary = json['date_of_anniversary'],
        isUpload = json['is_upload'];

  Map<String, dynamic> toMap(Customer customer) {
    return {
      'id': customer.serverId,
      'name': customer.name,
      'phone': customer.phone,
      'email': customer.email,
      'address': customer.address,
      'gst_number': customer.gstNumber,
      'area_id': customer.areaId,
      'user_id': customer.userId,
      'company_id': customer.companyId,
      'del_status': customer.delStatus,
      'date_of_birth': customer.dateOfBirth,
      'date_of_anniversary': customer.dateOfAnniversary,
      'is_upload' : customer.isUpload
    };
  }

  Customer(
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
      this.dateOfAnniversary,
      this.isUpload});

  @override
  String toString() {
    return 'Customers{id: $serverId, name: $name, phone: $phone, email: $email, address: $address, gstNumber: $gstNumber, areaId: $areaId, userId: $userId, companyId: $companyId, delStatus: $delStatus, dateOfBirth: $dateOfBirth, dateOfAnniversary: $dateOfAnniversary}';
  }

  List<String> getList() => [
        this.serverId,
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
        this.dateOfAnniversary,
        this.isUpload
      ];

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[CustomerTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, CustomerTable.tableName, getValues());

  Future<int> insertCustomer(Database db, Customer customer) async {
    Map<String, dynamic> row = Customer().toMap(customer);
    int id = await db.insert(CustomerTable.tableName, row);
    return id;
  }

  Future<List<Customer>> getCustomer(Database db) async {
    List<Customer> customerList = [];
    List<Map<String, dynamic>> customerMap = await db.query(CustomerTable.tableName);
    customerMap.forEach((customer) {
      customerList.add(Customer.fromJson(customer));
    });
    return customerList;
  }

  Future<List<Customer>> getCustomerById(Database db, int id) async {
    List<Customer> customerList = [];
    List<Map<String, dynamic>> customerMap = await db.query(CustomerTable.tableName,
        columns: [CustomerTable.name, CustomerTable.phone],
        where: '${CustomerTable.localId} = $id');
    customerMap.forEach((customer) {
      customerList.add(Customer.fromJson(customer));
    });
    return customerList;
  }
}
