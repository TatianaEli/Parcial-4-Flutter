import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class usuarios extends StatefulWidget {
  usuarios({Key? key}) : super(key: key);

  @override
  State<usuarios> createState() => _usuariosState();
}

class _usuariosState extends State<usuarios> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _reservaController = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('Clientes');

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
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'nombre'),
                  ),
                  TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(labelText: 'apellido'),
                  ),
                  TextField(
                    controller: _cedulaController,
                    decoration: const InputDecoration(labelText: 'cedula'),
                  ),
                  TextField(
                    controller: _fechaController,
                    decoration:
                        const InputDecoration(labelText: 'fecha_nacimiento'),
                  ),
                  TextField(
                    controller: _sexoController,
                    decoration: const InputDecoration(labelText: 'sexo (f / m)'),
                  ),
                  TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(labelText: 'usuario'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _tipoController,
                    decoration: const InputDecoration(
                      labelText: 'Tipo (Ejecutivo / Turista)',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _reservaController,
                    decoration: const InputDecoration(
                      labelText: 'Digite un numero de reserva',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Crear'),
                    onPressed: () async {
                      final String nombre = _nombreController.text;
                      final String apellido = _apellidoController.text;
                      final String fecha = _fechaController.text;
                      final String cedula = _cedulaController.text;
                      final String sexo = _sexoController.text;
                      final String usuario = _usuarioController.text;
                      final int? tipo = int.tryParse(_tipoController.text);
                      final int? reserva = int.tryParse(_reservaController.text);
                      if (reserva != null && tipo != null) {
                        await _clientes.add({
                          "nombre": nombre,
                          "apellido": apellido,
                          "fecha_nacimiento": fecha,
                          "cedula": cedula,
                          "sexo": sexo,
                          "tipo": tipo,
                          "usuario": usuario,
                          "reservas_idReservas": reserva
                        });

                        _nombreController.text = "";
                        _apellidoController.text = "";
                        _fechaController.text = "";
                        _cedulaController.text = "";
                        _sexoController.text = "";
                        _usuarioController.text = "";
                        _tipoController.text = "";
                        _reservaController.text = "";
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
      _nombreController.text = documentSnapshot['nombre'].toString();
      _apellidoController.text = documentSnapshot['apellido'].toString();
      _fechaController.text = documentSnapshot['fecha_nacimiento'].toString();
      _cedulaController.text = documentSnapshot['cedula'].toString();
      _sexoController.text = documentSnapshot['sexo'].toString();
      _tipoController.text = documentSnapshot['tipo'].toString();
      _usuarioController.text = documentSnapshot['usuario'].toString();
      _reservaController.text = documentSnapshot['reservas_idReservas'].toString();
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
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                  TextField(
                    controller: _cedulaController,
                    decoration: const InputDecoration(labelText: 'Cédula'),
                  ),
                  TextField(
                    controller: _fechaController,
                    decoration:
                        const InputDecoration(labelText: 'Fecha Nacimiento'),
                  ),
                  TextField(
                    controller: _sexoController,
                    decoration: const InputDecoration(labelText: 'Sexo ( m / f)'),
                  ),
                  TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    controller: _tipoController,
                    decoration: const InputDecoration(
                      labelText: 'Tipo (Ejecutivo / Turista)',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _reservaController,
                    decoration: const InputDecoration(
                      labelText: 'Digite un numero de reserva',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String nombre = _nombreController.text;
                      final String apellido = _apellidoController.text;
                      final String fecha = _fechaController.text;
                      final String cedula = _cedulaController.text;
                      final String sexo = _sexoController.text;
                      final String usuario = _usuarioController.text;
                      final int? tipo = int.tryParse(_tipoController.text);
                      final int? reserva = int.tryParse(_reservaController.text);
                      if (reserva != null && tipo != null) {
                        await _clientes.doc(documentSnapshot!.id).update({
                          "nombre": nombre,
                          "apellido": apellido,
                          "fecha_nacimiento": fecha,
                          "cedula": cedula,
                          "sexo": sexo,
                          "tipo": tipo,
                          "usuario": usuario,
                          "reservas_idReservas": reserva
                        });
                        _nombreController.text = "";
                        _apellidoController.text = "";
                        _fechaController.text = "";
                        _cedulaController.text = "";
                        _sexoController.text = "";
                        _usuarioController.text = "";
                        _tipoController.text = "";
                        _reservaController.text = "";
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
    await _clientes.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El usuario fue eliminado correctamente')));
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
            "USUARIOS",
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
      stream: _clientes.snapshots(),
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
                  title: Text(documentSnapshot['cedula'].toString()),
                  subtitle: Text(documentSnapshot['nombre'].toString() + " " + documentSnapshot['apellido'].toString()),
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
