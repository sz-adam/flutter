import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation; // Választott hely tárolására szolgáló változó
  var _isGettingLocation = false; // Állapotváltozó a hely meghatározás folyamatának nyomon követésére

  void _getCurrentLocation() async {
    Location location = Location(); // Helyszolgáltatás inicializálása

    bool serviceEnabled; // Szolgáltatás engedélyezettségének tárolására szolgáló változó
    PermissionStatus permissionGranted; // Engedély állapotának tárolására szolgáló változó
    LocationData locationData; // Helyadatok tárolására szolgáló változó

    // Ellenőrzi, hogy a helyszolgáltatás engedélyezve van-e
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService(); // Kéri a helyszolgáltatás engedélyezését
      if (!serviceEnabled) {
        return; // Ha a szolgáltatás nincs engedélyezve, visszatér
      }
    }

    // Ellenőrzi, hogy az alkalmazásnak van-e engedélye a hely használatára
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission(); // Kéri a helyhasználati engedélyt
      if (permissionGranted != PermissionStatus.granted) {
        return; // Ha az engedély nincs megadva, visszatér
      }
    }

    setState(() {
      _isGettingLocation = true; // Állapot frissítése, hogy a hely meghatározása folyamatban van
    });

    locationData = await location.getLocation(); // Aktuális helyadatok megszerzése

    setState(() {
      _isGettingLocation = false; // Állapot frissítése, hogy a hely meghatározása befejeződött
    });

    // Az aktuális helyadatok (szélességi és hosszúsági koordináták) kiírása a konzolra
    print(locationData.latitude);
    print(locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // Alapértelmezett tartalom, ha nincs hely kiválasztva
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    // Ha a hely meghatározása folyamatban van, megjeleníti a körbeforgó indikátort
    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
