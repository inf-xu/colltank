class AppRoute {
  const AppRoute._();

  static const home = 'home';
  static const calendar = 'calendar';
  static const profile = 'profile';
  static const detail = 'collectionDetail';
  static const createCollection = 'createCollection';
  static const collectibleDetail = 'collectibleDetail';

  static const homePath = '/home';
  static const calendarPath = '/calendar';
  static const profilePath = '/profile';
  static const detailPath = '/collections/:id';
  static const createCollectionPath = '/collections/create';
  static const collectibleDetailPath = '/collectibles/:id';

  static String detailPathWithId(int id) => '/collections/$id';
  static String collectibleDetailPathWithId(int id) => '/collectibles/$id';
}
