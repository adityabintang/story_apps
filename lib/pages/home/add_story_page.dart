import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storys_apps/provider/add_story_provider.dart';
import 'package:storys_apps/provider/location_provider.dart';
import 'package:storys_apps/utils/style.dart';

import '../../widget/button_widget.dart';

class AddStoryPage extends StatefulWidget {
  final Function() onAddAction;
  final Function() onMap;
  final double latitude;
  final double longitude;

  const AddStoryPage({
    Key? key,
    required this.onAddAction,
    required this.onMap,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  final descriptionController = TextEditingController();
  final alamatController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Story'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                context.watch<AddStoryProvider>().imagePath == null
                    ? Image.asset('assets/no_image.png')
                    : _showImage(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan Deskripsi cerita',
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.transparent,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: descriptionController,
                    minLines: 6,
                    maxLines: null,
                    onSaved: (String? val) {
                      descriptionController.text = val ?? '';
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<LocationProvider>(
                  builder: (context, provider, child) {
                    if (provider.selectedLocation != null) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        alamatController.text =
                            provider.selectedLocation.toString();
                      });
                    } else {
                      debugPrint(alamatController.text);
                    }
                    return Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Alamat',
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: Colors.transparent,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location.';
                          }
                          return null;
                        },
                        controller: alamatController,
                        onTap: () {
                          widget.onMap();
                        },
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ButtonWidget(
                    text: 'Add Photo',
                    radius: 8,
                    paddingHorizontal: 15,
                    paddingVertical: 15,
                    width: double.infinity,
                    height: 50,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    onTap: () async {
                      _buildBottomSheetGallery();
                    },
                  ),
                ),
                context.watch<AddStoryProvider>().isUploading
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: secondaryColor,
                      ))
                    : Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: ButtonWidget(
                          text: 'upload',
                          radius: 8,
                          paddingHorizontal: 15,
                          paddingVertical: 15,
                          width: double.infinity,
                          height: 50,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              _onUpload();
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onUpload() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final addStoryProvider = context.read<AddStoryProvider>();

    final imagePath = addStoryProvider.imagePath;
    final imageFile = addStoryProvider.imageFile;
    if (imagePath == null || imageFile == null) return;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();
    final newBytes = await addStoryProvider.compressImage(bytes);

    await addStoryProvider.addStories(
      newBytes,
      fileName,
      descriptionController.text,
      lat: widget.latitude,
      lon: widget.longitude,
    );

    if (addStoryProvider.addStoryResponse != null) {
      addStoryProvider.setImageFile(null);
      addStoryProvider.setImagePath(null);
    }

    scaffoldMessengerState.showSnackBar(
      SnackBar(
        backgroundColor: successColor,
        content: Text(addStoryProvider.message),
      ),
    );
    widget.onAddAction();
  }

  Widget _showImage() {
    final imagePath = context.read<AddStoryProvider>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          );
  }

  Future<void> _buildBottomSheetGallery() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () {
                    debugPrint('Camera');
                    _openCamera(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    debugPrint('Gallery');
                    _openCamera(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _openCamera(ImageSource source) async {
    final provider = context.read<AddStoryProvider>();
    final pickedFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 90,
    );

    debugPrint("pickedFile size: ${File(pickedFile?.path ?? '').lengthSync()}");

    if (pickedFile != null) {
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }
}
