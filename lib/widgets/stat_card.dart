import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard(
      {super.key,
      required this.value,
      required this.label,
      required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: color, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
      );
}
