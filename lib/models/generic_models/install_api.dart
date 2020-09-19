import 'package:food_app/models/objects/categories.dart';
import 'package:food_app/models/objects/company.dart';
import 'package:food_app/models/objects/customers.dart';
import 'package:food_app/models/objects/expense_categories.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/item_modifiers.dart';
import 'package:food_app/models/objects/modifiers.dart';
import 'package:food_app/models/objects/outlet.dart';
import 'package:food_app/models/objects/payment_methods.dart';
import 'package:food_app/models/objects/tables.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/objects/vatamount.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'data_lists.dart';

class ApiInstall {
  final String status;
  final String message;
  final Map data;
  final Logger _log = Config.log;

  ApiInstall({this.status, this.message, this.data}) {
    if (this.data != null) {
      try {
        getCompanyList(data['company']);
      } catch (e) {
        _log.e('>>>ERROR ON getCompanyList\n$e');
      }

      try {
        getOutletList(data['outlet']);
      } catch (e) {
        _log.e('>>>ERROR ON getOutletList\n$e');
      }

      try {
        getUsersList(data['users']);
      } catch (e) {
        _log.e('>>>ERROR ON getUsersList\n$e');
      }

      try {
        getVatAmountList(data['vatamount']);
      } catch (e) {
        _log.e('>>>ERROR ON getVatAmountList\n$e');
      }

      try {
        getTablesList(data['tables']);
      } catch (e) {
        _log.e('>>>ERROR ON getTablesList\n$e');
      }

      try {
        getCategoriesList(data['categories']);
      } catch (e) {
        _log.e('>>>ERROR ON getCategoriesList\n$e');
      }

      try {
        getModifiersList(data['modifiers']);
      } catch (e) {
        _log.e('>>>ERROR ON getModifiersList\n$e');
      }

      try {
        getItemList(data['item_menus']);
      } catch (e) {
        _log.e('>>>ERROR ON getItemMenusList\n$e');
      }

      try {
        getItemModifiersList(data['item_modifiers']);
      } catch (e) {
        _log.e('>>>ERROR ON getItemModifiersList\n$e');
      }

      try {
        getCustomersList(data['customers']);
      } catch (e) {
        _log.e('>>>ERROR ON getCustomersList\n$e');
      }

      try {
        getPaymentMethodsList(data['payment_methods']);
      } catch (e) {
        _log.e('>>>ERROR ON getPaymentMethodsList\n$e');
      }

      try {
        getExpenseCategoriesList(data['expense_categories']);
      } catch (e) {
        _log.e('>>>ERROR ON getExpenseCategoriesList\n$e');
      }

      try {
        getSalesList(data['sales']);
      } catch (e) {
        _log.e('>>>ERROR ON getSalesList\n$e');
      }

      try {
        getExpensesList(['expenses']);
      } catch (e) {
        _log.e('>>>ERROR ON getExpensesList\n$e');
      }
    } else {
      _log.i('NULL DATA PASSED TO INSTALL API');
    }
  }

  ///*From here............................................*/

  void getCompanyList(List<dynamic> i) {
    DataLists.listCompany = [];
    i.forEach((e) {
      DataLists.listCompany.add(new Company(
          serverId: e['id'],
          currency: e['currency'],
          timezone: e['timezone'],
          dateFormat: e['date_format'],
          outletId: e['outlet_id'],
          name: e['name'],
          email: e['email'],
          phone1: e['phone_1'],
          phone2: e['phone_2'],
          address: e['address'],
          status: e['status'],
          dateAdded: e['date_added'],
          expiryDate: e['expiry_date'],
          token: e['token']));
    });
  }

  void getOutletList(List<dynamic> i) {
    DataLists.listOutlet = [];
    i.forEach((e) {
      DataLists.listOutlet.add(new Outlet(
          serverId: e['id'],
          outletName: e['outlet_name'],
          outletCode: e['outlet_code'],
          address: e['address'],
          phone: e['phone'],
          invoicePrint: e['invoice_print'],
          startingDate: e['starting_date'],
          invoiceFooter: e['invoice_footer'],
          collectTax: e['collect_tax'],
          preOrPostOrder: e['pre_or_post_payment'],
          userId: e['user_id'],
          companyId: e['company_id'],
          delStatus: e['del_status']));
    });
  }

  void getUsersList(List<dynamic> i) {
    DataLists.listUsers = [];
    i.forEach((e) {
      DataLists.listUsers.add(new Users(
          serverId: e['id'],
          fullName: e['full_name'],
          phone: e['phone'],
          emailAddress: e['email_address'],
          password: e['password'],
          designation: e['designation'],
          willLogin: e['will_login'],
          role: e['role'],
          outletId: e['outlet_id'],
          companyId: e['company_id'],
          accountCreationDate: e['account_creation_date'],
          language: e['language'],
          lastLogin: e['last_login'],
          activeStatus: e['active_status'],
          delStatus: e['del_status']));
    });
  }

  void getVatAmountList(List<dynamic> i) {
    DataLists.listVatAmount = [];
    i.forEach((e) {
      DataLists.listVatAmount.add(new VatAmount(
        serverID: e['id'],
        name: e['name'],
        percentage: e['percentage'],
        companyId: e['company_id'],
        userId: e['user_id'],
        delStatus: e['del_status'],
      ));
    });
  }

  void getTablesList(List<dynamic> i) {
    DataLists.listTables = [];
    i.forEach((e) {
      DataLists.listTables.add(new Tables(
          serverId: e['id'],
          name: e['name'],
          sitCapacity: e['sit_capacity'],
          position: e['position'],
          description: e['description'],
          userId: e['user_id'],
          outletId: e['outlet_id'],
          companyId: e['company_id'],
          delStatus: e['del_status']));
    });
  }

  void getCategoriesList(List<dynamic> i) {
    DataLists.listCategories = [];
    i.forEach((e) {
      DataLists.listCategories.add(new Categories(
          serverId: e['id'],
          categoryName: e['category_name'],
          description: e['description'],
          userId: e['user_id'],
          companyId: e['company_id'],
          delStatus: e['del_status']));
    });
  }

  void getModifiersList(List<dynamic> i) {
    DataLists.listModifiers = [];
    i.forEach((e) {
      DataLists.listModifiers.add(new Modifiers(
          serverId: e['id'],
          name: e['name'],
          price: e['price'],
          description: e['description'],
          userId: e['user_id'],
          companyId: e['company_id'],
          delStatus: e['del_status']));
    });
  }

  void getItemList(List<dynamic> i) {
    DataLists.listItem = [];
    i.forEach((e) {
      DataLists.listItem.add(new Item(
          serverId: e['id'],
          code: e['code'],
          name: e['name'],
          salePrice: e['sale_price'],
          photo: e['photo'],
          categoryName: e['category_name'],
          quantity: 1.toString(),
          percentage: e['percentage']));
    });
  }

  void getItemModifiersList(List<dynamic> i) {
    DataLists.listItemModifiers = [];
    i.forEach((e) {
      DataLists.listItemModifiers.add(new ItemModifiers(
          serverId: e['id'],
          modifierId: e['modifier_id'],
          foodMenuId: e['food_menu_id'],
          userId: e['user_id'],
          outletId: e['outlet_id'],
          companyId: e['company_id'],
          name: e['name'],
          price: e['price'],
          delStatus: e['del_status']));
    });
  }

  void getCustomersList(List<dynamic> i) {
    DataLists.listCustomers = [];
    i.forEach((e) {
      DataLists.listCustomers.add(new Customers(
          serverId: e['id'],
          name: e['name'],
          phone: e['phone'],
          email: e['email'],
          address: e['address'],
          gstNumber: e['gst_number'],
          areaId: e['area_id'],
          userId: e['user_id'],
          companyId: e['company_id'],
          delStatus: e['del_status'],
          dateOfBirth: e['date_of_birth'],
          dateOfAnniversary: e['date_of_anniversary']));
    });
  }

  void getPaymentMethodsList(List<dynamic> i) {
    DataLists.listPaymentMethods = [];
    i.forEach((e) {
      DataLists.listPaymentMethods.add(new PaymentMethods(
        serverId: e['id'],
        name: e['name'],
        description: e['description'],
        userId: e['user_id'],
        companyId: e['company_id'],
        delStatus: e['del_status'],
      ));
    });
  }

  void getExpenseCategoriesList(List<dynamic> i) {
    DataLists.listExpenseCategories = [];
    i.forEach((e) {
      DataLists.listExpenseCategories.add(new ExpenseCategories(
        serverId: e['id'],
        name: e['name'],
        description: e['description'],
        userId: e['user_id'],
        companyId: e['company_id'],
        delStatus: e['del_status'],
      ));
    });
  }

  void getSalesList(List<dynamic> i) {}

  void getExpensesList(List<dynamic> i) {}
}
