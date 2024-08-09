import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warm_boys/providers/custom_auth_provider.dart';
import '../../utils/shared_preferences_helper.dart';
import '../../providers/custom_auth_provider.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:warm_boys/utils/recognition.dart';
import 'package:warm_boys/utils/recognizer.dart';

// 회원가입 스크린 3(시니어)
class RegisterSeniorScreen3 extends StatefulWidget {
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  RegisterSeniorScreen3(
      {required this.onNextPage, required this.onPreviousPage});

  @override
  _RegisterSeniorScreen3State createState() => _RegisterSeniorScreen3State();
}

class _RegisterSeniorScreen3State extends State<RegisterSeniorScreen3> {
  String _selectedGender = '남성';
  String? _selectedAge;
  String? _name;
  String? _contact;
  String? _emergencyContact;
  String? _additionalInfo;

  // 얼굴 등록 관련 변수
  late ImagePicker imagePicker;
  File? _image;
  late FaceDetector faceDetector;
  late Recognizer recognizer;
  List<Face> faces = [];
  var image;
  String? _imgEmbd;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();
  TextEditingController _additionalInfoController = TextEditingController();

  List<String> _ageOptions = List.generate(
      56, (index) => '${65 + index}세(${DateTime.now().year - (65 + index)}년생)');

  bool get _isFormValid {
    return _name != null &&
        _name!.isNotEmpty &&
        _selectedAge != null &&
        _contact != null &&
        _contact!.isNotEmpty &&
        _emergencyContact != null &&
        _emergencyContact!.isNotEmpty &&
        _image != null &&
        _imgEmbd != null;
  }

  // 카메라 사진 촬영
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() async {
        _image = File(pickedFile.path);

        // 이미지 회전 처리
        await _fixImageOrientation();

        doFaceDetection();
      });
    }
  }

  // 이미지 회전 처리
  Future<void> _fixImageOrientation() async {
    final bytes = await _image!.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);

    if (originalImage != null) {
      img.Image orientedImage = img.bakeOrientation(originalImage);
      _image = File(_image!.path)
        ..writeAsBytesSync(img.encodeJpg(orientedImage));
    }
  }

  // 갤러리에서 이미지 선택
  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(pickedFile.path);
        doFaceDetection();
      });
    }
  }

  doFaceDetection() async {
    // _image를 File형에서 InputImage형으로 변환
    InputImage inputImage = InputImage.fromFile(_image!);

    // InputImage형으로 변환한 _image를 얼굴 검출기에 넣어 '얼굴들의 각 영역'을 검출함.
    faces = await faceDetector.processImage(inputImage);

    // _image을 Image형으로 가져온 image 변수
    image = await decodeImageFromList(_image!.readAsBytesSync());

    // 얼굴이 여러 개인 경우 알람을 띄움
    if (faces.length > 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지에 여러 얼굴이 포함되어 있습니다.')),
      );
      _image = null;
      return;
    }

    // 인식된 얼굴이 하나인 경우 처리
    if (faces.isNotEmpty) {
      Face face = faces.first;
      final Rect boundingBox = face.boundingBox;
      print("Rect = " + boundingBox.toString());

      // 바운딩 박스가 화면 밖으로 벗어난 상황, 처리 과정
      num left = boundingBox.left < 0 ? 0 : boundingBox.left;
      num top = boundingBox.top < 0 ? 0 : boundingBox.top;
      num right =
          boundingBox.right > image.width ? image.width - 1 : boundingBox.right;
      num bottom = boundingBox.bottom > image.height
          ? image.height - 1
          : boundingBox.bottom;
      num width = right - left;
      num height = bottom - top;

      final bytes = _image!.readAsBytesSync(); // _image Bytes값(Uint8List)를 기록
      img.Image? faceImg = img.decodeImage(bytes!);
      img.Image croppedFace = img.copyCrop(faceImg!,
          x: left.toInt(),
          y: top.toInt(),
          width: width.toInt(),
          height: height.toInt());
      Recognition recognition = recognizer.recognize(croppedFace, boundingBox);
      showFaceRegistrationDialogue(
          Uint8List.fromList(img.encodeBmp(croppedFace)), recognition);
    }
  }

  showFaceRegistrationDialogue(Uint8List croppedFace, Recognition recognition) {
    showDialog(
      context: context,
      builder: (ctx) {
        final customAuthProvider = Provider.of<CustomAuthProvider>(ctx);
        return AlertDialog(
          title: const Text("Face Registration", textAlign: TextAlign.center),
          alignment: Alignment.center,
          content: SizedBox(
            height: 340,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.memory(
                  croppedFace,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      customAuthProvider.setImage(_image);
                      SharedPreferencesHelper.saveData(
                          '_imgEmbd', recognition.embeddings.join(','));
                      this._imgEmbd = recognition.embeddings.join(',');
                      print("saved _imgEmbd: ${_imgEmbd}");
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(200, 40)),
                    child: const Text("완료"))
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadFormData();
    imagePicker = ImagePicker();

    // 얼굴 검출기 초기화
    final options =
        FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);

    // 인식기 초기화
    recognizer = Recognizer();
  }

  Future<void> _loadFormData() async {
    _name = await SharedPreferencesHelper.getByKey('_username');
    _selectedAge = await SharedPreferencesHelper.getByKey('_age');
    _selectedGender = await SharedPreferencesHelper.getByKey('_gender') ?? '남성';
    _contact = await SharedPreferencesHelper.getByKey('_phoneNum');
    _emergencyContact = await SharedPreferencesHelper.getByKey('_phoneNum2');
    _additionalInfo = await SharedPreferencesHelper.getByKey('_addInfo');

    setState(() {
      _nameController.text = _name ?? '';
      _contactController.text = _contact ?? '';
      _emergencyContactController.text = _emergencyContact ?? '';
      _additionalInfoController.text = _additionalInfo ?? '';
    });
  }

  Future<void> _saveFormData() async {
    await SharedPreferencesHelper.saveData('_username', _name ?? '');
    await SharedPreferencesHelper.saveData('_age', _selectedAge ?? '');
    await SharedPreferencesHelper.saveData('_gender', _selectedGender);
    await SharedPreferencesHelper.saveData('_phoneNum', _contact ?? '');
    await SharedPreferencesHelper.saveData(
        '_phoneNum2', _emergencyContact ?? '');
    await SharedPreferencesHelper.saveData('_addInfo', _additionalInfo ?? '');
  }

  void _onFormFieldChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('회원 개인 정보'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onPreviousPage,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '사진을 등록해주세요.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              _image != null
                  ? Center(
                      child: Container(
                      width: 300,
                      height: 300,
                      child: Image.file(_image!),
                    ))
                  : Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300],
                        child: Icon(Icons.photo,
                            size: 100, color: Colors.grey[700]),
                      ),
                    ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 사진 등록 기능 추가
                          _imgFromCamera();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(140, 60),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "사진 촬영",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 106, 106, 106),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 사진 등록 기능 추가
                          _imgFromGallery();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(140, 60),
                        ),
                        child: Icon(
                          Icons.photo_library,
                          size: 32,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "갤러리",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 106, 106, 106),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("이름", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          _name = value;
                          _onFormFieldChanged();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("나이", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    Container(
                      width: 200,
                      child: DropdownButtonFormField<String>(
                        value: _selectedAge,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        hint: Text('나이 선택'),
                        items: _ageOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          _selectedAge = newValue;
                          _onFormFieldChanged();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("성별을 선택해주세요.", style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text("중복 선택 불가",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = '남성';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == '남성'
                                  ? Colors.blue
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // 모서리 곡률 설정
                              ),
                            ),
                            child: Text('남성'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = '여성';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == '여성'
                                  ? Colors.blue
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // 모서리 곡률 설정
                              ),
                            ),
                            child: Text('여성'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("회원님 연락처를 작성해주세요.",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    TextField(
                      controller: _contactController,
                      maxLength: 11,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _contact = value;
                        _onFormFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("비상시 연락 가능한 번호가 있나요?",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Text("필수",
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ],
                    ),
                    TextField(
                      controller: _emergencyContactController,
                      maxLength: 11,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _emergencyContact = value;
                        _onFormFieldChanged();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("메이트가 추가적으로 알아야 할 내용이 있나요?",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text("선택",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _additionalInfoController,
                      maxLines: 3,
                      maxLength: 100,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _additionalInfo = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _isFormValid
              ? () async {
                  await _saveFormData();
                  widget.onNextPage();
                }
              : null,
          child: Text('다음'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}
