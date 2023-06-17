class CurrencyCodeModel {
  final String code;
  final String name;

  CurrencyCodeModel({required this.code, required this.name});

  factory CurrencyCodeModel.fromJson(List json) =>
      CurrencyCodeModel(code: json[0], name: json[1]);

  // dropdown filter
  bool currencyCodeFilter(String filter) {
    return code.toLowerCase().contains(filter.toLowerCase()) ||
        name.toLowerCase().contains(filter.toLowerCase());
  }
}
