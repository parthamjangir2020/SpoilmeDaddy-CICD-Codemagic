
import 'package:active_ecommerce_cms_demo_app/helpers/shimmer_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'photo_provider.dart';
import 'package:go_router/go_router.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({super.key});

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    try {
      await Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String extractSlug(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      final categoryIndex = segments.indexOf('category');
      if (categoryIndex != -1 && categoryIndex + 1 < segments.length) {
        return segments[categoryIndex + 1];
      }
    } catch (e) {
      print('Invalid URL: $e');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return ShimmerHelper().buildBasicShimmer(height: 50);
    }

    if (_hasError) {
      return Center(child: Text('Error loading photos'));
    }

    return Consumer<PhotoProvider>(
      builder: (context, photoProvider, child) {
        if (photoProvider.singleBanner.isEmpty) {
          return Center(child: Text('No photos available.'));
        }

        final photoData = photoProvider.singleBanner[0];
        return GestureDetector(
          onTap: () {
            final slug = extractSlug(photoData.url);
            if (slug.isNotEmpty) {
              context.go('/category/$slug');
            } else {
              print('Raw URL: ${photoData.url}');
            }
          },
          child: Image.network(photoData.photo),
        );
      },
    );
  }
}
