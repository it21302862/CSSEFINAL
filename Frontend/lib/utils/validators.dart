bool emailValidator(String email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );
  return emailRegex.hasMatch(email);
}
