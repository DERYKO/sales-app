// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_record_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CustomerRecordBean implements Bean<CustomerRecord> {
  final sellingTotalCost = IntField('selling_total_cost');
  final shopName = StrField('shop_name');
  final entryType = StrField('entry_type');
  final postalAddress = StrField('postal_address');
  final appVersion = StrField('app_version');
  final lpoPhoto = StrField('lpo_photo');
  final outletLatitude = DoubleField('outlet_latitude');
  final latitude = DoubleField('latitude');
  final paymentAmount = IntField('payment_amount');
  final addedBy = IntField('added_by');
  final shopRouteId = StrField('shop_route_id');
  final paymentMethod = StrField('payment_method');
  final poster = IntField('poster');
  final paymentStatus = StrField('payment_status');
  final shopEmail = StrField('shop_email');
  final totalCost = IntField('total_cost');
  final phoneNumber = StrField('phone_number');
  final kraPin = StrField('kra_pin');
  final contactPerson = StrField('contact_person');
  final callStatus = StrField('call_status');
  final du = IntField('du');
  final routeId = IntField('route_id');
  final maturityDate = DateTimeField('maturity_date');
  final regionId = StrField('region_id');
  final outletLongitude = DoubleField('outlet_longitude');
  final longitude = DoubleField('longitude');
  final nextPayment = DateTimeField('next_payment');
  final locationId = IntField('location_id');
  final shopPhoneno = StrField('shop_phoneno');
  final channel = StrField('channel');
  final shopCatId = IntField('shop_cat_id');
  final orderTime = DateTimeField('order_time');
  final orderType = StrField('order_type');
  final routeType = StrField('route_type');
  final outletPhoto = StrField('outlet_photo');
  final battery = StrField('battery');
  final newShop = IntField('new_shop');
  final paymentId = StrField('payment_id');
  final salerId = IntField('saler_id');
  final shopId = IntField('shop_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        sellingTotalCost.name: sellingTotalCost,
        shopName.name: shopName,
        entryType.name: entryType,
        postalAddress.name: postalAddress,
        appVersion.name: appVersion,
        lpoPhoto.name: lpoPhoto,
        outletLatitude.name: outletLatitude,
        latitude.name: latitude,
        paymentAmount.name: paymentAmount,
        addedBy.name: addedBy,
        shopRouteId.name: shopRouteId,
        paymentMethod.name: paymentMethod,
        poster.name: poster,
        paymentStatus.name: paymentStatus,
        shopEmail.name: shopEmail,
        totalCost.name: totalCost,
        phoneNumber.name: phoneNumber,
        kraPin.name: kraPin,
        contactPerson.name: contactPerson,
        callStatus.name: callStatus,
        du.name: du,
        routeId.name: routeId,
        maturityDate.name: maturityDate,
        regionId.name: regionId,
        outletLongitude.name: outletLongitude,
        longitude.name: longitude,
        nextPayment.name: nextPayment,
        locationId.name: locationId,
        shopPhoneno.name: shopPhoneno,
        channel.name: channel,
        shopCatId.name: shopCatId,
        orderTime.name: orderTime,
        orderType.name: orderType,
        routeType.name: routeType,
        outletPhoto.name: outletPhoto,
        battery.name: battery,
        newShop.name: newShop,
        paymentId.name: paymentId,
        salerId.name: salerId,
        shopId.name: shopId,
      };
  CustomerRecord fromMap(Map map) {
    CustomerRecord model = CustomerRecord();
    model.sellingTotalCost = adapter.parseValue(map['selling_total_cost']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.entryType = adapter.parseValue(map['entry_type']);
    model.postalAddress = adapter.parseValue(map['postal_address']);
    model.appVersion = adapter.parseValue(map['app_version']);
    model.lpoPhoto = adapter.parseValue(map['lpo_photo']);
    model.outletLatitude = adapter.parseValue(map['outlet_latitude']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.paymentAmount = adapter.parseValue(map['payment_amount']);
    model.addedBy = adapter.parseValue(map['added_by']);
    model.shopRouteId = adapter.parseValue(map['shop_route_id']);
    model.paymentMethod = adapter.parseValue(map['payment_method']);
    model.poster = adapter.parseValue(map['poster']);
    model.paymentStatus = adapter.parseValue(map['payment_status']);
    model.shopEmail = adapter.parseValue(map['shop_email']);
    model.totalCost = adapter.parseValue(map['total_cost']);
    model.phoneNumber = adapter.parseValue(map['phone_number']);
    model.kraPin = adapter.parseValue(map['kra_pin']);
    model.contactPerson = adapter.parseValue(map['contact_person']);
    model.callStatus = adapter.parseValue(map['call_status']);
    model.du = adapter.parseValue(map['du']);
    model.routeId = adapter.parseValue(map['route_id']);
    model.maturityDate = adapter.parseValue(map['maturity_date']);
    model.regionId = adapter.parseValue(map['region_id']);
    model.outletLongitude = adapter.parseValue(map['outlet_longitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.nextPayment = adapter.parseValue(map['next_payment']);
    model.locationId = adapter.parseValue(map['location_id']);
    model.shopPhoneno = adapter.parseValue(map['shop_phoneno']);
    model.channel = adapter.parseValue(map['channel']);
    model.shopCatId = adapter.parseValue(map['shop_cat_id']);
    model.orderTime = adapter.parseValue(map['order_time']);
    model.orderType = adapter.parseValue(map['order_type']);
    model.routeType = adapter.parseValue(map['route_type']);
    model.outletPhoto = adapter.parseValue(map['outlet_photo']);
    model.battery = adapter.parseValue(map['battery']);
    model.newShop = adapter.parseValue(map['new_shop']);
    model.paymentId = adapter.parseValue(map['payment_id']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.shopId = adapter.parseValue(map['shop_id']);

    return model;
  }

  List<SetColumn> toSetColumns(CustomerRecord model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(sellingTotalCost.set(model.sellingTotalCost));
      ret.add(shopName.set(model.shopName));
      ret.add(entryType.set(model.entryType));
      ret.add(postalAddress.set(model.postalAddress));
      ret.add(appVersion.set(model.appVersion));
      ret.add(lpoPhoto.set(model.lpoPhoto));
      ret.add(outletLatitude.set(model.outletLatitude));
      ret.add(latitude.set(model.latitude));
      ret.add(paymentAmount.set(model.paymentAmount));
      ret.add(addedBy.set(model.addedBy));
      ret.add(shopRouteId.set(model.shopRouteId));
      ret.add(paymentMethod.set(model.paymentMethod));
      ret.add(poster.set(model.poster));
      ret.add(paymentStatus.set(model.paymentStatus));
      ret.add(shopEmail.set(model.shopEmail));
      ret.add(totalCost.set(model.totalCost));
      ret.add(phoneNumber.set(model.phoneNumber));
      ret.add(kraPin.set(model.kraPin));
      ret.add(contactPerson.set(model.contactPerson));
      ret.add(callStatus.set(model.callStatus));
      ret.add(du.set(model.du));
      ret.add(routeId.set(model.routeId));
      ret.add(maturityDate.set(model.maturityDate));
      ret.add(regionId.set(model.regionId));
      ret.add(outletLongitude.set(model.outletLongitude));
      ret.add(longitude.set(model.longitude));
      ret.add(nextPayment.set(model.nextPayment));
      ret.add(locationId.set(model.locationId));
      ret.add(shopPhoneno.set(model.shopPhoneno));
      ret.add(channel.set(model.channel));
      ret.add(shopCatId.set(model.shopCatId));
      ret.add(orderTime.set(model.orderTime));
      ret.add(orderType.set(model.orderType));
      ret.add(routeType.set(model.routeType));
      ret.add(outletPhoto.set(model.outletPhoto));
      ret.add(battery.set(model.battery));
      ret.add(newShop.set(model.newShop));
      ret.add(paymentId.set(model.paymentId));
      ret.add(salerId.set(model.salerId));
      ret.add(shopId.set(model.shopId));
    } else if (only != null) {
      if (only.contains(sellingTotalCost.name))
        ret.add(sellingTotalCost.set(model.sellingTotalCost));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(entryType.name))
        ret.add(entryType.set(model.entryType));
      if (only.contains(postalAddress.name))
        ret.add(postalAddress.set(model.postalAddress));
      if (only.contains(appVersion.name))
        ret.add(appVersion.set(model.appVersion));
      if (only.contains(lpoPhoto.name)) ret.add(lpoPhoto.set(model.lpoPhoto));
      if (only.contains(outletLatitude.name))
        ret.add(outletLatitude.set(model.outletLatitude));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(paymentAmount.name))
        ret.add(paymentAmount.set(model.paymentAmount));
      if (only.contains(addedBy.name)) ret.add(addedBy.set(model.addedBy));
      if (only.contains(shopRouteId.name))
        ret.add(shopRouteId.set(model.shopRouteId));
      if (only.contains(paymentMethod.name))
        ret.add(paymentMethod.set(model.paymentMethod));
      if (only.contains(poster.name)) ret.add(poster.set(model.poster));
      if (only.contains(paymentStatus.name))
        ret.add(paymentStatus.set(model.paymentStatus));
      if (only.contains(shopEmail.name))
        ret.add(shopEmail.set(model.shopEmail));
      if (only.contains(totalCost.name))
        ret.add(totalCost.set(model.totalCost));
      if (only.contains(phoneNumber.name))
        ret.add(phoneNumber.set(model.phoneNumber));
      if (only.contains(kraPin.name)) ret.add(kraPin.set(model.kraPin));
      if (only.contains(contactPerson.name))
        ret.add(contactPerson.set(model.contactPerson));
      if (only.contains(callStatus.name))
        ret.add(callStatus.set(model.callStatus));
      if (only.contains(du.name)) ret.add(du.set(model.du));
      if (only.contains(routeId.name)) ret.add(routeId.set(model.routeId));
      if (only.contains(maturityDate.name))
        ret.add(maturityDate.set(model.maturityDate));
      if (only.contains(regionId.name)) ret.add(regionId.set(model.regionId));
      if (only.contains(outletLongitude.name))
        ret.add(outletLongitude.set(model.outletLongitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(nextPayment.name))
        ret.add(nextPayment.set(model.nextPayment));
      if (only.contains(locationId.name))
        ret.add(locationId.set(model.locationId));
      if (only.contains(shopPhoneno.name))
        ret.add(shopPhoneno.set(model.shopPhoneno));
      if (only.contains(channel.name)) ret.add(channel.set(model.channel));
      if (only.contains(shopCatId.name))
        ret.add(shopCatId.set(model.shopCatId));
      if (only.contains(orderTime.name))
        ret.add(orderTime.set(model.orderTime));
      if (only.contains(orderType.name))
        ret.add(orderType.set(model.orderType));
      if (only.contains(routeType.name))
        ret.add(routeType.set(model.routeType));
      if (only.contains(outletPhoto.name))
        ret.add(outletPhoto.set(model.outletPhoto));
      if (only.contains(battery.name)) ret.add(battery.set(model.battery));
      if (only.contains(newShop.name)) ret.add(newShop.set(model.newShop));
      if (only.contains(paymentId.name))
        ret.add(paymentId.set(model.paymentId));
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
    } else /* if (onlyNonNull) */ {
      if (model.sellingTotalCost != null) {
        ret.add(sellingTotalCost.set(model.sellingTotalCost));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.entryType != null) {
        ret.add(entryType.set(model.entryType));
      }
      if (model.postalAddress != null) {
        ret.add(postalAddress.set(model.postalAddress));
      }
      if (model.appVersion != null) {
        ret.add(appVersion.set(model.appVersion));
      }
      if (model.lpoPhoto != null) {
        ret.add(lpoPhoto.set(model.lpoPhoto));
      }
      if (model.outletLatitude != null) {
        ret.add(outletLatitude.set(model.outletLatitude));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.paymentAmount != null) {
        ret.add(paymentAmount.set(model.paymentAmount));
      }
      if (model.addedBy != null) {
        ret.add(addedBy.set(model.addedBy));
      }
      if (model.shopRouteId != null) {
        ret.add(shopRouteId.set(model.shopRouteId));
      }
      if (model.paymentMethod != null) {
        ret.add(paymentMethod.set(model.paymentMethod));
      }
      if (model.poster != null) {
        ret.add(poster.set(model.poster));
      }
      if (model.paymentStatus != null) {
        ret.add(paymentStatus.set(model.paymentStatus));
      }
      if (model.shopEmail != null) {
        ret.add(shopEmail.set(model.shopEmail));
      }
      if (model.totalCost != null) {
        ret.add(totalCost.set(model.totalCost));
      }
      if (model.phoneNumber != null) {
        ret.add(phoneNumber.set(model.phoneNumber));
      }
      if (model.kraPin != null) {
        ret.add(kraPin.set(model.kraPin));
      }
      if (model.contactPerson != null) {
        ret.add(contactPerson.set(model.contactPerson));
      }
      if (model.callStatus != null) {
        ret.add(callStatus.set(model.callStatus));
      }
      if (model.du != null) {
        ret.add(du.set(model.du));
      }
      if (model.routeId != null) {
        ret.add(routeId.set(model.routeId));
      }
      if (model.maturityDate != null) {
        ret.add(maturityDate.set(model.maturityDate));
      }
      if (model.regionId != null) {
        ret.add(regionId.set(model.regionId));
      }
      if (model.outletLongitude != null) {
        ret.add(outletLongitude.set(model.outletLongitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.nextPayment != null) {
        ret.add(nextPayment.set(model.nextPayment));
      }
      if (model.locationId != null) {
        ret.add(locationId.set(model.locationId));
      }
      if (model.shopPhoneno != null) {
        ret.add(shopPhoneno.set(model.shopPhoneno));
      }
      if (model.channel != null) {
        ret.add(channel.set(model.channel));
      }
      if (model.shopCatId != null) {
        ret.add(shopCatId.set(model.shopCatId));
      }
      if (model.orderTime != null) {
        ret.add(orderTime.set(model.orderTime));
      }
      if (model.orderType != null) {
        ret.add(orderType.set(model.orderType));
      }
      if (model.routeType != null) {
        ret.add(routeType.set(model.routeType));
      }
      if (model.outletPhoto != null) {
        ret.add(outletPhoto.set(model.outletPhoto));
      }
      if (model.battery != null) {
        ret.add(battery.set(model.battery));
      }
      if (model.newShop != null) {
        ret.add(newShop.set(model.newShop));
      }
      if (model.paymentId != null) {
        ret.add(paymentId.set(model.paymentId));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(sellingTotalCost.name, isNullable: false);
    st.addStr(shopName.name, isNullable: false);
    st.addStr(entryType.name, isNullable: false);
    st.addStr(postalAddress.name, isNullable: false);
    st.addStr(appVersion.name, isNullable: false);
    st.addStr(lpoPhoto.name, isNullable: false);
    st.addDouble(outletLatitude.name, isNullable: false);
    st.addDouble(latitude.name, isNullable: false);
    st.addInt(paymentAmount.name, isNullable: false);
    st.addInt(addedBy.name, isNullable: false);
    st.addStr(shopRouteId.name, isNullable: false);
    st.addStr(paymentMethod.name, isNullable: false);
    st.addInt(poster.name, isNullable: false);
    st.addStr(paymentStatus.name, isNullable: false);
    st.addStr(shopEmail.name, isNullable: false);
    st.addInt(totalCost.name, isNullable: false);
    st.addStr(phoneNumber.name, isNullable: false);
    st.addStr(kraPin.name, isNullable: false);
    st.addStr(contactPerson.name, isNullable: false);
    st.addStr(callStatus.name, isNullable: false);
    st.addInt(du.name, isNullable: false);
    st.addInt(routeId.name, isNullable: false);
    st.addDateTime(maturityDate.name, isNullable: false);
    st.addStr(regionId.name, isNullable: false);
    st.addDouble(outletLongitude.name, isNullable: false);
    st.addDouble(longitude.name, isNullable: false);
    st.addDateTime(nextPayment.name, isNullable: false);
    st.addInt(locationId.name, isNullable: false);
    st.addStr(shopPhoneno.name, isNullable: false);
    st.addStr(channel.name, isNullable: false);
    st.addInt(shopCatId.name, isNullable: false);
    st.addDateTime(orderTime.name, isNullable: false);
    st.addStr(orderType.name, isNullable: false);
    st.addStr(routeType.name, isNullable: false);
    st.addStr(outletPhoto.name, isNullable: false);
    st.addStr(battery.name, isNullable: false);
    st.addInt(newShop.name, isNullable: false);
    st.addStr(paymentId.name, isNullable: false);
    st.addInt(salerId.name, isNullable: false);
    st.addInt(shopId.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(CustomerRecord model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<CustomerRecord> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(CustomerRecord model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<CustomerRecord> models,
      {bool onlyNonNull = false,
      Set<String> only,
      isForeignKeyEnabled = false}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<void> updateMany(List<CustomerRecord> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }
}
