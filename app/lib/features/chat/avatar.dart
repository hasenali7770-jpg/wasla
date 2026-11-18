import 'package:flutter/material.dart';

import '../../core/chat/format.dart';

/// Initials avatar until profile photos arrive with media (weeks 9–10).
class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.name, this.saved = false, this.radius = 24});
  final String name;
  final bool saved;
  final double radius;

  static const _palette = [
    Color(0xFF0B6E5F), Color(0xFF8E44AD), Color(0xFFD35400), Color(0xFF2471A3),
    Color(0xFFC0392B), Color(0xFF16A085), Color(0xFF7D6608),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _palette[name.hashCode.abs() % _palette.length];
    return CircleAvatar(
      radius: radius,
      backgroundColor: saved ? Theme.of(context).colorScheme.primary : color,
      foregroundColor: Colors.white,
      child: saved ? const Icon(Icons.bookmark) : Text(initials(name), style: TextStyle(fontSize: radius * 0.7)),
    );
  }
}
