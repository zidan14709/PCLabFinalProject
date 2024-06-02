import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'personal_info.dart';
import 'personal_info_provider.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  String name = "";
  String photoUrl = "";
  String bio = "";
  String contactDetails = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Personal Profile",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Name', onChanged: (value) => name = value),
              const SizedBox(height: 16),
              _buildTextFieldWithFilePicker(
                'Photo URL',
                initialValue: photoUrl,
                onChanged: (value) => photoUrl = value,
              ),
              const SizedBox(height: 16),
              _buildTextField('Bio', onChanged: (value) => bio = value, maxLines: 3),
              const SizedBox(height: 16),
              _buildTextField(
                'Contact Details',
                onChanged: (value) => contactDetails = value,
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _savePersonalInfo(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.tealAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSavedInfoList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText,
      {required ValueChanged<String> onChanged, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.tealAccent),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.tealAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.tealAccent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildTextFieldWithFilePicker(String labelText,
      {required ValueChanged<String> onChanged, required String initialValue}) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: initialValue),
            style: const TextStyle(color: Colors.tealAccent),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.tealAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.tealAccent),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.file_upload, color: Colors.tealAccent),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              PlatformFile file = result.files.first;
              setState(() {
                photoUrl = file.path!;
                onChanged(photoUrl);
              });
            }
          },
        ),
      ],
    );
  }

  void _savePersonalInfo(BuildContext context) {
    if (name.isNotEmpty &&
        photoUrl.isNotEmpty &&
        bio.isNotEmpty &&
        contactDetails.isNotEmpty) {
      final personalInfo = PersonalInfo(
        name: name,
        photoUrl: photoUrl,
        bio: bio,
        contactDetails: contactDetails,
      );

      Provider.of<PersonalInfoProvider>(context, listen: false)
          .addPersonalInfo(personalInfo);

      // Reset the text fields after saving
      setState(() {
        name = "";
        photoUrl = "";
        bio = "";
        contactDetails = "";
      });
    } else {
      // Show a snackbar or other feedback for incomplete information
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }

  Widget _buildSavedInfoList(BuildContext context) {
    final personalInfoList =
        Provider.of<PersonalInfoProvider>(context).personalInfoList;

    if (personalInfoList.isEmpty) {
      return Container(); // If there's no saved info, return an empty container
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saved Information:',
          style: TextStyle(
            color: Colors.tealAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200, // Set a fixed height or use constraints
          child: ListView.separated(
            itemCount: personalInfoList.length,
            itemBuilder: (context, index) {
              final info = personalInfoList[index];
              return ListTile(
                title: Text(
                  info.name,
                  style:
                      const TextStyle(color: Colors.tealAccent), // Change text color
                ),
                subtitle: Text(
                  info.contactDetails,
                  style:
                      const TextStyle(color: Colors.tealAccent), // Change text color
                ),
                onTap: () {
                  _showInfoDialog(context, info.toString());
                },
              );
            },
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.tealAccent),
            shrinkWrap:
                true, // Allow the ListView to occupy only the space it needs
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Saved Information',
            style: TextStyle(color: Colors.tealAccent), // Change text color
          ),
          content: Text(
            info,
            style: const TextStyle(color: Colors.tealAccent), // Change text color
          ),
          backgroundColor: Colors.black, // Change dialog box color
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.tealAccent), // Change text color
              ),
            ),
          ],
        );
      },
    );
  }
}
