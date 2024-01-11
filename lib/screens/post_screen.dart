import 'dart:developer';

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
  // Add other controllers as needed

  int selectedNumber = 0;
  String selectedPrice = '';
  bool payForTravel = false;
  String workerType = '';
  bool typeWage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: taskName,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Number of People Required:"),
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
                    // if (workerType == 'mason')
                    //   DropdownButton<String>(
                    //     value: selectedPrice,
                    //     items: <String>[
                    //       'Option 1',
                    //       'Option 2',
                    //       'Option 3',
                    //       'Option 4'
                    //     ].map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //     onChanged: (newPrice) {
                    //       setState(() {
                    //         selectedPrice = newPrice!;
                    //       });
                    //     },
                    //   ),
                  ],
                ),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  keyboardType: TextInputType.number,
                  minLines: 2,
                  maxLines: 4,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Site of Work (Address)',
                  ),
                ),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Total Amount per Head (in Rs.)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    Text("Type of Work"),
                    SizedBox(width: 10),
                    CustomDropdown(
                      items: ['Contract Worker', 'Wage Per Work'],
                      onChanged: (selectedValue) {
                        log('Selected: $selectedValue');
                        if (selectedValue == 'Wage Per Work') {
                          setState(() {
                            typeWage = true;
                          });
                        }
                        if (selectedValue == 'Contract Worker') {
                          setState(() {
                            typeWage = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
                // if (typeWage) PersonInfoForm(),
                if (!typeWage) TextField(minLines: 7, maxLines: 7),
                Row(
                  children: [
                    Text("Worker Type"),
                    SizedBox(width: 20),
                    DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          workerType = newValue!;
                        });
                      },
                      items: <String>['Mason', 'Labour', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
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
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit to Firebase or your backend
                      // Example: Firestore.collection('tasks').add({ ... });
                      // Navigate to the next screen
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
