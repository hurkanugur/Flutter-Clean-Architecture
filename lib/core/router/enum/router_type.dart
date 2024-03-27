enum RouterType {
  home('/', '/'),
  locationSettings('/location-settings', 'location-settings'),
  profileSettings('/profile-settings', 'profile-settings'),
  about('/about', '/about');

  final String absolutePath;

  final String relativePath;

  const RouterType(this.absolutePath, this.relativePath);
}
