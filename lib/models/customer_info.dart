import 'dart:convert';

List<CustomerInfo> infoFromJson(String str) => List<CustomerInfo>.from(
    json.decode(str).map((x) => CustomerInfo.fromJson(x)));

String infoToJson(List<CustomerInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerInfo {
  CustomerInfo({
    required this.name,
    required this.bookNumber,
    required this.isVip,
    required this.total,
  });
  String name;
  String bookNumber;
  bool isVip;
  String total;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        name: json['name'],
        bookNumber: json['bookNumber'],
        isVip: json['isVip'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'bookNumber': bookNumber,
        'isVip': isVip,
        'total': total,
      };
}

late List<CustomerInfo> customerInfo = [];

String getNumberOfCustomer() {
  return customerInfo.length.toString();
}

String getNumberOfVipCustomers() {
  int numberOfVipCustomer =
      customerInfo.where((customer) => customer.isVip == true).length;
  return numberOfVipCustomer.toString();
}

String getTotalValue() {
  int totalValue = customerInfo
      .map((customer) => int.parse(customer.total))
      .fold(0, (previousValue, element) => previousValue + element);
  return totalValue.toString();
}