// lib/providers/gallery_provider.dart

import 'package:flutter/material.dart';
import '../models/GalleryItem.dart';
import '../services/gallery_service.dart';

class GalleryProvider with ChangeNotifier {
  List<GalleryItem> _items = [];
  bool _loading = false;
  String? _error;
  GalleryCategory _filter = GalleryCategory.All;

  List<GalleryItem> get items => _items;
  bool get loading => _loading;
  String? get error => _error;
  GalleryCategory get filter => _filter;

  /// Charge les médias depuis l'API et loggue ce qui arrive
  Future<void> loadItems({GalleryCategory? category}) async {
    print('🔄 [GalleryProvider] loadItems(filter=$category)');
    _loading = true;
    _error = null;
    if (category != null) _filter = category;
    notifyListeners();

    try {
      _items = await GalleryService.fetchItems(filter: _filter);
      print('✅ [GalleryProvider] items.length = ${_items.length}');
    } catch (e) {
      _error = e.toString();
      print('❌ [GalleryProvider] error = $_error');
    }

    _loading = false;
    notifyListeners();
  }
}
