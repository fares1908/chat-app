import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:untitled9/features/individual_page/data/individual_data.dart';

import '../../../core/class/my_services.dart';
import '../../chat/data/models/user_model.dart';
import '../data/model/message_model.dart';

class IndividualPageController extends GetxController {
  late io.Socket socket;
  String? imagePath;
  late TextEditingController msgController;
  ScrollController scrollController=ScrollController();
  IndividualData individualData=IndividualData(Get.find());
  MyServices myServices = Get.find();
  late UserModel userModel;
  List<ChatMessage> chatMessages = [];

  void initSocket() {
    socket = io.io("https://chatapp-socket-ioo.onrender.com", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.onConnect((data) => print('Connected'));

    socket.emit("signIn", {
      "id": myServices.sharedPreferences.getString("id"),
      "targetId": userModel.id.toString(),
    });

    socket.on('message-receive', (data) {
      print(data);
      storeReceivedMessage(data);
      update();
    });
  }

  void storeReceivedMessage(Map<String, dynamic> messageData) {
    chatMessages.add(ChatMessage.fromJson(messageData));
    update();
  }
  void sendMessage(String message, String targetId, String? imagePath) async {
    if (imagePath != null) {
      // إذا كانت هناك صورة، قم برفعها واحصل على رابطها
      String uploadedImagePath = await individualData.uploadImage(imagePath);
      var messageJson = {
        'message': message,
        "sendByMe": myServices.sharedPreferences.getString("id"),
        'time': DateFormat('HH:mm').format(DateTime.now()),
        'targetId': targetId,
        'imagePath': uploadedImagePath, // استخدام رابط الصورة في الرسالة
      };

      // إرسال الرسالة باستخدام Socket.IO
      socket.emit('sendMessage', messageJson);

      // إضافة الرسالة إلى قائمة الرسائل المحلية
      storeSentMessage(messageJson);

      // تحديث واجهة المستخدم
      update();
    } else {
      // إذا لم تكن هناك صورة، قم بإرسال الرسالة كالمعتاد
      var messageJson = {
        'message': message,
        "sendByMe": myServices.sharedPreferences.getString("id"),
        'time': DateFormat('HH:mm').format(DateTime.now()),
        'targetId': targetId,
      };

      // إرسال الرسالة باستخدام Socket.IO
      socket.emit('sendMessage', messageJson);

      // إضافة الرسالة إلى قائمة الرسائل المحلية
      storeSentMessage(messageJson);

      // تحديث واجهة المستخدم
      update();
    }
  }

// إضافة الرسالة إلى قائمة الرسائل المحلية
  void storeSentMessage(Map<String, dynamic> messageData) {
    chatMessages.add(ChatMessage.fromJson(messageData));
  }


  Future<void> openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    _handlePickedImage(image?.path); // Pass the selected image path
  }

  Future<void> openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    _handlePickedImage(image?.path); // Pass the selected image path
  }

  void _handlePickedImage(String? imagePath) {
    if (imagePath != null) {
      this.imagePath = imagePath;
      print('Image path: $imagePath');
      socket.emit('imageSelected', {'path': imagePath});
    }
  }



  @override
  void onInit() {
    super.onInit();
    msgController = TextEditingController();
    userModel = Get.arguments['userModel'];
    initSocket();
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }
}