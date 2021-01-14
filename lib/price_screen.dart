import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  String exchangeRate1 = '?';
  String exchangeRate2 = '?';
  String exchangeRate3 = '?';

  Widget androidPicker() {
    return DropdownButton(
      value: currency,
      items: CoinData.getCoinData(),
      onChanged: (value) {
        setState(() {
          currency = value;
          getRate();
        });
      },
    );
  }

  Widget iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectIndex) {
        setState(() {
          print(selectIndex);
        });
      },
      children: CoinData.getCoinData(),
    );
  }

  void getRate() async {
    String btcRate = await CoinData.getExchangeRate(
        currency: currency, cryptoCurrency: 'BTC');
    String ethRate = await CoinData.getExchangeRate(
        currency: currency, cryptoCurrency: 'ETH');
    String ltcRate = await CoinData.getExchangeRate(
        currency: currency, cryptoCurrency: 'LTC');
    if (btcRate != null) {
      setState(() {
        exchangeRate1 = btcRate;
        exchangeRate2 = ethRate;
        exchangeRate3 = ltcRate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRate();
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
          CryptoCurrency(
              cryptoCurrency: 'BTC',
              exchangeRate: exchangeRate1,
              currency: currency),
          CryptoCurrency(
              cryptoCurrency: 'ETH',
              exchangeRate: exchangeRate2,
              currency: currency),
          CryptoCurrency(
              cryptoCurrency: 'LTC',
              exchangeRate: exchangeRate3,
              currency: currency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoCurrency extends StatelessWidget {
  const CryptoCurrency({
    Key key,
    @required this.cryptoCurrency,
    @required this.exchangeRate,
    @required this.currency,
  }) : super(key: key);

  final String cryptoCurrency;
  final String exchangeRate;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $exchangeRate $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
