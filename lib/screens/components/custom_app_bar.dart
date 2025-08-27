import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget iconWidget;
  final VoidCallback? onIconPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.iconWidget,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = kIsWeb ? 32.0 : 16.0;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white, 
      elevation: 0, 
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child:  Row(
          children: [
            Text(
              title, 
              style: const TextStyle(
                color: Colors.black, 
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            iconWidget
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
