import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  final ValueNotifier<String> searchQuery;

  const SearchButton({super.key, required this.searchQuery});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery.value);

    // Atualiza a ValueNotifier quando o usuário digita
    _controller.addListener(() {
      widget.searchQuery.value = _controller.text;
    });

    // Atualiza o controller caso o ValueNotifier seja alterado de fora
    widget.searchQuery.addListener(() {
      if (_controller.text != widget.searchQuery.value) {
        _controller.text = widget.searchQuery.value;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        leading: const Icon(Icons.search),
        hintText: 'Search Anything',
        controller: _controller,
        padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 8.0),
        ),
        backgroundColor: const WidgetStatePropertyAll<Color>(Color(0xFFF0F1F2)),
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
