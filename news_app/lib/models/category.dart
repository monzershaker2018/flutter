class Category {
  // ignore: prefer_typing_uninitialized_variables
  var name;

  Category({this.name});

  List<Category> getCategories() {
    List<Category> categories = <Category>[];
    Category category = Category();
    category.name = "business";
    categories.add(category);
    category = Category();

    category.name = "sports";
    categories.add(category);
    category = Category();

    category.name = "general";
    categories.add(category);
    category = Category();

    category.name = "entertainment";
    categories.add(category);
    category = Category();

    return categories;
  }
}
