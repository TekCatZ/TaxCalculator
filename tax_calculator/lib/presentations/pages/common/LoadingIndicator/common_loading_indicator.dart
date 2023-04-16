import 'package:flutter/material.dart';

class CommonLoadingIdicator extends StatelessWidget {
  const CommonLoadingIdicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
