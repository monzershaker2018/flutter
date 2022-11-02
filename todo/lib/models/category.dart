// ignore_for_file: avoid_print, prefer_collection_literals, prefer_typing_uninitialized_variables

class Category {
  var id;
  var name;
  var desc;

  categoryMap() {
    Map mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = desc;
    return mapping;
  }
}
