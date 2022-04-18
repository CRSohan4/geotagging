import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var city = "Earth";

  _getCurrentLocation() async {
    var lat = 00.000;
    var lng = 00.000;
    await Geolocator.checkPermission()
        .then((value) => {print("Sohan " + value.toString())});
    await Geolocator.isLocationServiceEnabled().then((value) => print(value));
    await Geolocator.requestPermission().then((value) => print(value));
    await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      lng = value.longitude;
    });
    print(lat.toString() + " - " + lng.toString());

    List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng
    );
    Placemark place = placemarks[0];
    print(placemarks.toString());
    print("${place.locality}, ${place.postalCode}, ${place.country}");
    setState(() {
      city = place.locality.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("City: ${city}"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }
}
