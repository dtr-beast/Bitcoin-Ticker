import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const kAPI_KEY = '260962FE-A1D7-4671-8757-F0EADDE97BB6';

const List<String> cryptoCurrencyList = [
  'BTC',
  'ETH',
  'LTC',
];

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static List<DropdownMenuItem<String>> getCoinData() {
    List<DropdownMenuItem<String>> dropDownCurrencyList = [];
    for (String currency in currenciesList) {
      dropDownCurrencyList.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return dropDownCurrencyList;
  }

  static Future<String> getExchangeRate(
      {currency = 'USD', cryptoCurrency = 'BTC'}) async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$currency?apikey=$kAPI_KEY');
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData['rate'].toStringAsFixed(2);
    }
    return null;
  }
}
