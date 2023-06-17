import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Consumer<CurrencyConverterService>(
        builder: (_, currencyConverterService, __) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // currency converter result view
            Container(
              alignment: Alignment.center,
              height: 50,
              child: FutureBuilder(
                future: currencyConverterService.currencyConverterAPI(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return Text(
                      NumberFormat.currency(
                        symbol: currencyConverterService
                            .currencyConverterTemp['to'],
                      ).format(snapshot.data!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Text("Fill the form to convert currency");
                  }
                },
              ),
            ),
            // currency converter form
            const SizedBox(height: 10),
            TextFieldWidget(
              labelText: 'Amount',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) =>
                  currencyConverterService.setCurrencyConverterTemp(
                      value, CurrencyConverterActionEnum.amount),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropDownWidget(
                    items: currencyConverterService.currencySupportCodes,
                    onChanged: (value) =>
                        currencyConverterService.setCurrencyConverterTemp(
                            value?.code, CurrencyConverterActionEnum.from),
                    labelText: 'From',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropDownWidget(
                    items: currencyConverterService.currencySupportCodes,
                    onChanged: (value) =>
                        currencyConverterService.setCurrencyConverterTemp(
                            value?.code, CurrencyConverterActionEnum.to),
                    labelText: 'To',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
