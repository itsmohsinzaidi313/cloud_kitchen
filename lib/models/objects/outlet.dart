class Outlet {
  final String serverId;
  final String outletName;
  final String outletCode;
  final String address;
  final String phone;
  final String invoicePrint;
  final String startingDate;
  final String invoiceFooter;
  final String collectTax;
  final String preOrPostOrder;
  final String userId;
  final String companyId;
  final String delStatus;

  Outlet(
      {this.serverId,
      this.outletName,
      this.outletCode,
      this.address,
      this.phone,
      this.invoicePrint,
      this.startingDate,
      this.invoiceFooter,
      this.collectTax,
      this.preOrPostOrder,
      this.userId,
      this.companyId,
      this.delStatus});

  Outlet.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        outletName = json['outlet_name'],
        outletCode = json['outlet_code'],
        address = json['address'],
        phone = json['phone'],
        invoicePrint = json['invoice_print'],
        startingDate = json['starting_date'],
        invoiceFooter = json['invoice_footer'],
        collectTax = json['collect_tax'],
        preOrPostOrder = json['pre_or_post_payment'],
        userId = json['user_id'],
        companyId = json['company_id'],
        delStatus = json['del_status'];

  @override
  String toString() {
    return 'Outlet{id: $serverId, outletName: $outletName, outletCode: $outletCode, address: $address, phone: $phone, invoicePrint: $invoicePrint, startingDate: $startingDate, invoiceFooter: $invoiceFooter, collectTax: $collectTax, preOrPostOrder: $preOrPostOrder, userId: $userId, companyId: $companyId, delStatus: $delStatus}';
  }
}
