import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:online_selling_book/components/my_button_design.dart';
import 'package:online_selling_book/components/my_info_bar.dart';
import 'package:online_selling_book/components/my_show_info.dart';
import 'package:online_selling_book/components/my_text_design.dart';
import 'package:online_selling_book/components/my_text_field_design.dart';
import 'package:online_selling_book/models/customer_info.dart';
import 'package:online_selling_book/pages/settings_page.dart';
import 'package:online_selling_book/theme/calculate_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillCalculator extends StatefulWidget {
  const BillCalculator({super.key});

  @override
  State<BillCalculator> createState() => _BillCalculatorState();
}

class _BillCalculatorState extends State<BillCalculator> {
  late TextEditingController _customerName = TextEditingController();
  late TextEditingController _bookNumber = TextEditingController();
  bool isFocus = false;
  bool isShow = false;
  bool isChecked = false;
  String total = "";

  @override
  void initState() {
    super.initState();
    _loadCustomerInfo();
  }

  void _loadCustomerInfo() async {
    final customerInfoData = await SharedPreferences.getInstance();
    setState(() {
      customerInfo =
          infoFromJson(customerInfoData.getString('customerInfoData') ?? "");
    });
  }

  void _saveCustomerInfo() async {
    final customerInfoData = await SharedPreferences.getInstance();
    customerInfoData.setString('customerInfoData', infoToJson(customerInfo));
  }

  void displayTotalTable() {
    setState(() {
      isShow = true;
    });
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(
        child: Column(
          children: [
            MyInfoBar(title: 'Thông tin thống kê'),
            MyShowInfo(title: 'Tổng số KH :', text: getNumberOfCustomer()),
            MyShowInfo(
                title: 'Tổng số KH là VIP:', text: getNumberOfVipCustomers()),
            MyShowInfo(
              title: 'Tổng doanh thu :',
              text: getTotalValue(),
            ),
            MyInfoBar(title: ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Thoat button
                IconButton(
                  icon: Icon(Icons.exit_to_app_rounded),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        content: const MyTextDesign(
                            text: 'Bạn có chắc chắn muốn thoát không?'),
                        actions: [
                          MyButtonDesign(
                              title: 'Không',
                              function: () {
                                Navigator.pop(context);
                              }),
                          MyButtonDesign(
                              title: 'Có',
                              function: () {
                                _saveCustomerInfo();
                                SystemChannels.platform
                                    .invokeMethod('SystemNavigator.pop');
                              }),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void clearData() {
    _customerName.clear();
    _bookNumber.clear();
    isChecked = false;
    Provider.of<CalculateProvider>(context, listen: false).clearData();
  }

  void addInfoToList() {
    customerInfo.add(CustomerInfo(
        name: _customerName.text,
        bookNumber: _bookNumber.text,
        isVip: isChecked,
        total: total));
  }

  String getTotal() {
    total = Provider.of<CalculateProvider>(context, listen: false).total;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: height * 1 / 25),
        child: Column(
          children: [
            Column(
              children: [
                // App bar
                Container(
                  width: width,
                  color: Color.fromARGB(197, 72, 199, 82),
                  height: height * 1 / 10,
                  child: Stack(
                    children: [
                      const Center(
                        child: Text('Chương trình bán sách Online',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                      const Positioned(
                          bottom: 0,
                          left: 0,
                          child: MyTextDesign(text: 'Thông tin hóa đơn')),
                      Positioned(
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SettingsPage())));
                            },
                            icon: const Icon(Icons.settings)),
                      ),
                    ],
                  ),
                ),
                // Ten khach hang
                MyTextFieldDesign(
                    title: 'Tên Khách Hàng :',
                    hintText: 'Nhập tên khách hàng',
                    controller: _customerName,
                    inputType: TextInputType.text,
                    isFocus: true),
                // So luong sach
                MyTextFieldDesign(
                    title: 'Số lượng sách :',
                    hintText: 'Nhập số lượng sách',
                    controller: _bookNumber,
                    inputType: TextInputType.number,
                    isFocus: false),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: width * 3 / 5,
                      child: Row(
                        children: [
                          // Nut checkbox
                          Checkbox(
                            value:
                                Provider.of<CalculateProvider>(context).isVip,
                            onChanged: (value) {
                              Provider.of<CalculateProvider>(context,
                                      listen: false)
                                  .setChecked(value!);
                              isChecked = Provider.of<CalculateProvider>(
                                      context,
                                      listen: false)
                                  .isVip;
                              print(isChecked);
                            },
                            activeColor: Colors.red,
                          ),
                          MyTextDesign(text: 'Khách hàng Vip'),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextDesign(text: 'Thành Tiền :'),
                    Container(
                      color: Theme.of(context).colorScheme.secondary,
                      height: height * 1 / 20,
                      width: width * 3 / 5,
                      child: Center(
                        child: MyTextDesign(
                          text: getTotal(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 1 / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Tinh TT button
                    MyButtonDesign(
                        title: 'TÍNH TT',
                        function: () {
                          // nhan so luong sach
                          Provider.of<CalculateProvider>(context, listen: false)
                              .setBookNumber(_bookNumber.text);
                          // tinh so tien
                          Provider.of<CalculateProvider>(context, listen: false)
                              .calculateResult();
                        }),
                    // Tiep button
                    MyButtonDesign(
                        title: 'TIẾP',
                        function: () {
                          addInfoToList();
                          clearData();
                        }),
                    // Thong ke button
                    MyButtonDesign(
                        title: 'THỐNG KÊ', function: () => displayTotalTable()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
