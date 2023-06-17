import 'package:currency_converter/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/services.dart';
import '../widgets/widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<void> _fetchCurrencySupportCodes(context) async {
    await Provider.of<CurrencyConverterService>(context,listen: false)
        .fetchCurrencySupportCodesAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchCurrencySupportCodes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
