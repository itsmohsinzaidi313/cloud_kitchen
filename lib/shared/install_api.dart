import 'package:food_app/database/table_object/tables_table.dart';
import 'package:food_app/models/objects/category.dart';
import 'package:food_app/models/objects/company.dart';
import 'package:food_app/models/objects/customer.dart';
import 'package:food_app/models/objects/device.dart';
import 'package:food_app/models/objects/expense_category.dart';
import 'package:food_app/models/objects/item.dart';
import 'package:food_app/models/objects/item_modifier.dart';
import 'package:food_app/models/objects/modifier.dart';
import 'package:food_app/models/objects/outlet.dart';
import 'package:food_app/models/objects/payment_method.dart';
import 'package:food_app/models/objects/register.dart';
import 'package:food_app/models/objects/table.dart';
import 'package:food_app/models/objects/user.dart';
import 'package:food_app/models/objects/vat_amount.dart';
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

  ApiInstall({this.status, this.message, this.data});

  Future<bool> init() async {
    if (this.data != null) {
      try {
        getCompanyList(data['company']);
        _log.v('DATA LIST Company Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getCompanyList', [e]);
        return false;
      }

      try {
        getOutletList(data['outlet']);
        _log.v('DATA LIST outlet Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getOutletList', [e]);
        return false;
      }

      try {
        getUsersList(data['users']);
        _log.v('DATA LIST users Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getUsersList', [e]);
        return false;
      }

      try {
        getVatAmountList(data['vatamount']);
        _log.v('DATA LIST vatamount Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getVatAmountList', [e]);
        return false;
      }

      try {
        getTablesList(data['tables']);
        _log.v('DATA LIST tables Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getTablesList', [e]);
        return false;
      }

      try {
        getCategoriesList(data['categories']);
        _log.v('DATA LIST categories Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getCategoriesList', [e]);
        return false;
      }

      try {
        getModifiersList(data['modifiers']);
        _log.v('DATA LIST modifiers Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getModifiersList', [e]);
        return false;
      }

      try {
        getItemList(data['item_menus']);
        _log.v('DATA LIST item_menus Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getItemMenusList', [e]);
        return false;
      }

      try {
        getItemModifiersList(data['item_modifiers']);
        _log.v('DATA LIST item_modifiers Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getItemModifiersList', [e]);
        return false;
      }

      try {
        getCustomersList(data['customers']);
        _log.v('DATA LIST customers Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getCustomersList', [e]);
        return false;
      }

      try {
        getPaymentMethodsList(data['payment_methods']);
        _log.v('DATA LIST payment_methods Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getPaymentMethodsList', [e]);
        return false;
      }

      try {
        getExpenseCategoriesList(data['expense_categories']);
        _log.v('DATA LIST expense_categories Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getExpenseCategoriesList', [e]);
        return false;
      }

      try {
        getSalesList(data['sales']);
        _log.v('DATA LIST sales Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getSalesList', [e]);
        return false;
      }

      try {
        getExpensesList(data['expenses']);
        _log.v('DATA LIST expenses Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getExpensesList', [e]);
        return false;
      }

      try {
        getDeviceList(data['device']);
        _log.v('DATA LIST device Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getDeviceList', [e]);
        return false;
      }

      try {
        getRegisterList(data['registers']);
        _log.v('DATA LIST registers Ready.');
      } catch (e) {
        _log.e('>>>ERROR ON getRegistersList', [e]);
        return false;
      }

      return true;
    } else {
      _log.i('NULL DATA PASSED TO INSTALL API');
      return false;
    }
  }

  void getCompanyList(List<dynamic> i) {
    i.forEach((e) {
      DataLists.instance.listCompany.add(new Company(
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
      DataLists.instance.listOutlet.add(new Outlet(
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
      DataLists.instance.listUsers.add(new User(
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
      DataLists.instance.listVatAmount.add(new VatAmount(
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
      DataLists.instance.listTables.add(new Table(
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
      DataLists.instance.listCategories.add(new Category(
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
      DataLists.instance.listModifiers.add(new Modifier(
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
      DataLists.instance.listItem.add(new Item(
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
      DataLists.instance.listItemModifiers.add(new ItemModifier(
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
      DataLists.instance.listCustomers.add(new Customer(
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
      DataLists.instance.listPaymentMethods.add(new PaymentMethod(
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
      DataLists.instance.listExpenseCategories.add(new ExpenseCategory(
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

  void getDeviceList(List<dynamic> i) {
    i.forEach((e) {
      DataLists.instance.listDevices.add(new Device(
        serverId: e['id'],
        outletId: e['outlet_id'],
        companyId: e['company_id'],
        deviceKey: e['device_key'],
        delStatus: e['del_status'],
        isInstalled: e['is_installed'],
        dateAdded: e['date_added'],
        dateModified: e['date_modified'],
      ));
    });
  }

  void getRegisterList(List<dynamic> i) {
    i.forEach((element) {
      DataLists.instance.listRegisters.add(new Register.fromJson(element));
    });
  }
}
