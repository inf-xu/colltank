class AppRoute {
  const AppRoute._();

  static const home = 'home';
  static const calendar = 'calendar';
  static const profile = 'profile';
  static const detail = 'collectionDetail';

  static const homePath = '/home';
  static const calendarPath = '/calendar';
  static const profilePath = '/profile';
  static const detailPath = '/collections/:id';

  static String detailPathWithId(int id) => '/collections/$id';
}
