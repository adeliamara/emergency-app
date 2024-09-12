import 'package:emergency_app/modules/call/police_call.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // Controlador do Google Maps
  GoogleMapController? _controller;

  // Posição inicial no mapa (coordenadas)
  final LatLng _initialLatLng =
      const LatLng(-5.08921, -41.7753); // Example location

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(-5.08921, -41.7753), // São Paulo, Brasil
    zoom: 12,
  );

  // Set for markers and circles
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _addMarker();
    _addCircle();
  }

  // Função para capturar o controlador do mapa
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('police_station'),
          position: _initialLatLng,
          infoWindow: const InfoWindow(
            title: 'Police Station',
            snippet: 'Nearest police station',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

  void _addCircle() {
    setState(() {
      _circles.add(
        Circle(
          circleId: const CircleId('radius'),
          center: _initialLatLng,
          radius: 5000, // 5km radius
          strokeWidth: 2,
          strokeColor: Colors.red,
          fillColor: Colors.red.withOpacity(0.3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true, // Ativar o botão de localização atual
                mapType: MapType.normal, // Tipo de mapa
                markers: _markers,
                circles: _circles,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
                child: const Column(
                  children: [
                    Text('Joao Precisa de Ajuda'),
                    Spacer(),
                    SizedBox(
                      height: 100,
                      child: CallPoliceWidget(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
