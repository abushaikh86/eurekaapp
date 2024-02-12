import 'dart:async';

// import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:eureka/global_helper.dart';
import 'package:eureka/util/constants.dart' as constants;
import 'package:eureka/util/country_state_distict.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OutletForm extends StatefulWidget {
  final bool isEditing;
  Map<String, dynamic>? itemData;
  OutletForm({
    Key? key,
    this.isEditing = false,
    this.itemData,
  }) : super(key: key);

  @override
  _OutletFormState createState() => _OutletFormState();
}

class _OutletFormState extends State<OutletForm> {
  final TextEditingController outletName = TextEditingController();
  final TextEditingController building = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController distrcit = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController route = TextEditingController();
  final TextEditingController beat = TextEditingController();

  String selectedCountry = '0';
  String selectedState = 'Select State';
  String selectedDistrict = '';
  String selectedArea = '0';
  String selectedRoute = '0';
  String selectedBeat = '0';

  final globalHelper = GlobalHelper();
  List<Map<String, dynamic>> areaList = [];
  List<Map<String, dynamic>> routeList = [];
  List<Map<String, dynamic>> beatList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeEditingData();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final response =
          await globalHelper.get_area_route_beat(selectedArea, selectedRoute);
      if (mounted) {
        setState(() {
          areaList = List<Map<String, dynamic>>.from(response['area']);
          routeList = List<Map<String, dynamic>>.from(response['routes']);
          beatList = List<Map<String, dynamic>>.from(response['beats']);
          areaList.insert(0, {
            'area_id': 0,
            'area_name': 'Please select',
            'created_at': null,
            'updated_at': null,
            'deleted_at': null,
          });
          routeList.insert(0, {
            'route_id': 0,
            'route_name': 'Please select',
            'created_at': null,
            'updated_at': null,
            'deleted_at': null,
          });
          beatList.insert(0, {
            'beat_id': 0,
            'beat_name': 'Please select',
            'beat_number': null,
            'created_at': null,
            'updated_at': null,
            'deleted_at': null,
          });
        });
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await Future.delayed(Duration(seconds: constants.delayedTime));
    }
  }

  void _initializeEditingData() {
    if (widget.isEditing && widget.itemData != null) {
      final item = widget.itemData!['outlet'][0];
      final itemAddress = widget.itemData!['outlet_address'][0];

      outletName.text = item['bp_name'].toString();
      building.text = itemAddress['building_no_name'];
      street.text = itemAddress['street_name'];
      landmark.text = itemAddress['landmark'];
      selectedCountry = itemAddress['country'];
      selectedState = itemAddress['state'];
      selectedDistrict = itemAddress['district'];
      city.text = itemAddress['city'];
      pincode.text = itemAddress['pin_code'].toString();
      selectedArea = item['area_id'];
      selectedRoute = item['route_id'];
      selectedBeat = item['beat_id'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing ? Text('Edit Outlet') : Text('Add Outlet'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input Fields
                _buildTextFormField(outletName, 'Outlet', () => {}, null),
                _buildTextFormField(
                    building, 'Building No and Name', () => {}, null),
                _buildTextFormField(street, 'Street Name', () => {}, null),
                _buildTextFormField(landmark, 'Landmark', () => {}, null),

                // Country Dropdown
                _buildDropdownFormField(
                  selectedCountry,
                  CountryStateDistrict.getCountries(),
                  'Country',
                  onChanged: (newValue) {
                    setState(() {
                      selectedCountry = newValue;
                      selectedState = 'Select State';
                    });
                  },
                ),

                _buildStateDropdownFormField(),
                _buildDistrictDropdownFormField(),

                _buildTextFormField(city, 'Name of City', () => {}, null),
                _buildTextFormField(
                    pincode, 'Pin Code', () => {}, TextInputType.number),

                //area dropdown
                DropdownButtonFormField(
                  value: selectedArea,
                  items: areaList.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> option) {
                      return DropdownMenuItem(
                        value: option['area_id'].toString(),
                        child: Text(option['area_name']),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedArea = newValue!;
                      selectedRoute = '0';
                      selectedBeat = '0';
                      initializeData();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Area',
                  ),
                  style: TextStyle(color: Colors.black), // Set text color
                  icon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                  isExpanded: true,
                  validator: (value) {
                    if (value == null || value == '0') {
                      return 'Please select Area';
                    }
                    return null;
                  },
                ),
                //route dropdown
                DropdownButtonFormField(
                  value: selectedRoute,
                  items: routeList.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> option) {
                      return DropdownMenuItem(
                        value: option['route_id'].toString(),
                        child: Text(option['route_name']),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedRoute = newValue!;
                      selectedBeat = '0';
                      initializeData();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Route',
                  ),
                  style: TextStyle(color: Colors.black), // Set text color
                  icon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                  isExpanded: true,
                  validator: (value) {
                    if (value == null || value == '0') {
                      return 'Please select Route';
                    }
                    return null;
                  },
                ),
                //beat dropdown
                DropdownButtonFormField(
                  value: selectedBeat,
                  items: beatList.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> option) {
                      return DropdownMenuItem(
                        value: option['beat_id'].toString(),
                        child: Text(option['beat_name']),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedBeat = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Beat',
                  ),
                  style: TextStyle(color: Colors.black), // Set text color
                  icon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                  isExpanded: true,
                  validator: (value) {
                    if (value == null || value == '0') {
                      return 'Please select Beat';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),
                // Save Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      _handleSaveAction();
                    }
                  },
                  child: Text(widget.isEditing ? 'Save Changes' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText, Function? onChanged,
      [TextInputType? keyboardType, bool readOnly = false]) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged != null ? (_) => onChanged(controller.text) : null,
      keyboardType: keyboardType,
      enabled: !readOnly,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownFormField(
      String value, List<Map<String, dynamic>> items, String labelText,
      {Function(String)? onChanged}) {
    return DropdownButtonFormField(
      value: value,
      items: items.map<DropdownMenuItem<String>>(
        (Map<String, dynamic> option) {
          return DropdownMenuItem(
            value: option['id'].toString(),
            child: Text(option['name']),
          );
        },
      ).toList(),
      onChanged:
          onChanged != null ? (String? newValue) => onChanged(newValue!) : null,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      style: TextStyle(color: Colors.black), // Set text color
      icon: Icon(Icons.arrow_drop_down), // Add dropdown icon
      isExpanded: true,
      validator: (value) {
        if (value == null || value.isEmpty || value == '0') {
          return 'Please select $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildStateDropdownFormField() {
    List<Map<String, dynamic>> states =
        CountryStateDistrict.getStates(int.parse(selectedCountry));

    return _buildDropdownFormField(
      selectedState,
      states,
      'State',
      onChanged: (newValue) {
        setState(() {
          selectedState = newValue;
          List<Map<String, dynamic>> districts =
              CountryStateDistrict.getDistricts(selectedState.toString());
          if (districts.isNotEmpty) {
            selectedDistrict = districts[0]['id'].toString();
          }
        });
      },
    );
  }

  Widget _buildDistrictDropdownFormField() {
    List<Map<String, dynamic>> districts =
        CountryStateDistrict.getDistricts(selectedState.toString());

    return _buildDropdownFormField(
      selectedDistrict,
      districts,
      'District',
      onChanged: (newValue) {
        setState(() {
          selectedDistrict = newValue;
        });
      },
    );
  }

  void _handleSaveAction() async {
    var sharedPref = await SharedPreferences.getInstance();
    var user_id = sharedPref.getInt('user_id');

    // Implement the save action
    var postedData = {
      'salesman': user_id.toString(),
      'outlet_name': outletName.text.toString(),
      'area_id': selectedArea.toString(),
      'route_id': selectedRoute.toString(),
      'beat_id': selectedBeat.toString(),
      'building_no_name': building.text.toString(),
      'street_name': street.text.toString(),
      'landmark': landmark.text.toString(),
      'country': selectedCountry.toString(),
      'state': selectedState.toString(),
      'district': selectedDistrict.toString(),
      'city': city.text.toString(),
      'pin_code': int.parse(pincode.text),
    };

    if (widget.isEditing && widget.itemData != null) {
      final item = widget.itemData!['outlet'][0];
      final itemAddress = widget.itemData!['outlet_address'][0];
      if (item != null && itemAddress != null) {
        postedData['business_partner_id'] = item['business_partner_id'];
        postedData['bussiness_partner_id'] = itemAddress['bussiness_partner_id'];
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          Center(child: CircularProgressIndicator()),
    );

    var response = await globalHelper.update_outlet(postedData);

    if (response['success'] != null) {
      constants.Notification(response['success']);
      Navigator.pop(context);
      Navigator.pop(context);
    } else if (response['error'] != null) {
      constants.Notification(response['error']);
      Navigator.pop(context);
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: OutletForm(),
  ));
}
