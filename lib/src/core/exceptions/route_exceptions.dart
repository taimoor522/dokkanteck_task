class RouteNotFoundException implements Exception {
  final String? routeName;

  const RouteNotFoundException(this.routeName);

  @override
  String toString() => 'RouteNotFoundException: $routeName';
}
