import 'package:flutter/material.dart';
import 'package:plus_technolgies/provider/client_provider.dart';
import 'package:plus_technolgies/screen/client_screen.dart';
import 'package:plus_technolgies/widget/customTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'ADD CLIENT',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const AddScreen(),
    );
  }
}

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();
  late ClientProvider _clientProvider;

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    _clientProvider = Provider.of<ClientProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            height: height * 0.25,
            // color: Colors.yellow,
            // padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/7566-removebg-preview.png'),
          ),
          const SizedBox(height: 25),
          CustomTextFormField(
            label: 'Name',
            controller: nameController,
            validator: (value) => (value == '') ? 'Required' : null,
            maxLength: 100,
          ),
          CustomTextFormField(
            label: 'Phone',
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == '') {
                return 'Required';
              } else if (value!.length < 8) {
                return 'Required minimum 8 digit';
              }
              return null;
            },
          ),
          CustomTextFormField(
            label: 'Address',
            controller: addressController,
            validator: (value) => (value == '') ? 'Required' : null,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                SizedBox(
                  width: width * 0.50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            final result = await _clientProvider.addClient(
                                nameController.text.toString(),
                                phoneController.text.toString(),
                                addressController.text.toString());

                            Toast.show(result.toString(),
                                duration: Toast.lengthLong,
                                gravity: Toast.bottom);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientScreen(),
                                ),
                                (route) => false);
                          } catch (e) {
                            Toast.show('Something went wrong!',
                                duration: Toast.lengthLong,
                                gravity: Toast.bottom);
                          }
                        }
                      },
                      child: _clientProvider.isSubmit
                          ? const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.black),
                            )),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
