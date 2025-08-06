import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String statut = 'Standard';
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      statut = doc.data()?['statut'] ?? 'Standard';
    });
  }

  Stream<QuerySnapshot> getTasksStream() {
    final collection = FirebaseFirestore.instance.collection('tasks');
    if (statut == 'Standard') {
      return collection.where('prix', isLessThanOrEqualTo: 100000).snapshots();
    } else {
      return collection.snapshots();
    }
  }

  Future<void> signalerTache(DocumentSnapshot task) async {
    final id = task.id;
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(id)
        .update({'signalé_par': uid, 'signalé_le': DateTime.now()});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tâche signalée pour vérification")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tâches Journalières'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erreur lors du chargement'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;
          if (tasks.isEmpty) {
            return const Center(child: Text('Aucune tâche disponible'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(task['produit'] ?? ''),
                  subtitle: Text('${task['description'] ?? ''}\nPrix: ${task['prix']} FCFA'),
                  trailing: ElevatedButton(
                    onPressed: () => signalerTache(task),
                    child: const Text('Signaler'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}