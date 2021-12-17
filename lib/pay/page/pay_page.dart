import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  late PayManger payManger = PayManger();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '支付',
      ),
      body: Container(
        color: Colours.material_bg,
        child: Text(payManger.products.length.toString()),
      ),
    );
  }
}
