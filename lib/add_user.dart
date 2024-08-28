import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_with_webapi/api_handler.dart';
import 'package:flutter_with_webapi/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();

  void addUser() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      final user = User(
          Id: 0,
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          phoneNumber: data['phoneNumber'],
          password: data['password']);
      await apiHandler.addUser(user: user);
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.amber,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: addUser,
        child: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'firstName',
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'lastName',
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'phoneNumber',
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'password'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
