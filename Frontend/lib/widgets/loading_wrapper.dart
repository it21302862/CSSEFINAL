import 'package:csse/providers/loading_provider.dart';
import 'package:csse/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget secondScreen;
  const LoadingWrapper({super.key, required this.secondScreen});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(builder: (context, value, child) {
      return value.isLoading ? const LoadingIndicator() : secondScreen;
    });
  }
}
