import 'package:flutter/material.dart';

class AvatarPicker extends StatelessWidget {
  final List<String> avatars;
  final String? selectedAvatar;
  final Function(String) onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Choose your fun avatar:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: avatars.map((emoji) {
            final isSelected = selectedAvatar == emoji;
            return GestureDetector(
              onTap: () => onAvatarSelected(emoji),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: isSelected ? Colors.purple : Colors.grey[300],
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
