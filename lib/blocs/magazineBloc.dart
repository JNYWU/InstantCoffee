import 'dart:async';

import 'package:readr_app/helpers/apiResponse.dart';
import 'package:readr_app/models/magazineList.dart';
import 'package:readr_app/services/magazineService.dart';

class MagazineBloc {
  MagazineServices _magazineServices;

  StreamController _magazineListController;

  StreamSink<ApiResponse<MagazineList>> get magazineListSink =>
      _magazineListController.sink;

  Stream<ApiResponse<MagazineList>> get magazineListStream =>
      _magazineListController.stream;

  MagazineBloc() {
    _magazineServices = MagazineServices();
    _magazineListController = StreamController<ApiResponse<MagazineList>>();
    fetchMagazineList();
  }

  sinkToAdd(ApiResponse<MagazineList> value) {
    if (!_magazineListController.isClosed) {
      magazineListSink.add(value);
    }
  }

  fetchMagazineList() async {
    sinkToAdd(ApiResponse.loading('Fetching Magazine List'));

    try {
      MagazineList magazineList = await _magazineServices.fetchMagazineListByType('weekly');

      sinkToAdd(ApiResponse.completed(magazineList));
    } catch (e) {
      sinkToAdd(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _magazineListController?.close();
  }
}
