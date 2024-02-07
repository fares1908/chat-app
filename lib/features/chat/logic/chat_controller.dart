import 'package:get/get.dart';
import '../../../core/class/my_services.dart';
import '../../../core/class/status_request.dart';
import '../../../core/helpers/functions/handling_data.dart';
import '../data/chat_data.dart';
import '../data/models/chat_model.dart';
import '../data/models/user_model.dart';

class ChatController extends GetxController {
  List<ChatItem> chatItems = [];
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  ChatData  chatData = ChatData(Get.find());
  List<UserModel> data = [];
  getUser() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    update();

    var response = await chatData
        .getUser(myServices.sharedPreferences.getString("token")!);

    print("=======================Controller $response");
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "success") {
        List listData = response['data']['users'];
        data.addAll(listData
            .where((user) =>
                user['_id'] != myServices.sharedPreferences.getString("id"))
            .map((e) => UserModel.fromJson(e)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
   goToIndividualChat(){
    // Get.toNamed(AppRouter.individualPage,arguments: );
   }
  @override
  void onInit() {
    super.onInit();
    // Add sample data
    chatItems = List.generate(
      12,
      (index) => ChatItem(
        title: 'Item $index',
        subtitle: 'fares',
        time: '2min ago',
      ),
    );
    getUser();
    print(data);
  }
}
