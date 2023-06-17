import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/models.dart';
import '../utils/utils.dart';

enum CurrencyConverterActionEnum { from, to, amount }

class CurrencyConverterService with ChangeNotifier {
  // get currency support codes
  List<CurrencyCodeModel> _currencySupportCodes = [];

  List<CurrencyCodeModel> get currencySupportCodes => _currencySupportCodes;

  Future<void> fetchCurrencySupportCodesAPI() async {
    try {
      final Response response = await HTTPRequest.get('/codes');

      if (response.statusCode == 200) {
        Map decodeBody = json.decode(response.body);
        _currencySupportCodes = decodeBody['supported_codes']
            .map<CurrencyCodeModel>((code) => CurrencyCodeModel.fromJson(code))
            .toList();
        notifyListeners();
      } else {
        throw HTTPException(
            message: 'Request Fail', statusCode: response.statusCode);
      }
    } catch (e) {
      throw ServerException();
    }
  }

  // handle currency converter
  final Map _currencyConverterTemp = {};

  Map get currencyConverterTemp => _currencyConverterTemp;

  void setCurrencyConverterTemp(value, CurrencyConverterActionEnum action) {
    if (action == CurrencyConverterActionEnum.from) {
      _currencyConverterTemp['from'] = value;
    } else if (action == CurrencyConverterActionEnum.to) {
      _currencyConverterTemp['to'] = value;
    } else if (action == CurrencyConverterActionEnum.amount) {
      _currencyConverterTemp['amount'] = value;
    }
    notifyListeners();
  }

  Future<double?> currencyConverterAPI() async {
    // check if all the data is set then call api
    if (_currencyConverterTemp['from'] != null &&
        _currencyConverterTemp['to'] != null &&
        _currencyConverterTemp['amount'] != null &&
        _currencyConverterTemp['amount'].isNotEmpty) {
      try {
        final Response response = await HTTPRequest.get(
            '/pair/${_currencyConverterTemp['from']}/${_currencyConverterTemp['to']}/${_currencyConverterTemp['amount']}');
        if (response.statusCode == 200) {
          Map decodeBody = json.decode(response.body);
          return decodeBody['conversion_result']?.toDouble();
        } else {
          throw HTTPException(
              message: 'Request Fail', statusCode: response.statusCode);
        }
      } catch (e) {
        throw ServerException();
      }
    } else {
      return null;
    }
  }
}
