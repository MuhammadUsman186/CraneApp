import 'package:crane_master/ui/header_form.dart';
import 'package:flutter/material.dart';

class FlyForm extends StatefulWidget {
  const FlyForm({Key key}) : super(key: key);

  @override
  State<FlyForm> createState() => _FlyFormState();
}

class _FlyFormState extends State<FlyForm> {
  final travelerController = TextEditingController();
  final countryDestinatonController = TextEditingController();
  final destinationController = TextEditingController();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return HeaderForm(
      fields: <HeaderFormField>[
        HeaderFormField(
          iconData: Icons.person,
          textEditingController: travelerController,
          title: 'Travelers',
        ),
        HeaderFormField(
          iconData: Icons.place,
          textEditingController: countryDestinatonController,
          title: 'Select Origin',
        ),
        HeaderFormField(
          iconData: Icons.airplanemode_active,
          textEditingController: destinationController,
          title: 'Choose Destination',
        ),
        HeaderFormField(
          iconData: Icons.date_range,
          textEditingController: dateController,
          title: 'Select Dates',
        ),
      ],
    );
  }
}
