import 'dart:convert';

import 'package:cadetbank/src/network/auth/responses/bitcoin_model.dart';
import 'package:dio/dio.dart';

abstract class IBitcoinDatasource {
  Future<BitcoinModel> getBitcoinData();
}

class BitcoinRestClient implements IBitcoinDatasource {
  BitcoinRestClient(this.dio);

  final Dio dio;

  @override
  Future<BitcoinModel> getBitcoinData() async {
    final response =
        await dio.get('https://api.coindesk.com/v1/bpi/currentprice.json');
    final model = BitcoinModel.fromJson(response.data);
    return model;
  }
}
