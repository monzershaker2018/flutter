// ignore_for_file: avoid_print, prefer_collection_literals, prefer_typing_uninitialized_variables

class Todo {
  var id;
  var title;
  var desc;
  var date;
  var category;
  var isFinshed;

  categoryMap() {
    Map mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = desc;
    mapping['date'] = date;
    mapping['category'] = category;
    mapping['isFinshed'] = isFinshed;
    return mapping;
  }
}
