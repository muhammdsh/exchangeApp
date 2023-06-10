import 'package:exchange/presentation/custom_widgets/text_translation.dart';
import 'package:flutter/material.dart';

class CurrencyHeader extends StatelessWidget {
  const CurrencyHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextTranslation("Currency", style: Theme.of(context).textTheme.titleLarge),
            ),
            Expanded(
                child: TextTranslation("Buy",
                    textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleLarge)),
            Expanded(
                child: TextTranslation("Sell",
                    textAlign: TextAlign.end, style: Theme.of(context).textTheme.titleLarge)),
          ],
        ),
        const Divider()
      ],
    );
  }
}
