import 'package:quiz_memberid/core/network/app_network.dart';
import 'package:quiz_memberid/core/topics/data/model/topics._model.dart';

class TopicsNetwork {
  final AppNetwork _network = AppNetwork();

  Future<List<Topics>> getTopicsNetwork() async {
    try {
      var res = await _network.get("topics");
      return List<Topics>.from(res.map((x) => Topics.fromJson(x.data())));
    } catch (e) {
      rethrow;
    }
  }
}
