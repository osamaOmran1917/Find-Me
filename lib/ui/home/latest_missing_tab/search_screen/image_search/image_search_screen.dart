import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../helpers/api.dart';

class ImageSearchScreen extends StatefulWidget {
  @override
  State<ImageSearchScreen> createState() => _ImageSearchScreenState();
}

class _ImageSearchScreenState extends State<ImageSearchScreen> {
  /*String? _image;
  bool _isFaceDateChecked = false,
      _uploadToDB = false;*/
  File? _image;
  bool _isLoading = false;
  String _prediction = '';
  String _imageUrl = '';

  Future _getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future _compareImages() async {
    setState(() {
      _isLoading = true;
      _prediction = '';
      _imageUrl = '';
    });

    var response = await API.compareImages(_image!);
    setState(() {
      _isLoading = false;
      if (response['success']) {
        _prediction = response['data']['prediction'].toString();
        _imageUrl = response['data']['image_url'];
      } else {
        _prediction = 'Failed to compare images';
      }
    });
  }

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.youtube.com/'));

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text('Imagae Search',
                style: TextStyle(color: Colors.white, fontFamily: 'Arabic'))),
        body: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(height * .5)),
          padding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * .05),
          child: WebViewWidget(
            controller: controller,
          ),
        ));
    /*Scaffold(
      appBar: AppBar(
        title: Text('Image Comparison'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: _image == null ? Text('No image selected') : Image.network(_image!.path, width: 200),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getImage,
            child: Text('Select Image'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _compareImages,
            child: Text('Compare Images'),
          ),
          SizedBox(height: 20),
          if (_isLoading)
            CircularProgressIndicator()
          else if (_prediction.isNotEmpty)
            Column(
              children: [
                Text('Prediction: $_prediction'),
                if (_imageUrl.isNotEmpty) Image.network(_imageUrl),
              ],
            ),
        ],
      ),
    )*/
    /*Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery
                .of(context)
                .size
                .width * .05),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .03,
              ),
              _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery
                        .of(context)
                        .size
                        .height * .01),
                child: Image.file(
                  File(_image!),
                  width: MediaQuery
                      .of(context)
                      .size
                      .height * .3,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .3,
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => CircularProgressIndicator(),
                ),
              )
                  : ElevatedButton(
                  onPressed: () {
                    _launchInBrowser(Uri.parse('https://www.facebook.com'));
                    // _showBottomSheet();
                  }, child: Text('أضف صورة')),
              if (_image != null)
                ElevatedButton(onPressed: () => _showBottomSheet(),
                    child: Text('غير الصورة')),
              if (_image != null)
                CheckboxListTile(
                  title: Text("الحصول على بيانات الوجه"),
                  value: _isFaceDateChecked,
                  onChanged: (newValue) {
                    setState(() {
                      _isFaceDateChecked = newValue!;
                    });
                  },
                  controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              if (_image != null)
                CheckboxListTile(
                  title: Text("رفع الصورة لقواعد البيانات"),
                  value: _uploadToDB,
                  onChanged: (newValue) {
                    setState(() {
                      _uploadToDB = newValue!;
                      print(_image);
                    });
                  },
                  controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              if (_image != null)
                ElevatedButton(
                    onPressed: () {
                      //شغل الموديل بقا. خد الصورة كإنبوت و احسب السيميلاريتي بينها و بين كل الصور اللي في الداتا بيز، بعد كدا خد أعلى 3 سيميلاريتي بشرط يكونوا أكبر من أو يساووا 0.5
                    },
                    child: Text('حساب التشابه'))
            ],
          ),
        ),
      ),
    )*/
    ;
  }

/*void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .02,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height * .05),
            children: [
              Text(
                AppLocalizations.of(context)!.pickAPicture,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * .3,
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image path: ${image.path} -- MimeType ${image
                              .mimeType}');
                          setState(() {
                            _image = image.path;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/picture.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * .3,
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/camera.png')),
                ],
              )
            ],
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }*/
}
