import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/location/selectLocation.dart';
import 'package:kabadiwala/services/api.dart';
import 'package:kabadiwala/utils/colors.dart';

class SearchLocationPage extends StatefulWidget {
  @override
  _SearchLocationPageState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _apiService.getAutocompleteResults(query);
      setState(() {
        _suggestions = results;
      });
    } catch (e) {
      print("Error fetching autocomplete results: $e");
      setState(() {
        _suggestions = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18.sp,
                    ),
                    cursorColor: AppColors.whiteColor,
                    decoration: InputDecoration(
                      hintText: "Search Location",
                      hintStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18.sp,
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                      ),
                     border: InputBorder.none, // No border in any state
      enabledBorder: InputBorder.none, // No border when enabled
      focusedBorder: InputBorder.none, // No border when focused
      errorBorder: InputBorder.none, // No border for error state
      disabledBorder: InputBorder.none, 
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _suggestions = [];
                    });
                  },
                  child: Icon(
                    Icons.close,
                    size: 25.sp,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : _suggestions.isEmpty
              ? Center(
                  child: Text(
                    "Search for a location to select.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _suggestions[index],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      onTap: () {
                         Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SelectLocationPage(location: _suggestions[index]),
      ),
    );
                      },
                    );
                  },
                ),
    );
  }
}
