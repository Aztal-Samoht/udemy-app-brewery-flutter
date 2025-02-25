import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_h_cripto_tracker/coin_card.dart';
import 'package:project_h_cripto_tracker/constants.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'network_helper.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcPrice = '??';
  String ethPrice = '??';
  String dogePrice = '??';
  Uri btcUrl;
  Uri ethUrl;
  Uri dogeUrl;

  CupertinoPicker getCupertinoPicker() {
    List<Text> menuItems = [];
    kCurrenciesList.forEach((String a) {
      menuItems.add(
        Text(
          a,
          style: TextStyle(color: Colors.white),
        ),
      );
    });
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: menuItems,
    );
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> menuItems = [];
    kCurrenciesList.forEach((String a) {
      menuItems.add(DropdownMenuItem(child: Text(a), value: a));
    });
    return DropdownButton<String>(
      value: selectedCurrency.toString(),
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        updatePrices(value);
      },
    );
  }

  void updatePrices(String value) async {
    updateUrls();
    String bPrice = await getPrice(btcUrl);
    String ePrice = await getPrice(ethUrl);
    String dPrice = await getPrice(dogeUrl);
    setState(() {
      btcPrice = bPrice;
      ethPrice = ePrice;
      dogePrice = dPrice;
    });
  }

  void updateUrls() {
    btcUrl = NetworkHelper.buildUrl(kBtcPath, selectedCurrency);
    ethUrl = NetworkHelper.buildUrl(kEthPath, selectedCurrency);
    dogeUrl = NetworkHelper.buildUrl(kDogePath, selectedCurrency);
  }

  Future<String> getPrice(Uri url) async {
    return (await NetworkHelper.staticGetData(url))['rate'].toStringAsFixed(5);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CoinCard(
              title: 'BTC',
              price: btcPrice,
              selectedCurrency: selectedCurrency),
          CoinCard(
              title: 'ETH',
              price: ethPrice,
              selectedCurrency: selectedCurrency),
          CoinCard(
              title: 'Doge',
              price: dogePrice,
              selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
