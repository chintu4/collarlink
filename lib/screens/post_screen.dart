import 'package:collarlink/api/api.dart';
import 'package:collarlink/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  PostScreenState createState() {
    return PostScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PostScreenState extends State<PostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController taskName = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final TextEditingController travelPayController = TextEditingController();
  int selectedNumber = 0;
  String selectedLocation = '';
  bool payForTravel = false;
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();
  dynamic picked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creat Post"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: taskName,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              Text("Number of people Required :"),
              DropdownButton<int>(
                value: selectedNumber,
                items: List<DropdownMenuItem<int>>.generate(
                  101,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text('$index'),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedNumber = newValue!;
                  });
                },
              ),
              FlutterLocationPicker(
                initPosition: LatLong(23, 89),
                selectLocationButtonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
                selectLocationButtonText: 'Set Current Location',
                selectLocationButtonLeadingIcon: const Icon(Icons.check),
                initZoom: 11,
                minZoomLevel: 5,
                maxZoomLevel: 16,
                trackMyPosition: true,
                onError: (e) => print(e),
                onPicked: (pickedData) {
                  print(pickedData.latLong.latitude);
                  print(pickedData.latLong.longitude);
                  print(pickedData.address);
                  print(pickedData.addressData['country']);
                },
                onChanged: (pickedData) {
                  print(pickedData.latLong.latitude);
                  print(pickedData.latLong.longitude);
                  print(pickedData.address);
                  print(pickedData.addressData);
                },
              ),
              // Replace with actual Google location picker
              ElevatedButton(
                child: Text("helo"),
                onPressed: () {
                  // Implement location picker here
                },
              ),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Site of Work'),
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              // Replace with actual skill picker
              TextFormField(
                controller: skillController,
                decoration: InputDecoration(labelText: 'Skill Required'),
              ),
              Row(
                children: [
                  Text('Will You Pay For Travel'),
                  Switch(
                    value: payForTravel,
                    onChanged: (value) {
                      setState(() {
                        payForTravel = value;
                      });
                    },
                  ),
                ],
              ),
              // Replace with actual time picker
              ElevatedButton(
                child: Text('Select time'),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );
                  if (selectedDate != null) {
                    // Do something with the selected date
                  }
                },
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit to Firebase
                    AuthService.firestore.collection('tasks').add({
                      'number': selectedNumber,
                      'location': locationController.text,
                      'amount': amountController.text,
                      'skill': skillController.text,
                      'payForTravel': payForTravel,
                      'fromTime': fromTime.format(context),
                      'toTime': toTime.format(context),
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
