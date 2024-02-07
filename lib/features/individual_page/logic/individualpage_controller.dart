import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:untitled9/core/class/my_services.dart';
import 'package:untitled9/core/constant/apiLink.dart';
import 'package:untitled9/features/chat/data/models/user_model.dart';

import '../data/model/message_model.dart';

class IndividualPageController extends GetxController {
  late io.Socket socket;
  late TextEditingController msgController;
  MyServices myServices = Get.find();
  late UserModel userModel;
  List<ChatMessage> chatMessages = [];

  void initSocket() {
    socket = io.io(AppLink.server, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.onConnect((data) => print('Connected'));

    // Modify the emit line to include id and targetId
    socket.emit("signIn", {
      "id": myServices.sharedPreferences.getString("id"),
      "targetId": userModel.id , // Replace with the actual target ID if available
    });

    socket.on('message-receive', (data) {
      print(data);
      storeReceivedMessage(data);
      update();
    });
  }

  void storeReceivedMessage(Map<String, dynamic> messageData) {
    chatMessages.add(ChatMessage.fromJson(messageData));
    update(); // Update the UI if needed
  }

  void sendMessage(String message, String targetId) {
    var messageJson = {
      'message': message,
      "sendByMe": myServices.sharedPreferences.getString("id"),
      'time': DateFormat('HH:mm').format(DateTime.now()),
      'targetId': targetId
    };
    socket.emit('sendMessage', messageJson);
  }

  Future<void> openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    _handlePickedImage(image);
  }

  Future<void> openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    _handlePickedImage(image);
  }

  void _handlePickedImage(XFile? image) {
    if (image != null) {
      print('Image path: ${image.path}');
      socket.emit('imageSelected', {'path': image.path});
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
