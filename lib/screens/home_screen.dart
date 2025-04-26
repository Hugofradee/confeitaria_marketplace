import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:confeitaria_marketplace/main.dart';
import 'package:confeitaria_marketplace/screens/confeitaria_form_screen.dart';
import 'package:confeitaria_marketplace/screens/confeitaria_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  Set<Marker> _marcadores = {};
  LatLng _pontoInicial = LatLng(-7.11532, -34.861); // João Pessoa

  @override
  void initState() {
    super.initState();
    _carregarConfeitariasNoMapa();
  }

  void _carregarConfeitariasNoMapa() {
    final confeitarias = objectbox.confeitariaBox.getAll();

    Set<Marker> novosMarcadores = confeitarias.map((confeitaria) {
      return Marker(
        markerId: MarkerId(confeitaria.id.toString()),
        position: LatLng(confeitaria.latitude, confeitaria.longitude),
        infoWindow: InfoWindow(
          title: confeitaria.nome,
          snippet: confeitaria.telefone,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConfeitariaDetailScreen(confeitaria: confeitaria),
              ),
            );
            _carregarConfeitariasNoMapa(); // Atualiza o mapa ao voltar da tela de detalhes
          },
        ),
      );
    }).toSet();

    setState(() {
      _marcadores = novosMarcadores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confeitarias no Mapa'),
        backgroundColor: const Color.fromARGB(255, 95, 84, 113),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Nova Confeitaria',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfeitariaFormScreen()),
              );
              _carregarConfeitariasNoMapa(); // Recarrega após novo cadastro
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pontoInicial,
          zoom: 12,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: _marcadores,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
