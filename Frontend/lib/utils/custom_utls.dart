mixin SnackbarMixin {
  void showSnackbar(String? message,
      [Function? completion, Duration duration = const Duration(seconds: 4)]);
}
