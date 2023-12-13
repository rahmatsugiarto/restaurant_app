import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

extension JoinCategoryNames on List<Category> {
  String joinCategoryNames() {
    if (isEmpty) return '';

    if (length == 1) {
      return first.name;
    } else {
      return '${map((category) => category.name).join(', ')}, and ${last.name}';
    }
  }
}
