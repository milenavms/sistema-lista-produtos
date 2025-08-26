import 'package:flutter/material.dart';

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
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white, 
      elevation: 0, 
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              title, 
              style: const TextStyle(
                color: Colors.black, 
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const Spacer(),
          iconWidget
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
