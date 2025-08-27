import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String text;
  final Widget child;

  const InfoRow({
    super.key,
    required this.text,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/star.png',
          width: 22,
          height: 22,
        ),
        
        const SizedBox(width: 6),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
        const SizedBox(width: 6),
        child,
      ],
    );
  }
}
