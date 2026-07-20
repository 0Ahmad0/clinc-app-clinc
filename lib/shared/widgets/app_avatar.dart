import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Circular avatar that loads and caches a remote [imageUrl] via
/// `cached_network_image`, falling back to [fallback] while loading, on error,
/// or when no URL is set — so it degrades gracefully to initials today and
/// shows real photos once the backend supplies URLs.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.size,
    required this.fallback,
    this.imageUrl,
  });

  final double size;
  final Widget fallback;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: url == null || url.isEmpty
            ? fallback
            : CachedNetworkImage(
                imageUrl: url,
                width: size,
                height: size,
                fit: BoxFit.cover,
                placeholder: (_, __) => fallback,
                errorWidget: (_, __, ___) => fallback,
              ),
      ),
    );
  }
}
