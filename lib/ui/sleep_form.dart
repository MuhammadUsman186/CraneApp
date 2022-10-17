import 'package:crane_master/ui/header_form.dart';
import 'package:flutter/material.dart';

class SleepForm extends StatefulWidget {
  const SleepForm({Key key}) : super(key: key);

  @override
  State<SleepForm> createState() => _SleepFormState();
}

class _SleepFormState extends State<SleepForm> {
  final travelerController = TextEditingController();
  final dateController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HeaderForm(
      fields: <HeaderFormField>[
        HeaderFormField(
            iconData: Icons.person,
            textEditingController: travelerController,
            title: 'Travelers'),
        HeaderFormField(
            iconData: Icons.date_range,
            textEditingController: dateController,
            title: 'Select Dates'),
        HeaderFormField(
            iconData: Icons.hotel,
            textEditingController: dateController,
            title: 'Select Location'),
      ],
    );
  }
}
