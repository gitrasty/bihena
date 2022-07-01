import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.pressSeeAll,
  }) : super(key: key);
  final String title;
  final VoidCallback pressSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        TextButton(
          onPressed: pressSeeAll,
          child: const Text(
            "بینینی زیاتر",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
