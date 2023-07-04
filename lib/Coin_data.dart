import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '8F147BDE-E1C8-4499-A8B1-6BCE6E9C8163';
const url = 'https://rest.coinapi.io/v1/exchangerate';

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
  Future<dynamic> getData(String CoinValue) async {

    Map<String,String> cryptoPrices = {};

    for(String crypto in cryptoList)
      {
        http.Response response =
        await http.get(Uri.parse('$url/$crypto/$CoinValue?apikey=$apiKey'));

        if (response.statusCode == 200) {
          var CoinData = jsonDecode(response.body);
          double Coinrate= CoinData['rate'];
          cryptoPrices[crypto] = Coinrate.toStringAsFixed(0);
          print(cryptoPrices);
        } else {
          print(response.statusCode);
          throw 'problem with the request';
        }
      }

    return cryptoPrices;

  }
}
