import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class vuelos extends StatefulWidget {
  vuelos({Key? key}) : super(key: key);

  @override
  State<vuelos> createState() => _vuelosState();
}

class _vuelosState extends State<vuelos> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _disponibilidadController = TextEditingController();
  final TextEditingController _tipoVueloController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();

  final CollectionReference _vuelos =
      FirebaseFirestore.instance.collection('Vuelos');

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
                    controller: _disponibilidadController,
                    decoration: const InputDecoration(labelText: 'Disponibilidad'),
                  ),
                  TextField(
                    controller: _tipoVueloController,
                    decoration: const InputDecoration(labelText: 'Tipo Vuelo'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _codigoController,
                    decoration: const InputDecoration(
                      labelText: 'Código Avión',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _destinoController,
                    decoration: const InputDecoration(
                      labelText: 'Destino',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Crear'),
                    onPressed: () async {
                      final String disponibilidad = _disponibilidadController.text;
                      final String tipo = _tipoVueloController.text;
                      final int? avion = int.tryParse(_codigoController.text);
                      final int? destinoId = int.tryParse(_destinoController.text);
                      final int? id = int.tryParse(_idController.text);
                      if (avion != null && destinoId != null && id != null) {
                        await _vuelos.add({
                          "idVuelo": id,
                          "disponibilidad": disponibilidad,
                          "avion_codigo": avion,
                          "destinos_id_destinos": destinoId,
                          "tipo_vuelo": tipo,
                        });

                        _idController.text = "";
                        _disponibilidadController.text = "";
                        _tipoVueloController.text = "";
                        _codigoController.text = "";
                        _destinoController.text = "";
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
      _idController.text = documentSnapshot['idVuelo'].toString();
      _disponibilidadController.text = documentSnapshot['disponibilidad'].toString();
      _tipoVueloController.text = documentSnapshot['avion_codigo'].toString();
      _codigoController.text = documentSnapshot['destinos_id_destinos'].toString();
      _destinoController.text = documentSnapshot['tipo_vuelo'].toString();
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
                    controller: _disponibilidadController,
                    decoration: const InputDecoration(labelText: 'Disponibilidad'),
                  ),
                  TextField(
                    controller: _tipoVueloController,
                    decoration: const InputDecoration(labelText: 'Tipo Vuelo'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'ID',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _codigoController,
                    decoration: const InputDecoration(
                      labelText: 'Código Avión',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _destinoController,
                    decoration: const InputDecoration(
                      labelText: 'Destino',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                    final String disponibilidad = _disponibilidadController.text;
                      final String tipo = _tipoVueloController.text;
                      final int? avion = int.tryParse(_codigoController.text);
                      final int? destinoId = int.tryParse(_destinoController.text);
                      final int? id = int.tryParse(_idController.text);
                      if (avion != null && destinoId != null && id != null) {
                        await _vuelos.doc(documentSnapshot!.id).update({
                        "idVuelo": id,
                          "disponibilidad": disponibilidad,
                          "avion_codigo": avion,
                          "destinos_id_destinos": destinoId,
                          "tipo_vuelo": tipo,
                        });
                     
                        _idController.text = "";
                        _disponibilidadController.text = "";
                        _tipoVueloController.text = "";
                        _codigoController.text = "";
                        _destinoController.text = "";
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
    await _vuelos.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El vuelo fue eliminado correctamente')));
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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      elevation: 10,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "VUELOS",
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 34, 211, 90), fontWeight: FontWeight.bold),
          ),
          Icon(Icons.list_outlined)
        ]),
      ),
    );
  }

  cuerpoSpot() {
    return StreamBuilder(
      stream: _vuelos.snapshots(),
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
                  title: Text(documentSnapshot['tipo_vuelo'].toString()),
                  subtitle: Text(documentSnapshot['disponibilidad'].toString()),
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