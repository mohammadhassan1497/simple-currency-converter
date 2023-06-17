import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class DropDownWidget extends StatelessWidget {
  final List<CurrencyCodeModel> items;
  final String labelText;
  final Function(CurrencyCodeModel?)? onChanged;

  const DropDownWidget(
      {super.key,
      required this.items,
      required this.labelText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!));
    return DropdownSearch<CurrencyCodeModel>(
      popupProps: const PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(hintText: "Search"),
        ),
      ),
      itemAsString: (CurrencyCodeModel currencyCodeModel) =>
          currencyCodeModel.code,
      filterFn: (CurrencyCodeModel currencyCodeModel, filter) =>
          currencyCodeModel.currencyCodeFilter(filter),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: labelText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
