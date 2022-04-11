import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weevo_end_customer/feature/shipment_details/data/shipment_detail_model.dart';

import '../../../../core/utlis/network_utils.dart';

final StateNotifierProvider<GetShipmentDetailNotifier, Object?> getShipmentDetailNotifier =
    StateNotifierProvider<GetShipmentDetailNotifier, Object?>(
  (ref) => GetShipmentDetailNotifier(),
);

class GetShipmentDetailNotifier extends StateNotifier<AsyncValue<ShipmentDetailsModel>> {
  GetShipmentDetailNotifier() : super(const AsyncValue.loading());
  final NetworkUtils _utils = NetworkUtils();

  ShipmentDetailsModel? shipmentDetailsModel;

  Future<ShipmentDetailsModel> getShipmentDetail({ int? shipmentId}) async {
    Response response = await _utils.requstData(
      url: 'shipments/$shipmentId',
      body: {},
      get: true,
    );
    if (response.statusCode == 200) {
      shipmentDetailsModel = ShipmentDetailsModel.fromJson(response.data);

      log('correct get Shipment detail data');
    } else {
      log('error get Shipment detail  data');
    }
    return shipmentDetailsModel!;
  }
}
