import 'dart:async';

import 'package:confeitaria_marketplace/features/confeitaria/view/confeitaria_detail_screen.dart';
import 'package:confeitaria_marketplace/features/confeitaria/view/confeitaria_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../bloc/map_bloc.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final _mapController = Completer<GoogleMapController>();
  static const _pontoInicial = LatLng(-7.11532, -34.861);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confeitarias no Mapa'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 95, 84, 113),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Nova Confeitaria',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfeitariaFormScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pontoInicial,
              zoom: 12,
            ),
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
            markers:
                state.confeitarias.map((confeitaria) {
                  return Marker(
                    markerId: MarkerId(confeitaria.id.toString()),
                    position: LatLng(
                      confeitaria.latitude,
                      confeitaria.longitude,
                    ),
                    infoWindow: InfoWindow(
                      title: confeitaria.nome,
                      snippet: confeitaria.telefone,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ConfeitariaDetailScreen(
                                  confeitaria: confeitaria,
                                ),
                          ),
                        );
                      },
                    ),
                  );
                }).toSet(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }
}
