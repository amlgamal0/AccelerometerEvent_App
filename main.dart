//******************************** */
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:projectt/location/map.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AccelerometerDemo(),
    );
  }
}


class AccelerometerDemo extends StatefulWidget {
  const AccelerometerDemo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccelerometerDemoState createState() => _AccelerometerDemoState();
}

class _AccelerometerDemoState extends State<AccelerometerDemo> {
  // bool _isSubscribed = false;
  List<double> _accelerometerValues = [0, 0, 0];
  Position? position;
  // late bool _serviceEnabled;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x.abs() + event.y.abs() + event.z.abs() > 20) {
        // An accident may have occurred
        _accelerometerValues = <double>[
          event.x,
          event.y,
          event.z
        ];
        getLocation();
      }
      setState(() {

      });


    });
  }

  @override
  void dispose() {

    super.dispose();
  }


  void _toggleSubscription() {
    _accelerometerValues.clear();

    setState(() {

    });
  }
  void getLocation()async
  {
    position = await Geolocator.getCurrentPosition();// Do something here, such as calling an emergency contact or displaying a message to the user
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Accelerometer values:'),
            Text(
                position == null? 'not yet ': 'accident:$_accelerometerValues',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Text(
              position == null? ' ': ' Location: ${position!.latitude}, ${position!.longitude}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Time: ${DateFormat('HH:mm:ss').format(DateTime.now())}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _toggleSubscription,
              child: const Text('Reset'),
            ),
            Visibility(
              visible: position == null?false:true,
              child: ElevatedButton(
                onPressed: ()
                {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapScreen(latitude: position!.latitude, longitude: position!.longitude)));
                },
                child: const Text('go to location'),
              ),
            )

          ],
        ),
      ),
    );
  }
}