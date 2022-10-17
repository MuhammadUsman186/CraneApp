import 'package:crane_master/ui/header_form.dart';
import 'package:flutter/material.dart';

class EatForm extends StatefulWidget {
  const EatForm({Key key}) : super(key: key);

  @override
  State<EatForm> createState() => _EatFormState();
}

class _EatFormState extends State<EatForm> {
  final dinerController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return HeaderForm(
      fields: <HeaderFormField>[
        HeaderFormField(
          iconData: Icons.person,
          textEditingController: dinerController,
          title: 'Diners',
        ),
        HeaderFormField(
          iconData: Icons.date_range,
          textEditingController: dateController,
          title: 'Select Date',
        ),
        HeaderFormField(
          iconData: Icons.access_time,
          textEditingController: timeController,
          title: 'Select Time',
        ),
        HeaderFormField(
          iconData: Icons.restaurant_menu,
          textEditingController: locationController,
          title: 'Select Location',
        ),
      ],
    );
  }
}
