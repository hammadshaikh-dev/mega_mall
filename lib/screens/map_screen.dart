import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  // Placeholder location for the Mega Mall (e.g., London, UK)
  // In your actual app, you would use the mall's real coordinates.
  final LatLng megaMallLocation = const LatLng(51.5074, 0.1278); 
  final double initialZoom = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mega Mall Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FlutterMap(
              // Defines the initial camera position and zoom level
              options: MapOptions(
                initialCenter: megaMallLocation,
                initialZoom: initialZoom,
                maxZoom: 18.0,
                minZoom: 3.0,
              ),
              // Map Layers are defined here
              children: [
                // 1. The Map Tiles (OpenStreetMap)
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.mega_mall', // Mandatory for OSM tiles
                  // Removed 'maxCacheAge' to maintain compatibility with older flutter_map versions.
                ),
                
                // 2. The Markers Layer
                MarkerLayer(
                  markers: [
                    Marker(
                      point: megaMallLocation,
                      width: 80,
                      height: 80,
                      // FIX: Changed 'builder' to 'child' to satisfy the requirements 
                      // of older 'flutter_map' package versions.
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40.0,
                          ),
                          Text(
                            'Mega Mall',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                )
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}