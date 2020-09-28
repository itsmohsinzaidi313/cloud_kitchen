import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/company.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/expense_category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/item_modifier.dart';
import 'package:food_app/models/objects/modifier.dart';
import 'package:food_app/models/objects/outlet.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/table.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/objects/vatamount.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:food_app/shared/data_lists.dart';

class ApiInstall {
  final String status;
  final String message;
  final Map data;
  final Logger _log = Config.log;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  ApiInstall({this.status, this.message, this.data}) {
    if (this.data != null) {
      List<bool> x = [];
      try {
        getCompanyList(data['company']);
        x.add(true);
        _log.v('DATA LIST Company Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getCompanyList\n$e');
      }

      try {
        getOutletList(data['outlet']);
        x.add(true);
        _log.v('DATA LIST outlet Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getOutletList\n$e');
      }

      try {
        getUsersList(data['users']);
        x.add(true);
        _log.v('DATA LIST users Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getUsersList\n$e');
      }

      try {
        getVatAmountList(data['vatamount']);
        x.add(true);
        _log.v('DATA LIST vatamount Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getVatAmountList\n$e');
      }

      try {
        getTablesList(data['tables']);
        x.add(true);
        _log.v('DATA LIST tables Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getTablesList\n$e');
      }

      try {
        getCategoriesList(data['categories']);
        x.add(true);
        _log.v('DATA LIST categories Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getCategoriesList\n$e');
      }

      try {
        getModifiersList(data['modifiers']);
        x.add(true);
        _log.v('DATA LIST modifiers Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getModifiersList\n$e');
      }

      try {
        getItemList(data['item_menus']);
        x.add(true);
        _log.v('DATA LIST item_menus Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getItemMenusList\n$e');
      }

      try {
        getItemModifiersList(data['item_modifiers']);
        x.add(true);
        _log.v('DATA LIST item_modifiers Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getItemModifiersList\n$e');
      }

      try {
        getCustomersList(data['customers']);
        x.add(true);
        _log.v('DATA LIST customers Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getCustomersList\n$e');
      }

      try {
        getPaymentMethodsList(data['payment_methods']);
        x.add(true);
        _log.v('DATA LIST payment_methods Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getPaymentMethodsList\n$e');
      }

      try {
        getExpenseCategoriesList(data['expense_categories']);
        x.add(true);
        _log.v('DATA LIST expense_categories Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getExpenseCategoriesList\n$e');
      }

      try {
        getSalesList(data['sales']);
        x.add(true);
        _log.v('DATA LIST sales Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getSalesList\n$e');
      }

      try {
        getExpensesList(['expenses']);
        x.add(true);
        _log.v('DATA LIST expenses Ready.');
      } catch (e) {
        x.add(false);
        _log.e('>>>ERROR ON getExpensesList\n$e');
      }
    } else {
      _log.i('NULL DATA PASSED TO INSTALL API');
    }
  }


  void getCompanyList(List<dynamic> i) {
    i.forEach((e) {
      DataLists.onlineInstance.listCompany.add(new Company(
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
    i.forEach((e) {
      DataLists.onlineInstance.listOutlet.add(new Outlet(
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
    i.forEach((e) {
      DataLists.onlineInstance.listUsers.add(new User(
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
    i.forEach((e) {
      DataLists.onlineInstance.listVatAmount.add(new VatAmount(
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
    i.forEach((e) {
      DataLists.onlineInstance.listTables.add(new Table(
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
    i.forEach((e) {
      DataLists.onlineInstance.listCategories.add(new Category(
          serverId: e['id'],
          categoryName: e['category_name'],
          description: e['description'],
          userId: e['user_id'],
          companyId: e['company_id'],
          delStatus: e['del_status']));
    });
  }

  void getModifiersList(List<dynamic> i) {
    i.forEach((e) {
      DataLists.onlineInstance.listModifiers.add(new Modifier(
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
    i.forEach((e) {
      DataLists.onlineInstance.listItem.add(new Item(
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
    i.forEach((e) {
      DataLists.onlineInstance.listItemModifiers.add(new ItemModifier(
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
    i.forEach((e) {
      DataLists.onlineInstance.listCustomers.add(new Customer(
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
    i.forEach((e) {
      DataLists.onlineInstance.listPaymentMethods.add(new PaymentMethod(
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
    i.forEach((e) {
      DataLists.onlineInstance.listExpenseCategories.add(new ExpenseCategory(
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
