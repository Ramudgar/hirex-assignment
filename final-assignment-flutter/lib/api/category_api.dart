import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hirexapp/api/http_services.dart';
import 'package:hirexapp/model/dropdown_category.dart';
import 'package:hirexapp/response/category_response.dart';
import 'package:hirexapp/utils/url.dart';

class CategoryAPI {
  Future<List<DropdownCategory?>> loadCategory() async {
    List<DropdownCategory?> dropdownCategoryList = [];
    Response response;
    var url = baseUrl + categoryUrl;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.get(url);

      if (response.statusCode == 200) {
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(response.data);

        for (var data in categoryResponse.data!) {
          dropdownCategoryList.add(
            DropdownCategory(
              id: data.id,
              name: data.name,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to get category $e');
    }

    return dropdownCategoryList;
  }
}
