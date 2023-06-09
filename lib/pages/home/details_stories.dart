import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:storys_apps/data/model/list_story.dart';

class DetailStories extends StatefulWidget {
  final ListStory? idStories;

  const DetailStories({
    Key? key,
    this.idStories,
  }) : super(key: key);

  @override
  State<DetailStories> createState() => _DetailStoriesState();
}

class _DetailStoriesState extends State<DetailStories> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  LatLng centerLocation = const LatLng(0.0, 0.0);
  MapType selectedMapType = MapType.normal;
  geo.Placemark? placemark;

  @override
  void initState() {
    super.initState();
    centerLocation =
        LatLng(widget.idStories?.lat ?? 0.0, widget.idStories?.lon ?? 0.0);
    widget.idStories?.lon != null || widget.idStories?.lat != null
        ? infoWindow(widget.idStories?.lat ?? 0.0, widget.idStories?.lon ?? 0.0)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idStories?.name ?? ''),
      ),
      body: _buildBody(data: widget.idStories),
    );
  }

  Widget _buildBody({ListStory? data}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: data?.id ?? '',
            child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    cacheKey: '${data?.photoUrl}',
                    imageUrl: '${data?.photoUrl}',
                    fit: BoxFit.contain,
                    width: 200,
                    height: 200,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    // Optional parameters:
                    cacheManager: CacheManager(
                      Config(
                        'photoUrl-cache',
                        stalePeriod: const Duration(days: 7),
                        maxNrOfCacheObjects: 200,
                      ),
                    ),
                    // maxHeightDiskCache: 100,
                    // maxWidthDiskCache: 100,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 25),
            child: Text(
              '${data?.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              '${data?.description}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              'Location',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.idStories?.lon != null || widget.idStories?.lat != null
              ? Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 400,
                    width: 400,
                    child: GoogleMap(
                      markers: markers,
                      initialCameraPosition: CameraPosition(
                        target: centerLocation,
                        zoom: 18,
                      ),
                      mapType: selectedMapType,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      onMapCreated: (controller) async {
                        setState(() {
                          mapController = controller;
                        });
                      },
                    ),
                  ),
                )
              : const Center(
                  child: Text('Location Not Found'),
                ),
        ],
      ),
    );
  }

  void infoWindow(double latitude, double longitude) async {
    final info = await geo.placemarkFromCoordinates(latitude, longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      placemark = place;
    });

    final marker = Marker(
      markerId: const MarkerId('Dicoding'),
      position: centerLocation,
      infoWindow: InfoWindow(title: street, snippet: address),
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            centerLocation,
            18,
          ),
        );
      },
    );
    markers.add(marker);
  }
}
