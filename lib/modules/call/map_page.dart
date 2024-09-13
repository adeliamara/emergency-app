import 'package:emergency_app/modules/call/police_call.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  final String lat;
  final String long;
  final String userName;

  const GoogleMapScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.userName,
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // Controlador do Google Maps
  GoogleMapController? _controller;

  // Posição inicial no mapa (coordenadas dinâmicas)
  late final double lat;
  late final double long;

  late final LatLng _initialLatLng;
  late final CameraPosition _initialPosition;

  // Set for markers and circles
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    lat = double.parse(widget.lat);
    long = double.parse(widget.long);
    _initialLatLng = LatLng(lat, long);
    _initialPosition = CameraPosition(
      target: _initialLatLng,
      zoom: 20, // Ajuste o zoom conforme necessário
    );
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
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
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
          radius: 20, // 20m radius
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
      backgroundColor: const Color(0xFFEFF2F9),
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
                height: 230,
                decoration: const BoxDecoration(color: Color(0xFFEFF2F9)),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      '${widget.userName} Precisa de Ajuda',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const SizedBox(
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
