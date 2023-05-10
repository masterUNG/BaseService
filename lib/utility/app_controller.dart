import 'package:baseservice/models/transection_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;
  RxList<DateTime> startDateTimes = <DateTime>[].obs;
  RxList<DateTime> endDateTimes = <DateTime>[].obs;

  RxList<TransectionModel> transectionModels = <TransectionModel>[].obs;
}
