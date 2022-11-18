import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class reservas extends StatefulWidget {
  reservas({Key? key}) : super(key: key);

  @override
  State<reservas> createState() => _reservasState();
}

class _reservasState extends State<reservas> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _vueloController = TextEditingController();

  final CollectionReference _reservas =
      FirebaseFirestore.instance.collection('reservas');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  TextField(
                    controller: _estadoController,
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _vueloController,
                    decoration: const InputDecoration(
                      labelText: 'Vuelo',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Crear'),
                    onPressed: () async {
                      final String estado = _estadoController.text;
                      final int? id = int.tryParse(_idController.text);
                      final int? vuelo = int.tryParse(_vueloController.text);
                      if (vuelo != null && id != null) {
                        await _reservas.add({
                          "estado": estado,
                          "idreserva": id,
                          "idvuelo": vuelo
                        });

                        _estadoController.text = "";
                        _idController.text = "";
                        _vueloController.text = "";
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
//actualizar poducto

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _estadoController.text = documentSnapshot['estado'].toString();
      _idController.text = documentSnapshot['idreserva'].toString();
      _vueloController.text = documentSnapshot['idvuelo'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  TextField(
                    controller: _estadoController,
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _vueloController,
                    decoration: const InputDecoration(
                      labelText: 'Vuelo',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String estado = _estadoController.text;
                      final int? id = int.tryParse(_idController.text);
                      final int? vuelo = int.tryParse(_vueloController.text);
                      if (vuelo != null && id != null) {
                        await _reservas.doc(documentSnapshot!.id).update({
                          "estado": estado,
                          "idreserva": id,
                          "idvuelo": vuelo
                        });
                        _estadoController.text = "";
                        _idController.text = "";
                        _vueloController.text = "";
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

//borrar productos
  Future<void> _delete(String productId) async {
    await _reservas.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Reserva fue eliminado correctamente')));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: barraSpotApp(),
      body: cuerpoSpot(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  barraSpotApp() {
    return AppBar(
      backgroundColor: Colors.blue[50],
      elevation: 10,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "reservas",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.list_outlined)
        ]),
      ),
    );
  }

  cuerpoSpot() {
    return StreamBuilder(
      stream: _reservas.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['idreserva'].toString()),
                  subtitle: Text(documentSnapshot['idvuelo'].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _update(documentSnapshot)),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _delete(documentSnapshot.id)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
