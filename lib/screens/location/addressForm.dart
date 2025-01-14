import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class AddressForm extends StatefulWidget {
  final String address;
  final LatLng location;

  AddressForm({required this.address, required this.location});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _addressController = TextEditingController();
  String? _selectedOption;
  final AppController controller = (Get.isRegistered<AppController>()) 
      ? Get.find<AppController>() 
      : Get.put(AppController());
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_validateForm); // Add a listener for the text field
  }

  void _validateForm() {
    // Enable the button if both conditions are satisfied
    setState(() {
      _isButtonEnabled = _addressController.text.isNotEmpty && _selectedOption != null;
    });
  }

  @override
  void dispose() {
    _addressController.dispose(); // Dispose of the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressParts = widget.address.split(',');
    String street = addressParts.length > 0 ? addressParts[0].trim() : '';
    String subLocality = addressParts.length > 1 ? addressParts[1].trim() : '';
    String locality = addressParts.length > 2 ? addressParts[2].trim() : '';
    String administrativeArea = addressParts.length > 3 ? addressParts[3].trim() : '';
    String postalCode = addressParts.length > 4 ? addressParts[4].trim() : '';
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Location",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyColor,
                  ),
                  textScaler: TextScaler.linear(1.0),
                ),
                SizedBox(height: 8.h),
                Text(
                  "$street, $subLocality, $locality, $postalCode, $administrativeArea",
                  style: TextStyle(fontSize: 14.sp),
                  textScaler: TextScaler.linear(1.0),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 1.0,
                  runSpacing: 4.0,
                  children: [
                    _buildRadioButton('Home'),
                    _buildRadioButton('Shop'),
                    _buildRadioButton('Office'),
                    _buildRadioButton('Mall/Outlet'),
                  ],
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: "Address Line",
                    hintText: "House no./ Flat no./ Apartment/ Society",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                CustomElevatedButton(
                  width: double.maxFinite,
                  height: 50.h,
                  text: "Continue",
                  textSize: 18.sp,
                  buttonColor: _isButtonEnabled
                      ? AppColors.primaryGradient
                      : AppColors.greyGradient,
                  onPressed: _isButtonEnabled
                      ? () async{
                          await controller.createAddress(
                            userId: AppController.userDetails.value.id.toString(),
                            placeType: _selectedOption.toString(),
                            street: _addressController.text,
                            subLocality: subLocality.toString(),
                            city: locality.toString(),
                            state: administrativeArea.toString(),
                            pincode: postalCode.toString(),
                            latitude: widget.location.latitude.toString(),
                            longitude: widget.location.longitude.toString(),
                          );
                        }
                      : (){}, // Disable the button when the form is invalid
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: label,
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value;
              _validateForm(); // Revalidate the form when radio button changes
            });
          },
        ),
        Text(label),
      ],
    );
  }
}
