import 'package:flutter/material.dart';

class CardDivider extends StatelessWidget {
  const CardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.withValues(alpha: 0.2),
      thickness: 1,
      height: 1,
    );
  }
}
