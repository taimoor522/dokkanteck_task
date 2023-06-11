/// extensions on [String]
extension StringExtensions on String? {
  ///
  /// friendly message from firebase auth exception

  String get errorToPresentableString =>
      this!.replaceAll('-', ' ').replaceFirst(this![0], this![0].toUpperCase());
}
