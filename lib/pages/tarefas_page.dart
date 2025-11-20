import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TarefasPage extends StatefulWidget {
  final DateTime data;

  const TarefasPage({super.key, required this.data});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  List<Tarefa> tarefas = [];

  void ordenarTarefas() {
    tarefas.sort((a, b) {
      if (a.concluida == b.concluida) {
        return a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase());
      }
      return a.concluida ? 1 : -1;
    });
  }

  void adicionarTarefa() {
    final txt = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nova Tarefa"),
        content: TextField(controller: txt),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tarefas.add(Tarefa(titulo: txt.text));
                ordenarTarefas();
              });
              Navigator.pop(context);
            },
            child: const Text("Adicionar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada =
        "${widget.data.day}/${widget.data.month}/${widget.data.year}";

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),

      backgroundColor: Colors.deepPurple.shade300,

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Dia $dataFormatada",
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (_, i) {
                  final t = tarefas[i];

                  return Card(
                    child: ListTile(
                      title: Text(
                        t.titulo,
                        style: TextStyle(
                          decoration: t.concluida
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                        value: t.concluida,
                        onChanged: (v) {
                          setState(() {
                            t.concluida = v!;
                            ordenarTarefas();
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            tarefas.removeAt(i);
                            ordenarTarefas();
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
