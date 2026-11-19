import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/chat/format.dart';
import '../../core/media/media.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';

/// Profile photo, or coloured initials for people without one (or whose
/// privacy settings hide it from us).
class Avatar extends ConsumerWidget {
  const Avatar({super.key, required this.name, this.saved = false, this.radius = 24, this.user});
  final String name;
  final bool saved;
  final double radius;
  final User? user;

  static const _palette = [
    Color(0xFF0B6E5F), Color(0xFF8E44AD), Color(0xFFD35400), Color(0xFF2471A3),
    Color(0xFFC0392B), Color(0xFF16A085), Color(0xFF7D6608),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _palette[name.hashCode.abs() % _palette.length];
    final initialsAvatar = CircleAvatar(
      radius: radius,
      backgroundColor: saved ? Theme.of(context).colorScheme.primary : color,
      foregroundColor: Colors.white,
      child: saved ? const Icon(Icons.bookmark) : Text(initials(name), style: TextStyle(fontSize: radius * 0.7)),
    );
    final u = user;
    if (saved || u == null || !u.hasPhoto() || u.photo.mediaId == Int64.ZERO) return initialsAvatar;
    final cache = ref.read(mediaCacheProvider);
    final id = u.photo.mediaId;
    final hit = cache.peek(id, 'thumb_s');
    Widget photo(Uint8List b) => CircleAvatar(radius: radius, backgroundImage: MemoryImage(b));
    if (hit != null) return photo(hit);
    return FutureBuilder<Uint8List>(
      key: ValueKey('avatar-$id'),
      future: cache.get(id, 'thumb_s', OfUser(u.id)),
      builder: (_, s) => s.hasData ? photo(s.data!) : initialsAvatar,
    );
  }
}
