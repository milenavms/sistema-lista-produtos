import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  final void Function(String)? onChanged;

  const SearchButton({super.key, this.onChanged});

  @override
  State<SearchButton> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.all(8.0),
       child: SearchBar(
                leading: const Icon(Icons.search),
                hintText: 'Search Anything',
                onChanged: widget.onChanged,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 8.0),
                ),
                backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFF0F1F2)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                elevation: const WidgetStatePropertyAll<double?>(0),
          ),
    );
  }
}

 