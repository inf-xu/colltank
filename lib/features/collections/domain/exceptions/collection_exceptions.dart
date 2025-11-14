class CollectionNameExistsException implements Exception {
  CollectionNameExistsException(this.name);

  final String name;

  @override
  String toString() => 'Collection "$name" 已存在';
}
