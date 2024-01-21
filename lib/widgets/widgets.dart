import 'package:flutter/material.dart';
import 'dart:convert';

class TextFieldWithLabel extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const TextFieldWithLabel({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Text ${this.labelText} "),
            ),
          ),
        ],
      ),
    );
  }
}

//simple info box to display message to user
class infoBox extends StatelessWidget {
  const infoBox({Key? key, required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${this.title}"),
      insetPadding: EdgeInsets.all(8.0),
      actions: [Text("ok")],
    );
  }
}

//take useruser inputs form by showdialog container ok and cancel
//will be used in the profile screen
// class ChangeInput extends StatefulWidget {
//   @override
//   _ChangeInputState createState() => _ChangeInputState();
// }

class ChangeInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    Future<void> editField(String field) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit ${field}'),
          );
        },
      );
    }

    return AlertDialog(
      title: Text('Change Input'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(hintText: 'Enter text'),
          onChanged: (String value) {
            _inputText = value;
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_inputText);
          },
        ),
      ],
    );
  }
}

class TextBox extends StatelessWidget {
  final String title;
  // final String form_data;
  final String sectionName;
  final Function()? onPressed;

  const TextBox(
      {Key ?key,
      required this.title,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.title),
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyDropdownList extends StatefulWidget {
  @override
  _MyDropdownListState createState() => _MyDropdownListState();
}

class _MyDropdownListState extends State<MyDropdownList> {
  final List<String> professions = ['Mason', 'Labour', 'Other'];
  String selectedProfession = 'Mason';
  String otherProfession = '';
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButton<String>(
          value: selectedProfession,
          onChanged: (String? newValue) {
            setState(() {
              selectedProfession = newValue!;
            });
          },
          items: professions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        if (selectedProfession == 'Other')
          TextFormField(
            onChanged: (value) {
              setState(() {
                otherProfession = value;
              });
            },
            decoration: InputDecoration(labelText: 'Other'),
          ),
        if (selectedProfession == 'Mason' || selectedProfession == 'Labour')
          TextFormField(
            onChanged: (value) {
              setState(() {
                price = double.tryParse(value) ?? 0.0;
              });
            },
            decoration: InputDecoration(labelText: 'Price in Rupees'),
            keyboardType: TextInputType.number,
          ),
      ],
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key ?key,});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: <String>['Contract per Earn', 'Work per Wage']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String)? onChanged;

  CustomDropdown({required this.items, this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedItem,
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
          widget.onChanged?.call(newValue!);
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class PersonInfoForm extends StatefulWidget {
  @override
  _PersonInfoFormState createState() => _PersonInfoFormState();
}

class _PersonInfoFormState extends State<PersonInfoForm> {
  String personType = '';
  String gender = '';
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Person Type:'),
        Row(
          children: [
            Radio(
              value: 'Mason',
              groupValue: personType,
              onChanged: (value) {
                setState(() {
                  personType = value.toString();
                });
              },
            ),
            Text('Mason'),
            Radio(
              value: 'Labour',
              groupValue: personType,
              onChanged: (value) {
                setState(() {
                  personType = value.toString();
                });
              },
            ),
            Text('Labour'),
          ],
        ),
        if (personType.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Gender:'),
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
              Text('Enter Price:'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    price = double.tryParse(value) ?? 0.0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter price',
                ),
              ),
            ],
          ),
        ElevatedButton(
          onPressed: () {
            if (personType.isNotEmpty && gender.isNotEmpty) {
              // Return the values in JSON format
              Map<String, dynamic> data = {
                'personType': personType,
                'gender': gender,
                'price': price,
              };
              String jsonData = jsonEncode(data);
              print(jsonData);
            } else {
              // Handle if not all information is provided
              print('Please select both person type and gender.');
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}

class AskInfo extends StatefulWidget {
  final TextEditingController masonPriceController;
  final TextEditingController labourPriceController;

  const AskInfo({
    Key? key,
    required this.masonPriceController,
    required this.labourPriceController,
  }) : super(key: key);

  @override
  State<AskInfo> createState() => AskInfoState();
}

class AskInfoState extends State<AskInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text("Mason :"),
              Expanded(
                child: TextFormField(
                  controller: widget.masonPriceController,
                  decoration: InputDecoration(
                    labelText: 'Price for Mason',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Labour :"),
              Expanded(
                child: TextFormField(
                  controller: widget.labourPriceController,
                  decoration: InputDecoration(
                    labelText: 'Price for Labour',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
