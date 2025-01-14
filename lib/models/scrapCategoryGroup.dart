import 'package:kabadiwala/models/scrapListModel.dart';

class ScrapCategoryGroup {
  String categoryName;
  String categoryIconUrl;
  List<ScrapListModel> scrapItems;

  ScrapCategoryGroup({
    required this.categoryName,
    required this.categoryIconUrl,
    required this.scrapItems,
  });
}
