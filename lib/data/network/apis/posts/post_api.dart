import 'dart:async';

import 'package:base_https/base_https.dart';
import 'package:flutter/material.dart';

import '../../../../models/post/post_list.dart';
import '../../constants/endpoints.dart';

class PostApi {

  /// Returns list of post in response
  Future<PostList> getPosts() async {
    try {
      final params = <String, dynamic>{};
      final res = await HttpHelper.requestApi(Endpoints.getPosts, params, HttpMethod.get, false);
      return PostList.fromJson(res.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

}
