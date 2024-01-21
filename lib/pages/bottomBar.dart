class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController masonPriceController = TextEditingController();
  final TextEditingController LabourPriceController = TextEditingController();

  int selectedNumber = 0;
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
                  controller: taskNameController,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Number of People Required:"),
                    DropdownButton<int>(
                      value: selectedNumber,
                      items: List.generate(
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
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: DescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  keyboardType: TextInputType.text,
                  minLines: 2,
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Site of Work (Address)',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text("Type of Work"),
                    SizedBox(width: 10),
                    CustomDropdown(
                      items: ['Contract Worker', 'Wage Per Work'],
                      onChanged: (selectedValue) {
                        setState(() {
                          typeWage = selectedValue == 'Wage Per Work';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                if (typeWage)
                  AskInfo(
                    masonPriceController: masonPriceController,
                    labourPriceController: LabourPriceController,
                  ),
                if (!typeWage)
                  TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Total Amount per Head (in Rs.)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      log("${AuthService.currentUser?.email!}");
                      if (_formKey.currentState!.validate()) {
                        // Create a map containing the data to be stored in Firestore
                        Map<String, dynamic> postData = {
                          'taskName': taskNameController.text,
                          'selectedNumber': selectedNumber,
                          'description': DescriptionController.text,
                          'location': locationController.text,
                          'typeOfWork':
                              typeWage ? 'Wage Per Work' : 'Contract Worker',
                          // Add other fields as needed
                          'uid': AuthService.currentUser!.uid,

                          'amount': typeWage ? amountController.text : null,
                          'mason': masonPriceController.text,
                          'labour': LabourPriceController.text,

                          'payForTravel': payForTravel,
                        };

                        try {
                          // Add the data to Firestore
                          // Optionally, you can call your AuthService method here if needed
                          await AuthService.pushPostScreenData(postData);

                          // Navigate to the next screen
                          Navigator.pushNamed(context, '/home');
                        } catch (e) {
                          // Handle any errors that occur during the Firestore operation
                          log('Error adding document to Firestore: $e');
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
