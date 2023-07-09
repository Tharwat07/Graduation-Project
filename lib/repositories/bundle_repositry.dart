import 'package:union/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:union/data_model/flash_deal_response.dart';
import 'package:union/helpers/shared_value_helper.dart';
import '../data_model/bundle_response.dart';

class BundleRepository {
  Future<BundleResponse> getBundles() async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/bundles");
    print(url.toString());
    final response =
    await http.get(url,
      headers: {
        "App-Language": app_language.$,
      },
    );
    print(response.body.toString());

    return bundleResponseFromJson(response.body.toString());
  }
}
