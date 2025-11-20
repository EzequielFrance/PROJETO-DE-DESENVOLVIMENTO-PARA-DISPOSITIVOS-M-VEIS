import 'package:flutter/material.dart';

class TarefaItem extends StatelessWidget {
  final String titulo;
  final bool concluida;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TarefaItem({
    super.key,
    required this.titulo,
    required this.concluida,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: concluida ? Colors.green.shade100 : Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: concluida,
                onChanged: (_) => onToggle(),
              ),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 18,
                  decoration:
                  concluida ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
