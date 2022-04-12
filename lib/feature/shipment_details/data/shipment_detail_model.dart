class ShipmentDetailsModel {
  String? message;
  Entity? entity;

  ShipmentDetailsModel({this.message, this.entity});

  ShipmentDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    entity =
    json['entity'] != null ? Entity.fromJson(json['entity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (entity != null) {
      data['entity'] = entity!.toJson();
    }
    return data;
  }
}

class Entity {
  int? id;
  int? parentId;
  String? receivingState;
  String? receivingCity;
  String? receivingStreet;
  String? receivingLandmark;
  String? receivingBuildingNumber;
  String? receivingFloor;
  String? receivingApartment;
  String? receivingLat;
  String? receivingLng;
  String? dateToReceiveShipment;
  String? deliveringState;
  String? deliveringCity;
  String? deliveringStreet;
  String? deliveringLandmark;
  String? deliveringBuildingNumber;
  String? deliveringFloor;
  String? deliveringApartment;
  String? deliveringLat;
  String? deliveringLng;
  String? dateToDeliverShipment;
  String? clientName;
  String? clientPhone;
  String? notes;
  String? paymentMethod;
  String? amount;
  String? expectedShippingCost;
  String? agreedShippingCost;
  int? merchantId;
  int? courierId;
  String? status;
  String? handoverCodeCourierToMerchant;
  String? handoverQrcodeCourierToMerchant;
  String? handoverCodeMerchantToCourier;
  String? handoverQrcodeMerchantToCourier;
  String? handoverCodeCourierToCustomer;
  String? handoverQrcodeCourierToCustomer;
  int? isOfferBased;
  int? closed;
  String? closedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ReceivingStateModel? receivingStateModel;
  ReceivingCityModel? receivingCityModel;
  ReceivingStateModel? deliveringStateModel;
  ReceivingCityModel? deliveringCityModel;
  List<Products>? products;
  Merchant? merchant;
  Courier? courier;

  Entity(
      {this.id,
        this.parentId,
        this.receivingState,
        this.receivingCity,
        this.receivingStreet,
        this.receivingLandmark,
        this.receivingBuildingNumber,
        this.receivingFloor,
        this.receivingApartment,
        this.receivingLat,
        this.receivingLng,
        this.dateToReceiveShipment,
        this.deliveringState,
        this.deliveringCity,
        this.deliveringStreet,
        this.deliveringLandmark,
        this.deliveringBuildingNumber,
        this.deliveringFloor,
        this.deliveringApartment,
        this.deliveringLat,
        this.deliveringLng,
        this.dateToDeliverShipment,
        this.clientName,
        this.clientPhone,
        this.notes,
        this.paymentMethod,
        this.amount,
        this.expectedShippingCost,
        this.agreedShippingCost,
        this.merchantId,
        this.courierId,
        this.status,
        this.handoverCodeCourierToMerchant,
        this.handoverQrcodeCourierToMerchant,
        this.handoverCodeMerchantToCourier,
        this.handoverQrcodeMerchantToCourier,
        this.handoverCodeCourierToCustomer,
        this.handoverQrcodeCourierToCustomer,
        this.isOfferBased,
        this.closed,
        this.closedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.receivingStateModel,
        this.receivingCityModel,
        this.deliveringStateModel,
        this.deliveringCityModel,
        this.products,
        this.merchant,
        this.courier});

  Entity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    receivingState = json['receiving_state'];
    receivingCity = json['receiving_city'];
    receivingStreet = json['receiving_street'];
    receivingLandmark = json['receiving_landmark'];
    receivingBuildingNumber = json['receiving_building_number'];
    receivingFloor = json['receiving_floor'];
    receivingApartment = json['receiving_apartment'];
    receivingLat = json['receiving_lat'];
    receivingLng = json['receiving_lng'];
    dateToReceiveShipment = json['date_to_receive_shipment'];
    deliveringState = json['delivering_state'];
    deliveringCity = json['delivering_city'];
    deliveringStreet = json['delivering_street'];
    deliveringLandmark = json['delivering_landmark'];
    deliveringBuildingNumber = json['delivering_building_number'];
    deliveringFloor = json['delivering_floor'];
    deliveringApartment = json['delivering_apartment'];
    deliveringLat = json['delivering_lat'];
    deliveringLng = json['delivering_lng'];
    dateToDeliverShipment = json['date_to_deliver_shipment'];
    clientName = json['client_name'];
    clientPhone = json['client_phone'];
    notes = json['notes'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    expectedShippingCost = json['expected_shipping_cost'];
    agreedShippingCost = json['agreed_shipping_cost'];
    merchantId = json['merchant_id'];
    courierId = json['courier_id'];
    status = json['status'];
    handoverCodeCourierToMerchant = json['handover_code_courier_to_merchant'];
    handoverQrcodeCourierToMerchant =
    json['handover_qrcode_courier_to_merchant'];
    handoverCodeMerchantToCourier = json['handover_code_merchant_to_courier'];
    handoverQrcodeMerchantToCourier =
    json['handover_qrcode_merchant_to_courier'];
    handoverCodeCourierToCustomer = json['handover_code_courier_to_customer'];
    handoverQrcodeCourierToCustomer =
    json['handover_qrcode_courier_to_customer'];
    isOfferBased = json['is_offer_based'];
    closed = json['closed'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    receivingStateModel = json['receiving_state_model'] != null
        ? ReceivingStateModel.fromJson(json['receiving_state_model'])
        : null;
    receivingCityModel = json['receiving_city_model'] != null
        ? ReceivingCityModel.fromJson(json['receiving_city_model'])
        : null;
    deliveringStateModel = json['delivering_state_model'] != null
        ? ReceivingStateModel.fromJson(json['delivering_state_model'])
        : null;
    deliveringCityModel = json['delivering_city_model'] != null
        ? ReceivingCityModel.fromJson(json['delivering_city_model'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    merchant = json['merchant'] != null
        ? Merchant.fromJson(json['merchant'])
        : null;
    courier =
    json['courier'] != null ? Courier.fromJson(json['courier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['receiving_state'] = receivingState;
    data['receiving_city'] = receivingCity;
    data['receiving_street'] = receivingStreet;
    data['receiving_landmark'] = receivingLandmark;
    data['receiving_building_number'] = receivingBuildingNumber;
    data['receiving_floor'] = receivingFloor;
    data['receiving_apartment'] = receivingApartment;
    data['receiving_lat'] = receivingLat;
    data['receiving_lng'] = receivingLng;
    data['date_to_receive_shipment'] = dateToReceiveShipment;
    data['delivering_state'] = deliveringState;
    data['delivering_city'] = deliveringCity;
    data['delivering_street'] = deliveringStreet;
    data['delivering_landmark'] = deliveringLandmark;
    data['delivering_building_number'] = deliveringBuildingNumber;
    data['delivering_floor'] = deliveringFloor;
    data['delivering_apartment'] = deliveringApartment;
    data['delivering_lat'] = deliveringLat;
    data['delivering_lng'] = deliveringLng;
    data['date_to_deliver_shipment'] = dateToDeliverShipment;
    data['client_name'] = clientName;
    data['client_phone'] = clientPhone;
    data['notes'] = notes;
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['expected_shipping_cost'] = expectedShippingCost;
    data['agreed_shipping_cost'] = agreedShippingCost;
    data['merchant_id'] = merchantId;
    data['courier_id'] = courierId;
    data['status'] = status;
    data['handover_code_courier_to_merchant'] =
        handoverCodeCourierToMerchant;
    data['handover_qrcode_courier_to_merchant'] =
        handoverQrcodeCourierToMerchant;
    data['handover_code_merchant_to_courier'] =
        handoverCodeMerchantToCourier;
    data['handover_qrcode_merchant_to_courier'] =
        handoverQrcodeMerchantToCourier;
    data['handover_code_courier_to_customer'] =
        handoverCodeCourierToCustomer;
    data['handover_qrcode_courier_to_customer'] =
        handoverQrcodeCourierToCustomer;
    data['is_offer_based'] = isOfferBased;
    data['closed'] = closed;
    data['closed_at'] = closedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (receivingStateModel != null) {
      data['receiving_state_model'] = receivingStateModel!.toJson();
    }
    if (receivingCityModel != null) {
      data['receiving_city_model'] = receivingCityModel!.toJson();
    }
    if (deliveringStateModel != null) {
      data['delivering_state_model'] = deliveringStateModel!.toJson();
    }
    if (deliveringCityModel != null) {
      data['delivering_city_model'] = deliveringCityModel!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    if (courier != null) {
      data['courier'] = courier!.toJson();
    }
    return data;
  }
}

class ReceivingStateModel {
  int? id;
  String? name;
  int? countryId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ReceivingStateModel(
      {this.id,
        this.name,
        this.countryId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ReceivingStateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class ReceivingCityModel {
  int? id;
  String? name;
  int? stateId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  ReceivingCityModel(
      {this.id,
        this.name,
        this.stateId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ReceivingCityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Products {
  int? id;
  int? shipmentId;
  int? productId;
  int? qty;
  int? price;
  int? total;
  String? createdAt;
  String? updatedAt;
  ProductInfo? productInfo;

  Products(
      {this.id,
        this.shipmentId,
        this.productId,
        this.qty,
        this.price,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.productInfo});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentId = json['shipment_id'];
    productId = json['product_id'];
    qty = json['qty'];
    price = json['price'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productInfo = json['product_info'] != null
        ? ProductInfo.fromJson(json['product_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shipment_id'] = shipmentId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['price'] = price;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (productInfo != null) {
      data['product_info'] = productInfo!.toJson();
    }
    return data;
  }
}

class ProductInfo {
  int? id;
  String? name;
  int? defaultPrice;
  String? description;
  int? categoryId;
  String? image;
  String? length;
  String? width;
  String? height;
  String? weight;
  ProductCategory? productCategory;

  ProductInfo(
      {this.id,
        this.name,
        this.defaultPrice,
        this.description,
        this.categoryId,
        this.image,
        this.length,
        this.width,
        this.height,
        this.weight,
        this.productCategory});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    defaultPrice = json['default_price'];
    description = json['description'];
    categoryId = json['category_id'];
    image = json['image'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    weight = json['weight'];
    productCategory = json['product_category'] != null
        ? ProductCategory.fromJson(json['product_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['default_price'] = defaultPrice;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['image'] = image;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['weight'] = weight;
    if (productCategory != null) {
      data['product_category'] = productCategory!.toJson();
    }
    return data;
  }
}

class ProductCategory {
  int? id;
  String? name;
  String? image;

  ProductCategory({this.id, this.name, this.image});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Merchant {
  int? id;
  String? firstName;
  String? lastName;
  String? brandName;
  String? email;
  String? photo;
  String? phone;
  String? gender;
  String? company;
  num? workTypeId;
  num? categoryId;
  int? online;
  String? cachedAverageRating;
  String? name;

  Merchant(
      {this.id,
        this.firstName,
        this.lastName,
        this.brandName,
        this.email,
        this.photo,
        this.phone,
        this.gender,
        this.company,
        this.workTypeId,
        this.categoryId,
        this.online,
        this.cachedAverageRating,
        this.name});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    brandName = json['brand_name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    gender = json['gender'];
    company = json['company'];
    workTypeId = json['work_type_id'];
    categoryId = json['category_id'];
    online = json['online'];
    cachedAverageRating = json['cached_average_rating'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['brand_name'] = brandName;
    data['email'] = email;
    data['photo'] = photo;
    data['phone'] = phone;
    data['gender'] = gender;
    data['company'] = company;
    data['work_type_id'] = workTypeId;
    data['category_id'] = categoryId;
    data['online'] = online;
    data['cached_average_rating'] = cachedAverageRating;
    data['name'] = name;
    return data;
  }
}

class Courier {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? photo;
  String? phone;
  String? gender;
  String? vehicleNumber;
  String? vehicleColor;
  String? vehicleModel;
  String? deliveryMethod;
  int? online;
  String? cachedAverageRating;
  String? name;

  Courier(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.photo,
        this.phone,
        this.gender,
        this.vehicleNumber,
        this.vehicleColor,
        this.vehicleModel,
        this.deliveryMethod,
        this.online,
        this.cachedAverageRating,
        this.name});

  Courier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    gender = json['gender'];
    vehicleNumber = json['vehicle_number'];
    vehicleColor = json['vehicle_color'];
    vehicleModel = json['vehicle_model'];
    deliveryMethod = json['delivery_method'];
    online = json['online'];
    cachedAverageRating = json['cached_average_rating'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['photo'] = photo;
    data['phone'] = phone;
    data['gender'] = gender;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_color'] = vehicleColor;
    data['vehicle_model'] = vehicleModel;
    data['delivery_method'] = deliveryMethod;
    data['online'] = online;
    data['cached_average_rating'] = cachedAverageRating;
    data['name'] = name;
    return data;
  }
}
