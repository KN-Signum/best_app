import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for character limit
import 'package:best_app/model/annoucmentToDb.dart';
import '../screens/home.dart';
import '../services/api_service.dart';

void showAddAnnouncementDialog(BuildContext context, String? userId) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController abstractController = TextEditingController();
  final TextEditingController fullTextController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController workingTypeController = TextEditingController();
  final TextEditingController levelOfExperienceController =
      TextEditingController();
  final TextEditingController requirementsController = TextEditingController();

  bool isActive = true; // Toggle switch for active/inactive announcement

  // Function to submit the announcement
  void submitAnnouncement(AnnoucmentToDb annoucment) async {
    bool success = await ApiService().addAnnouncement(annoucment);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Announcement has been added!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add announcement.')),
      );
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: size.width * 0.6,
          height: size.height * 0.8,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Announcement',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    counterText: '',
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(25), // Limit to 25 characters
                  ],
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: abstractController,
                  decoration: const InputDecoration(labelText: 'Abstract'),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100), // Limit to 100 characters
                  ],
                  maxLines: 2,
                  minLines: 2,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: fullTextController,
                  decoration: const InputDecoration(labelText: 'Full Text'),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(250), // Limit to 250 characters
                  ],
                  minLines: 4,
                  maxLines: 4,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: tagsController,
                  decoration: const InputDecoration(
                    labelText: 'Tags (separated by commas)',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: workingTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Working Type (FullTime/PartTime)',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: levelOfExperienceController,
                  decoration: const InputDecoration(
                    labelText: 'Level of Experience (Entry/Mid/Senior)',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: requirementsController,
                  decoration: const InputDecoration(
                    labelText: 'Requirements (separated by commas)',
                  ),
                ),
                const SizedBox(height: 5),
                SwitchListTile(
                  title: const Text('Active Announcement'),
                  value: isActive,
                  onChanged: (bool value) {
                    isActive = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Creating AnnoucmentToDb object from form data
                        AnnoucmentToDb newAnnouncement = AnnoucmentToDb(
                          title: titleController.text,
                          abstract: abstractController.text,
                          fullText: fullTextController.text,
                          tags: tagsController.text
                              .split(',')
                              .map((tag) => tag.trim())
                              .toList(),
                          ownerId: userId!, // Pass userId
                          location: locationController.text,
                          workingType: workingTypeController.text,
                          levelOfExperience: levelOfExperienceController.text,
                          requirements: requirementsController.text
                              .split(',')
                              .map((req) => req.trim())
                              .toList(),
                        );

                        // Call submitAnnouncement to send the announcement to the API
                        submitAnnouncement(newAnnouncement);

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Home(userId: userId)),
                        );
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
