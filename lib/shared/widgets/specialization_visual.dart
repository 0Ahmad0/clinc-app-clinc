import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/utils/app_url.dart';

class SpecializationVisual {
  const SpecializationVisual._();

  static const fallbackIcon = Iconsax.hospital;

  static const Map<String, IconData> iconKeys = {
    'stethoscope': Iconsax.health,
    'heart': Iconsax.heart,
    'heart-pulse': Iconsax.heart,
    'eye': Iconsax.eye,
    'tooth': Iconsax.emoji_normal,
    'skin': Iconsax.health,
    'ear': Iconsax.volume_high,
    'stomach': Iconsax.activity,
    'brain': Iconsax.briefcase,
    'female': Iconsax.user,
    'bone': Iconsax.award,
    'baby-face': Iconsax.emoji_happy,
    'kidney': Iconsax.drop,
    'hospital': Iconsax.hospital,
    'general': Iconsax.health,
    'dermatology': Iconsax.health,
    'cardiology': Iconsax.heart,
    'ophthalmology': Iconsax.eye,
    'orthopedics': Iconsax.award,
    'pediatrics': Iconsax.emoji_happy,
    'dentistry': Iconsax.emoji_normal,
    'lab': Iconsax.microscope,
    'laboratory': Iconsax.microscope,
    'analysis': Iconsax.chart_21,
    'analyses': Iconsax.chart_21,
    'test': Iconsax.microscope,
    'tests': Iconsax.microscope,
    'test-tube': Iconsax.microscope,
    'blood': Iconsax.drop,
    'dna': Iconsax.chart_21,
    'marriage': Iconsax.heart,
    'pre-marriage': Iconsax.heart,
    'hormones': Iconsax.flash_1,
    'vitamins': Iconsax.sun_1,
  };

  static IconData iconData(String? value) {
    final key = value?.trim().toLowerCase();
    if (key == null || key.isEmpty) return fallbackIcon;
    return iconKeys[key] ?? fallbackIcon;
  }

  static bool isImage(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) return false;
    final lower = raw.toLowerCase();
    return lower.startsWith('http://') ||
        lower.startsWith('https://') ||
        lower.startsWith('/storage/') ||
        lower.startsWith('storage/') ||
        lower.contains('/') ||
        lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.svg');
  }

  static String? imageUrl(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty || !isImage(raw)) return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    if (normalized.startsWith('storage/')) {
      return '$baseServSlashLess$normalized';
    }
    return '$storageUrl$normalized';
  }

  static Color color(String? value, Color fallback) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) return fallback;
    final hex = raw.startsWith('#') ? raw.substring(1) : raw;
    final normalized = hex.length == 6 ? 'FF$hex' : hex;
    final parsed = int.tryParse(normalized, radix: 16);
    if (parsed == null) return fallback;
    return Color(parsed);
  }
}

class SpecializationIconView extends StatelessWidget {
  const SpecializationIconView({
    super.key,
    required this.value,
    required this.color,
    required this.size,
  });

  final String? value;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = SpecializationVisual.imageUrl(value);
    if (url != null) {
      return CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        fit: BoxFit.contain,
        placeholder: (_, __) =>
            Icon(SpecializationVisual.fallbackIcon, color: color, size: size),
        errorWidget: (_, __, ___) =>
            Icon(SpecializationVisual.fallbackIcon, color: color, size: size),
      );
    }
    return Icon(SpecializationVisual.iconData(value), color: color, size: size);
  }
}
