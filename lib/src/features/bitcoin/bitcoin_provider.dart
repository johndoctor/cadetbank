import 'dart:async';
import 'dart:convert';

import 'package:cadetbank/src/network/auth/responses/bitcoin_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BitcoinProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  double _bitcoinUSDPrice = 0;

  bool get isLoading => _isLoading;
  String? get error => _error;
  double get bitcoinUSDPrice => _bitcoinUSDPrice;

  Future<void> getLatestBitcoinPrice() async {
    // This can be refactored to implement a proper dependency injection
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      final dio = Dio();
      final response =
          await dio.get('https://api.coindesk.com/v1/bpi/currentprice.json');
      final bitcoinData = BitcoinModel.fromJson(response.data);
      _bitcoinUSDPrice = bitcoinData.bitcoinUSDPrice;
      _error = null;
    } on Exception catch (exception, stackTrace) {
      _error = AsyncError(exception, stackTrace).toString();
    } on Error catch (localError, _) {
      _error = localError.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
