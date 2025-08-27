// lib/config/category.dart

import 'package:flutter/material.dart';

/// A category tile’s title, image, and the screen it should launch.
class Category {
  final String title;
  final String assetPath;
  final Widget page;

  const Category({
    required this.title,
    required this.assetPath,
    required this.page,
  });
}
