import 'package:flutter/material.dart';

class PokemonSearchBar extends StatelessWidget {
  final Function(String)? onSearch;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const PokemonSearchBar({
    Key? key,
    this.onSearch,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onSearch,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: "Procurar Pókemon...",
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 18,
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );

    //  Container(
    //   height: 40,
    //   width: double.infinity,
    //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(30),
    //     border: Border.all(
    //       color: Colors.grey.shade300,
    //       width: 1.5,
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey.withOpacity(0.2),
    //         blurRadius: 2,
    //         offset: const Offset(0, 1),
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     children: [
    //       const SizedBox(width: 12),
    //       Icon(
    //         Icons.search,
    //         color: Colors.grey.shade500,
    //         size: 28,
    //       ),
    //       const SizedBox(width: 16),
    //       Expanded(
    //         child: TextField(
    //           controller: controller,
    //           focusNode: focusNode,
    //           onChanged: onSearch,
    //           style: const TextStyle(
    //             fontSize: 18,
    //             color: Colors.black87,
    //           ),
    //           decoration: InputDecoration(
    //             hintText: "Procurar Pókemon...",
    //             hintStyle: TextStyle(
    //               color: Colors.grey.shade400,
    //               fontSize: 18,
    //             ),
    //             border: InputBorder.none,
    //             isDense: true,
    //             contentPadding: const EdgeInsets.symmetric(vertical: 8),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
