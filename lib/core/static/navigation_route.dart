enum NavigationRoute {
  mainRoute("/main"),
  homeRoute("/home"),
  searchRoute("/search"),
  favoriteRoute("/favorite"),
  profileRoute("/profile"),
  detailRoute("/detail");

  const NavigationRoute(this.name);
  final String name;
}
