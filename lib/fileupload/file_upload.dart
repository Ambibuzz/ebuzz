import 'dart:io';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/fileupload/file_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart';

class FileUpload extends StatefulWidget {
  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  bool _uploadDisabled = true;
  FileUploadService _fileUploadService = FileUploadService();
  // ItemApiService _itemApiService = ItemApiService();
  File _file;
  String _videothumb;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    setState(() {
      _videothumb = null;
    });
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _videothumb = null;
      _file = File(pickedFile.path);
      _uploadDisabled = false;
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  Future getVideoFromCamera() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      _file = File(pickedFile.path);
      _videothumb = await _getVideoThumbnail(_file.path);
      _uploadDisabled = false;
      setState(() {});
    } else {
      print('No video selected.');
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _videothumb = null;
      _file = File(pickedFile.path);
      _uploadDisabled = false;
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  Future getVideoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _file = File(pickedFile.path);
      _videothumb = await _getVideoThumbnail(_file.path);
      _uploadDisabled = false;
      setState(() {});
    } else {
      print('No video selected.');
    }
  }

  Future<String> _getVideoThumbnail(String videoPathUrl) async {
    var appDocDir = await getApplicationDocumentsDirectory();
    final folderPath = appDocDir.path;
    String thumb = await Thumbnails.getThumbnail(
        thumbnailFolder: folderPath,
        videoFile: videoPathUrl,
        imageType:
            ThumbFormat.PNG, //this image will store in created folderpath
        quality: 30);
    print(thumb);
    return thumb;
  }


  void fileUpload() async {
    if (_file != null) {
      await _fileUploadService.postFileData(_file);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueAccent,
        title: Text('Pick image and video'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.05,
          ),
          _file == null
              ? Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: blueAccent, width: 2)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 90,
                    child: Icon(
                      Icons.image,
                      color: greyDarkColor,
                      size: 70,
                    ),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 90,
                  child: _videothumb != null
                      ? CircleAvatar(
                          radius: 90,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(File(_videothumb)),
                        )
                      : CircleAvatar(
                          radius: 90,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(_file),
                        ),
                ),
          SizedBox(
            height: displayHeight(context) * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundButton(
                  onPressed: getImageFromCamera,
                  child: Text('Pick Image'),
                  primaryColor: blueAccent,
                  onPrimaryColor: whiteColor),
              RoundButton(
                  onPressed: getVideoFromCamera,
                  child: Text('Pick Video'),
                  primaryColor: blueAccent,
                  onPrimaryColor: whiteColor),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundButton(
                  onPressed: _uploadDisabled ? null : fileUpload,
                  child: Text('Upload'),
                  primaryColor: _uploadDisabled ? greyColor : blueAccent,
                  onPrimaryColor: whiteColor),
              RoundButton(
                  onPressed: () {
                    // _image = null;
                    // _video = null;
                    _file = null;
                    _uploadDisabled = true;
                    setState(() {});
                  },
                  child: Text('Clear'),
                  primaryColor: blueAccent,
                  onPrimaryColor: whiteColor),
            ],
          ),
        ],
      ),
    );
  }
}
