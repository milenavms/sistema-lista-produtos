import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? iconWidget;
  final VoidCallback? onIconPressed;
  final bool showBackButton;
  final String? roteGoBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.iconWidget,
    this.onIconPressed,
    this.showBackButton = false,
    this.roteGoBack
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
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                    Navigator.of(context).pop();
                },
              ),

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
            if (iconWidget != null) iconWidget!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
