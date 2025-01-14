import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/screens/location/addressForm.dart';
import 'package:kabadiwala/screens/location/searchLocation.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class SelectLocationPage extends StatefulWidget {
  final String? location;

  SelectLocationPage({this.location});

  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
  
  late GoogleMapController _mapController;
  LatLng? _currentLocation;
  String? _currentAddress;
  Marker? _selectedMarker;

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      _setLocationFromAddress(widget.location!);
    } else {
      _getCurrentLocation();
    }
  }

  // Set the location from the provided address
  Future<void> _setLocationFromAddress(String location) async {
    try {
      // Geocode the address to get the LatLng
      List<Location> locations = await locationFromAddress(location);
      print("Location is:${location}");
      if (locations.isNotEmpty) {
        _updateLocation(LatLng(locations.first.latitude, locations.first.longitude));
      }
    } catch (e) {
      print("Error setting location from address: $e");
    }
  }
Future<void> _getCurrentLocation() async {
  try {
    // Request permission and get current position
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Check if position is valid
    if (position != null) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        print("Current Location: $_currentLocation"); // Print current location
        _selectedMarker = Marker(
          markerId: MarkerId("current_location"),
          position: _currentLocation!,
          draggable: true,
          infoWindow: InfoWindow(title: "Selected Location"),
          onDragEnd: (LatLng newPosition) {
            _updateLocation(newPosition);
          },
        );
      });

      _updateAddress(_currentLocation!);

      // Ensure the map controller and location are initialized before animating
      if (_mapController != null && _currentLocation != null) {
        _mapController.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
      }
    }
  } catch (e) {
    print("Error getting location: $e");
  }
}

Future<void> _updateAddress(LatLng position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality},${place.locality},  ${place.administrativeArea},${place.postalCode}";
        print("Current Address: $_currentAddress"); // Print the fetched address
      });
    }
  } catch (e) {
    print("Error fetching address: $e");
  }
}

  void _updateLocation(LatLng newPosition) {
  setState(() {
    // Update the current location
    _currentLocation = newPosition;

    // Check if the selected marker is null, and create a new one if needed
    if (_selectedMarker == null) {
      _selectedMarker = Marker(
        markerId: MarkerId("current_location"),
        position: newPosition,
        draggable: true,
        infoWindow: InfoWindow(title: "Selected Location"),
        onDragEnd: (LatLng newPosition) {
          _updateLocation(newPosition);
        },
      );
    } else {
      // Update the existing marker if it's not null
      _selectedMarker = _selectedMarker!.copyWith(positionParam: newPosition);
    }
  });

  // Update the address based on the new position
  _updateAddress(newPosition);
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Your Location",
                style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchLocationPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.search,
                  size: 25.sp,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    body: Stack(
      children: [
        // Google Map widget
        _currentLocation == null
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentLocation!,
                  zoom: 14.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                markers: _selectedMarker != null
                    ? {_selectedMarker!}
                    : {},
                onTap: (LatLng tappedLocation) {
                  _updateLocation(tappedLocation);
                },
              ),
        // Container to show the current address
        Positioned(
          top: 10.h,
          left: 10.w,
          right: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _currentAddress ?? "Fetching address...",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
               
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 10.w,
          right: 10.w,
          child: CustomElevatedButton(
            width: double.maxFinite,
            height: 50.h,
            text: "Continue",
            textSize: 18.sp,
            buttonColor: AppColors.primaryGradient,
            onPressed: () {
  if (_currentLocation != null && _currentAddress != null) {
    // Show the bottom sheet with address fields
    showModalBottomSheet(
      
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return AddressForm(
          address: _currentAddress!,
          location: _currentLocation!,
        );
      },
    );
  }
},

          ),
        ),
      ],
    ),
  );
}
}
