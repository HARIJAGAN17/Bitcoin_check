import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Coin_data.dart';
import 'dart:io';

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  String currencyValue = 'USD';


  DropdownButton<String> android_scroll() {
    List<DropdownMenuItem<String>> dropDown = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var eachCurrency = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
      dropDown.add(eachCurrency);
    }
    return DropdownButton<String>(
      value: currencyValue,
      items: dropDown,
      onChanged: (value) {
        setState(
          () {
            currencyValue = value!;
            getData();
          },
        );
      },
    );
  }

  CupertinoPicker iosScroll() {
    List<Text> scrollerData = [];
    for (int i = 0; i < currenciesList.length; i++) {
      Text currency = Text(currenciesList[i]);
      scrollerData.add(currency);
    }
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
          initialItem: (currenciesList.length / 2).toInt()),
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        print(index);
      },
      children: scrollerData,
    );
  }
  Map<String, String> coinValues = {};
  String rate = '?';
  bool isWaiting = false;
  void getData() async {
    isWaiting = true;
    try{
      var data = await CoinData().getData(currencyValue);
      isWaiting = false;
      setState(() {
        coinValues =data;
      });
    }
    catch(e)
    {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6B511),
        title: const Text(
          '⚡ BITCOIN',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ReusableCard(rate: isWaiting ? '?' : coinValues['BTC'], currencyValue: currencyValue,selectedCrypto: 'BTC',),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ReusableCard(rate: isWaiting ? '?' : coinValues['ETH'], currencyValue: currencyValue,selectedCrypto: 'ETH',),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ReusableCard(rate: isWaiting ? '?' : coinValues['LTC'], currencyValue: currencyValue,selectedCrypto: 'LTC',),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF6B511),
                    borderRadius: BorderRadius.circular(5.0)),
                height: 150.0,
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Currency: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                      ),
                      Platform.isIOS ? iosScroll() : android_scroll()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.rate,
    required this.currencyValue,
    required this.selectedCrypto,
  });
  final String selectedCrypto;
  final String? rate;
  final String currencyValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      color: Color(0xFFF6B511),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "1 $selectedCrypto = $rate $currencyValue",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      elevation: 8.0,
    );
  }
}
