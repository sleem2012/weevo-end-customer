import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weevo_end_customer/feature/shipment_details/data/shipment_detail_model.dart';
import 'package:weevo_end_customer/feature/shipment_details/presentation/manager/shipment_detail_provider.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/themes/screen_utility.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../core/utlis/endpoints.dart';
import '../../../../core/utlis/size_config.dart';
import '../../../../core/widgets/action_dialog.dart';


class ShipmentDetailsScreen extends HookConsumerWidget {
  ShipmentDetailsScreen({
    required this.shipmentId,
    Key? key,
  }) : super(key: key);

  final int? shipmentId;
  final AutoDisposeFutureProviderFamily<ShipmentDetailsModel, int> provider =
  FutureProvider.family.autoDispose<ShipmentDetailsModel, int>((ref, id) async {
    return await ref
        .read(getShipmentDetailNotifier.notifier)
        .getShipmentDetail(shipmentId: id); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child:
          ref.watch(provider(shipmentId!)).when(
            loading: () =>
                Center(child: CircularProgressIndicator(
                  color: weevoPrimaryOrangeColor,)),
            error: (e, o) {
              debugPrint(e.toString());
              debugPrint(o.toString());
              return const Text('error');
            },
            data: (e) =>
                ConditionalBuilder(
                  condition: e.message!.contains(
                      "We can't found any shipment with the given tracking number"),
                  builder: (context) {
                    return
                      ActionDialog(
                        content: 'لا يمكننا العثور على أي شحنة برقم التتبع: $shipmentId!',
                        approveAction: 'حسناً',
                        onApproveClick: () {
                          Navigator.pop(context);
                        },
                      );
                  },
                  fallback: (context) =>
                      Scaffold(
                        appBar: AppBar(
                          title: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'شحنة رقم ${e.entity!.id}',
                                  ),
                                ),
                              ),

                            ],
                          ),
                          leading: IconButton(
                              icon: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Colors.black,
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                        ),
                        body: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          child: Column(
                            children: [
                              e.entity!.status ==
                                  'courier-applied-to-shipment' ||
                                  e.entity!.status ==
                                      'merchant-accepted-shipping-offer' ||
                                  e.entity!.status ==
                                      'on-the-way-to-get-shipment-from-merchant' ||
                                  e.entity!.status == 'on-delivery'
                                  ? Container(
                                height: 81,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      color: Colors.black.withOpacity(0.1),
                                    )
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: e.entity!.courier!.photo !=
                                            null &&
                                            e.entity!.courier!.photo!
                                                .isNotEmpty
                                            ?
                                        FancyShimmerImage(
                                          imageUrl:
                                          e.entity!.courier!.photo!
                                              .contains(base_url)
                                              ? e.entity!.courier!.photo!
                                              :
                                          '$base_url${e.entity!
                                              .courier!
                                              .photo}',
                                          errorWidget: Image.asset(
                                            'assets/images/profile_picture.png',
                                          ),
                                        )
                                            : Image.asset(
                                          'assets/images/profile_picture.png',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            '${e.entity!.courier!
                                                .firstName} ${e.entity!
                                                .courier!
                                                .lastName}',
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),

                                          if(e.entity!.courier!
                                              .cachedAverageRating != null)
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating:
                                                  double.parse(
                                                      e.entity!.courier!
                                                          .cachedAverageRating!),
                                                  minRating: 1,
                                                  ignoreGestures: true,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 18.0,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                        Icons.star,
                                                        color: weevoLightYellow,
                                                      ),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  e.entity!.courier!
                                                      .cachedAverageRating!.substring(0,3),
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () async {
                                        await launch(
                                          'tel:${e.entity!.courier!
                                              .phone!}',
                                        );
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFFE9DF),
                                        ),
                                        child: Image.asset(
                                          'assets/images/new_call_icon.png',
                                          color: weevoPrimaryOrangeColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : Container(),
                              e.entity!.status ==
                                  'merchant-accepted-shipping-offer' ||
                                  e.entity!.status ==
                                      'courier-applied-to-shipment' ||
                                  e.entity!.status ==
                                      'on-the-way-to-get-shipment-from-merchant' ||
                                  e.entity!.status == 'on-delivery'
                                  ? const SizedBox(
                                height: 10,
                              )
                                  : Container(),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      color: Colors.black.withOpacity(0.1),
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: FancyShimmerImage(
                                    imageUrl:
                                    e.entity!.products![0].productInfo!.image!,
                                    height: 196,
                                    width: SizeConfig.screenWidth,
                                    boxFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      color: Colors.black.withOpacity(0.1),
                                    )
                                  ],
                                ),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                e.entity!.products![0]
                                                    .productInfo!
                                                    .name!,
                                                style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                strutStyle: const StrutStyle(
                                                  forceStrutHeight: true,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                e.entity!.products![0]
                                                    .productInfo!
                                                    .description!,
                                                style: const TextStyle(
                                                  fontSize: 11.0,
                                                  color: Color(0xff858585),
                                                ),
                                                strutStyle: const StrutStyle(
                                                  forceStrutHeight: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Row(children: [

                                          Row(
                                            children: [

                                              FancyShimmerImage(
                                                imageUrl:
                                                '$base_url${
                                                    e.entity!.products![0]
                                                        .productInfo!.productCategory!
                                                    .image}',
                                                height: 25,
                                                width: 25,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${e.entity!.products![0]
                                                    .productInfo!.productCategory!
                                                    .name}',
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/weevo_weight.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${double.parse(
                                              e.entity!.products![0]
                                                  .productInfo!
                                                  .weight!).toInt()}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          strutStyle: const StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'كيلو',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 7.0,
                                          ),
                                          strutStyle: StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          height: 15,
                                          child: VerticalDivider(
                                            width: 1,
                                            thickness: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          'assets/images/weevo_money.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${double.parse(e.entity!.amount!)
                                              .toInt()}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          strutStyle: const StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'جنية',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 7.0,
                                          ),
                                          strutStyle: StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          height: 15,
                                          child: VerticalDivider(
                                            width: 1,
                                            thickness: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          'assets/images/van_icon.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${double.parse(
                                              e.entity!.agreedShippingCost ??
                                                  e.entity!
                                                      .expectedShippingCost!)
                                              .toInt()}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          strutStyle: const StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          'جنية',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 7.0,
                                          ),
                                          strutStyle: StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          height: 15,
                                          child: VerticalDivider(
                                            width: 1,
                                            thickness: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        e.entity!.paymentMethod == 'cod'
                                            ? Image.asset(
                                            'assets/images/shipment_inside_cod_icon.png',
                                            height: 20.0,
                                            width: 20.0)
                                            : Image.asset(
                                            'assets/images/shipment_inside_online_icon.png',
                                            height: 20.0,
                                            width: 20.0),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        e.entity!.paymentMethod == 'cod'
                                            ? const Text(
                                          'دفع مقدم',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          strutStyle: StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        )
                                            : const Text(
                                          'مدفوع أونلاين',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          strutStyle: StrutStyle(
                                            forceStrutHeight: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 20.0,
                                        spreadRadius: 0.0,
                                        color: Colors.black.withOpacity(0.1),
                                      )
                                    ]),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: weevoPrimaryOrangeColor,
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      5)),),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const Text(
                                                  'المنزل',
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15.0
                                                    ,
                                                    fontWeight: FontWeight
                                                        .bold,
                                                  ),
                                                  strutStyle: StrutStyle(
                                                    forceStrutHeight: true,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: 4),
                                                Row(
                                                  children:  [
                                                    const Text(
                                                      'من - ',
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12.0
                                                        ,
                                                      ),
                                                      strutStyle: StrutStyle(
                                                        forceStrutHeight: true,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${e.entity!
                                                                  .deliveringCityModel!.name} - ${e.entity!
                                                          .deliveringStateModel!.name}',
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12.0
                                                        ,
                                                      ),
                                                      strutStyle: const StrutStyle(
                                                        forceStrutHeight: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                            height: 31,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffF6F6F6),
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(
                                                  (DateTime
                                                      .parse(e.entity!
                                                      .dateToReceiveShipment!)
                                                      .day ==
                                                      DateTime
                                                          .now()
                                                          .day) &&
                                                      (DateTime
                                                          .parse(e.entity!
                                                          .dateToReceiveShipment!)
                                                          .month ==
                                                          DateTime
                                                              .now()
                                                              .month)
                                                      && (DateTime
                                                      .parse(e.entity!
                                                      .dateToReceiveShipment!)
                                                      .year ==
                                                      DateTime
                                                          .now()
                                                          .year)
                                                      ? 'اليوم' :
                                                  (DateTime
                                                      .parse(e.entity!
                                                      .dateToReceiveShipment!)
                                                      .day ==
                                                      DateTime
                                                          .now()
                                                          .day + 1) &&
                                                      (DateTime
                                                          .parse(e.entity!
                                                          .dateToReceiveShipment!)
                                                          .month ==
                                                          DateTime
                                                              .now()
                                                              .month)
                                                      && (DateTime
                                                      .parse(e.entity!
                                                      .dateToReceiveShipment!)
                                                      .year ==
                                                      DateTime
                                                          .now()
                                                          .year)
                                                      ? 'غداً' : (DateTime
                                                      .parse(e.entity!
                                                      .dateToReceiveShipment!)
                                                      .day ==
                                                      DateTime
                                                          .now()
                                                          .day - 1) &&
                                                      (DateTime
                                                          .parse(e.entity!
                                                          .dateToReceiveShipment!)
                                                          .month ==
                                                          DateTime
                                                              .now()
                                                              .month)
                                                      && (DateTime
                                                          .parse(e.entity!
                                                          .dateToReceiveShipment!)
                                                          .year ==
                                                          DateTime
                                                              .now()
                                                              .year)
                                                      ? 'أمس'
                                                      : intl
                                                      .DateFormat(
                                                      'dd MMM yyyy', 'ar-EG')
                                                      .format(
                                                      DateTime.parse(e.entity!
                                                          .dateToReceiveShipment!)),
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight
                                                        .w600,
                                                  ),
                                                  strutStyle: const StrutStyle(
                                                    forceStrutHeight: true,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  intl.DateFormat(
                                                      'hh:mm a', 'ar-EG')
                                                      .format(
                                                      DateTime.parse(e.entity!
                                                          .dateToReceiveShipment!)),
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                  ),
                                                  strutStyle: const StrutStyle(
                                                    forceStrutHeight: true,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],),


                                    const SizedBox(height: 8),
                                    const Divider(
                                      height: 1.0,
                                      thickness: 1.0,
                                      color: Color(0xffE2E2E2),),
                                    const SizedBox(height: 8),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                  color: weevoPrimaryBlueColor,
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      5)),),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  e.entity!
                                                      .clientName!,
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 15.0
                                                    ,
                                                    fontWeight: FontWeight
                                                        .bold,
                                                  ),
                                                  strutStyle: const StrutStyle(
                                                    forceStrutHeight: true,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height: 4),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'إلي - ',
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12.0
                                                        ,
                                                      ),
                                                      strutStyle: StrutStyle(
                                                        forceStrutHeight: true,
                                                      ),
                                                    ),
                                                     Text(
                                                      '${e.entity!
                                                          .receivingCityModel!.name} - ${e.entity!
                                                          .receivingStateModel!.name}',
                                                      maxLines: 2,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12.0
                                                        ,
                                                      ),
                                                      strutStyle: const StrutStyle(
                                                        forceStrutHeight: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                    height: 4),
                                                Text(
                                                  e.entity!.receivingStreet!,
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 12.0
                                                    ,
                                                    color: Color(
                                                        0xffA1A1A1),
                                                  ),
                                                  strutStyle: const StrutStyle(
                                                    forceStrutHeight: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                width: 100,
                                                height: 31,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xffF6F6F6),
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      10),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      (DateTime
                                                          .parse(e.entity!
                                                          .dateToDeliverShipment!)
                                                          .day ==
                                                          DateTime
                                                              .now()
                                                              .day) &&
                                                          (DateTime
                                                              .parse(e.entity!
                                                              .dateToDeliverShipment!)
                                                              .month ==
                                                              DateTime
                                                                  .now()
                                                                  .month)
                                                          && (DateTime
                                                          .parse(e.entity!
                                                          .dateToDeliverShipment!)
                                                          .year ==
                                                          DateTime
                                                              .now()
                                                              .year)
                                                          ? 'اليوم' :
                                                      (DateTime
                                                          .parse(e.entity!
                                                          .dateToDeliverShipment!)
                                                          .day ==
                                                          DateTime
                                                              .now()
                                                              .day + 1) &&
                                                          (DateTime
                                                              .parse(e.entity!
                                                              .dateToDeliverShipment!)
                                                              .month ==
                                                              DateTime
                                                                  .now()
                                                                  .month)
                                                          && (DateTime
                                                          .parse(e.entity!
                                                          .dateToDeliverShipment!)
                                                          .year ==
                                                          DateTime
                                                              .now()
                                                              .year)
                                                          ? 'غداً' : (DateTime
                                                          .parse(e.entity!
                                                          .dateToDeliverShipment!)
                                                          .day ==
                                                          DateTime
                                                              .now()
                                                              .day - 1) &&
                                                          (DateTime
                                                              .parse(e.entity!
                                                              .dateToDeliverShipment!)
                                                              .month ==
                                                              DateTime
                                                                  .now()
                                                                  .month)
                                                          && (DateTime
                                                              .parse(e.entity!
                                                              .dateToDeliverShipment!)
                                                              .year ==
                                                              DateTime
                                                                  .now()
                                                                  .year)
                                                          ? 'أمس'
                                                          : intl
                                                          .DateFormat(
                                                          'dd MMM yyyy',
                                                          'ar-EG')
                                                          .format(
                                                          DateTime.parse(
                                                              e.entity!
                                                                  .dateToDeliverShipment!)),
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight: FontWeight
                                                            .w600,
                                                      ),
                                                      strutStyle: const StrutStyle(
                                                        forceStrutHeight: true,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      intl.DateFormat(
                                                          'hh:mm a', 'ar-EG')
                                                          .format(
                                                          DateTime.parse(
                                                              e.entity!
                                                                  .dateToDeliverShipment!)),
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 10.0,
                                                      ),
                                                      strutStyle: const StrutStyle(
                                                        forceStrutHeight: true,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                            const SizedBox(height: 4),
                                            e.entity!.status ==
                                                'courier-applied-to-shipment' ||
                                                e.entity!.status ==
                                                    'merchant-accepted-shipping-offer' ||
                                                e.entity!.status ==
                                                    'on-the-way-to-get-shipment-from-merchant' ||
                                                e.entity!.status ==
                                                    'on-delivery'
                                                ? Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await launch(
                                                      'tel:${e.entity!
                                                          .clientPhone}',
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: e.entity!
                                                        .paymentMethod ==
                                                        'online' ? 50 : 100,
                                                    padding: const EdgeInsets
                                                        .all(8.0),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffFFE9DF),
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          10),
                                                    ),
                                                    child: Image.asset(
                                                        'assets/images/big_phone_icon.png',
                                                        height: 25.0,
                                                        width: 25.0),
                                                  ),
                                                ),
                                                e.entity!.paymentMethod ==
                                                    'online'
                                                    ? const SizedBox(width: 10,)
                                                    : Container(),
                                                // e.entity!.paymentMethod ==
                                                //     'online' ? GestureDetector(
                                                //   onTap: () async {
                                                //     if (e.entity!
                                                //         .handoverCodeCourierToCustomer ==
                                                //         null &&
                                                //         e.entity!
                                                //             .handoverQrcodeCourierToCustomer ==
                                                //             null) {
                                                //       showDialog(
                                                //           context: context,
                                                //           builder: (context) =>
                                                //               Loading());
                                                //       await trackingProvider
                                                //           .refreshHandoverQrCodeCourierToCustomer(
                                                //           e.entity!.parentId >
                                                //               0
                                                //               ? e.entity!
                                                //               .parentId
                                                //               : e.entity!.id);
                                                //       if (trackingProvider
                                                //           .state ==
                                                //           NetworkState.SUCCESS) {
                                                //         Navigator.pop(context);
                                                //         showDialog(
                                                //           context: context,
                                                //           builder: (context) =>
                                                //               ShareSaveQrCodeDialog(
                                                //                   shipmentId: data
                                                //                       .shipmentById
                                                //                       .parentId > 0
                                                //                       ? data
                                                //                       .shipmentById
                                                //                       .parentId
                                                //                       : data
                                                //                       .shipmentById
                                                //                       .id,
                                                //                   data: trackingProvider
                                                //                       .refreshQrcode),
                                                //         );
                                                //       } else {
                                                //         Navigator.pop(context);
                                                //         showDialog(
                                                //           context: context,
                                                //           builder: (context) =>
                                                //               WalletDialog(
                                                //                 msg:
                                                //                 'حدث خطأ برجاء المحاولة مرة اخري',
                                                //                 onPress: () {
                                                //                   Navigator.pop(
                                                //                       context);
                                                //                 },
                                                //               ),
                                                //         );
                                                //       }
                                                //     }
                                                //     else {
                                                //       log('${e.entity!
                                                //           .handoverQrcodeCourierToCustomer}');
                                                //       log('${e.entity!
                                                //           .handoverCodeCourierToCustomer}');
                                                //       log(e.entity!
                                                //           .handoverQrcodeCourierToCustomer!
                                                //           .split('/')
                                                //           .last);
                                                //       showDialog(
                                                //           context: context,
                                                //           builder: (context) =>
                                                //               ShareSaveQrCodeDialog(
                                                //                   shipmentId: data
                                                //                       .shipmentById
                                                //                       .parentId > 0
                                                //                       ? data
                                                //                       .shipmentById
                                                //                       .parentId
                                                //                       : data
                                                //                       .shipmentById
                                                //                       .id,
                                                //                   data: RefreshQrcode(
                                                //                       filename: data
                                                //                           .shipmentById
                                                //                           .handoverQrcodeCourierToCustomer
                                                //                           .split('/')
                                                //                           .last,
                                                //                       path: data
                                                //                           .shipmentById
                                                //                           .handoverQrcodeCourierToCustomer,
                                                //                       code: int.parse(
                                                //                           data
                                                //                               .shipmentById
                                                //                               .handoverCodeCourierToCustomer))));
                                                //     }
                                                //   },
                                                //   child: Container(
                                                //     height: 30.h,
                                                //     width: 45.w,
                                                //     padding: const EdgeInsets.all(8.0),
                                                //     decoration: BoxDecoration(
                                                //       color: const Color(0xffFFE9DF),
                                                //       borderRadius: BorderRadius
                                                //           .circular(
                                                //           10),
                                                //     ),
                                                //     child: Image.asset(
                                                //       'assets/images/big_qrcode_icon.png',
                                                //     ),
                                                //   ),
                                                // ) : Container()
                                              ],
                                            ) : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                )
            ,
          ),
        ),
      );
  }
}
