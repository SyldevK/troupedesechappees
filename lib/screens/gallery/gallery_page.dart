import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/GalleryItem.dart';
import '../../providers/gallery_provider.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_footer.dart';
import '../../widgets/gallery/custom_flip_card.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  GalleryCategory _activeCategory = GalleryCategory.All;
  int _currentPage = 1;
  static const int _desktopItemsPerPage = 12;
  static const int _mobileItemsPerPage = 6;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GalleryProvider>().loadItems();
    });
  }

  void _changeCategory(GalleryCategory cat) {
    setState(() {
      _activeCategory = cat;
      _currentPage = 1;
    });
  }

  void _goToPage(int page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<GalleryProvider>();

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child:
                prov.loading
                    ? const Center(child: CircularProgressIndicator())
                    : prov.error != null
                    ? Center(
                      child: Text(
                        'Erreur : ${prov.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                    : prov.items.isEmpty
                    ? const Center(child: Text('Aucun média disponible'))
                    : _buildContent(context, prov.items),
          ),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<GalleryItem> allItems) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final perPage = isMobile ? _mobileItemsPerPage : _desktopItemsPerPage;

    final filtered =
        _activeCategory == GalleryCategory.All
            ? allItems
            : allItems.where((i) => i.category == _activeCategory).toList();

    final pageCount = (filtered.length / perPage).ceil();
    final start = (_currentPage - 1) * perPage;
    final end = (start + perPage).clamp(0, filtered.length);
    final pageItems = filtered.sublist(start, end);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Galerie',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Color(0xFF6C3A87), fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Retrouvez les joies, les coups durs, les mots d’émotions à travers cette galerie.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Choix de catégorie
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children:
                GalleryCategory.values.map((cat) {
                  final sel = cat == _activeCategory;
                  return ChoiceChip(
                    label: Text(cat.label),
                    selected: sel,
                    onSelected: (_) => _changeCategory(cat),
                    selectedColor: Color(0xFF6C3A87),
                    backgroundColor: Colors.purple.shade50,
                  );
                }).toList(),
          ),
          const SizedBox(height: 24),

          // Grille avec FlipCard
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 4 / 3,
            ),
            itemCount: pageItems.length,
            itemBuilder: (ctx, i) {
              final item = pageItems[i];

              final base =
                  kIsWeb
                      ? 'http://tie.test'
                      : Platform.isAndroid
                      ? 'http://10.0.2.2:8000'
                      : 'http://localhost';
              final imageUrl =
              item.url.startsWith(RegExp(r'https?://'))
                  ? item.url
                  : '$base/uploads/images/${item.url}';
              print("🖼️ URL image : $imageUrl");
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomFlipCard(
                    front: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        print("🔄 Chargement en cours : $imageUrl");
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print("❌ Erreur image : $error");
                        return const Icon(Icons.broken_image);
                      },
                    ),


                    back: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6C3A87)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Pagination
          if (pageCount > 1)
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF6C3A87),),
                    onPressed:
                        _currentPage > 1
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                  ),
                  for (var p = 1; p <= pageCount; p++)
                    TextButton(
                      onPressed: () => _goToPage(p),
                      child: Text(
                        '$p',
                        style: TextStyle(
                          color:
                              p == _currentPage ? Colors.purple : Colors.black,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFF6C3A87)),
                    onPressed:
                        _currentPage < pageCount
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
