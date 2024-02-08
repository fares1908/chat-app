import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/class/my_services.dart';
import '../../chat/data/models/user_model.dart';
import '../data/model/message_model.dart';

class IndividualPageController extends GetxController {
  late io.Socket socket;
  late TextEditingController msgController;
  ScrollController scrollController=ScrollController();
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

  void sendMessage(String message, String targetId) {
    var messageJson = {
      'message': message,
      "sendByMe": myServices.sharedPreferences.getString("id"),
      'time': DateFormat('HH:mm').format(DateTime.now()),
      'targetId': targetId,
    };
    chatMessages.add(ChatMessage.fromJson(messageJson));
    socket.emit('sendMessage', messageJson);// Add sent message to the list
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve:Curves.easeOut);
    update();
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
