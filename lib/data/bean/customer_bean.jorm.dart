// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CustomerBean implements Bean<Customer> {
  final id = IntField('id');
  final shopId = StrField('shop_id');
  final userId = IntField('user_id');
  final qrcode = StrField('qrcode');
  final regionId = IntField('region_id');
  final locationId = IntField('location_id');
  final shopName = StrField('shop_name');
  final address = StrField('address');
  final location = StrField('location');
  final shopPhoneno = StrField('shop_phoneno');
  final customerType = StrField('customer_type');
  final groupName = StrField('group_name');
  final creditLimit = IntField('credit_limit');
  final tier = StrField('tier');
  final slatitude = StrField('slatitude');
  final slongitude = StrField('slongitude');
  final visitTime = StrField('visit_time');
  final updatedTime = StrField('updated_time');
  final shopEmail = StrField('shop_email');
  final specificLocation = StrField('specific_location');
  final shopCatId = IntField('shop_cat_id');
  final shopSubCatId = IntField('shop_sub_cat_id');
  final groupId = IntField('group_id');
  final shopLocationId = IntField('shop_location_id');
  final kraPin = StrField('kra_pin');
  final addedBy = IntField('added_by');
  final contactPerson = StrField('contact_person');
  final postalAddress = StrField('postal_address');
  final status = IntField('status');
  final shopStatust = StrField('shop_statust');
  final verified = StrField('verified');
  final verifiedby = IntField('verifiedby');
  final verificationDate = StrField('verification_date');
  final photo = StrField('photo');
  final loyaltyEnrolledAt = StrField('loyalty_enrolled_at');
  final pezeshaEnrolledAt = StrField('pezesha_enrolled_at');
  final createdAt = StrField('created_at');
  final updatedAt = StrField('updated_at');
  final routeId = IntField('route_id');
  final orderId = IntField('order_id');
  final synced = BoolField('synced');
  final updated = BoolField('updated');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        shopId.name: shopId,
        userId.name: userId,
        qrcode.name: qrcode,
        regionId.name: regionId,
        locationId.name: locationId,
        shopName.name: shopName,
        address.name: address,
        location.name: location,
        shopPhoneno.name: shopPhoneno,
        customerType.name: customerType,
        groupName.name: groupName,
        creditLimit.name: creditLimit,
        tier.name: tier,
        slatitude.name: slatitude,
        slongitude.name: slongitude,
        visitTime.name: visitTime,
        updatedTime.name: updatedTime,
        shopEmail.name: shopEmail,
        specificLocation.name: specificLocation,
        shopCatId.name: shopCatId,
        shopSubCatId.name: shopSubCatId,
        groupId.name: groupId,
        shopLocationId.name: shopLocationId,
        kraPin.name: kraPin,
        addedBy.name: addedBy,
        contactPerson.name: contactPerson,
        postalAddress.name: postalAddress,
        status.name: status,
        shopStatust.name: shopStatust,
        verified.name: verified,
        verifiedby.name: verifiedby,
        verificationDate.name: verificationDate,
        photo.name: photo,
        loyaltyEnrolledAt.name: loyaltyEnrolledAt,
        pezeshaEnrolledAt.name: pezeshaEnrolledAt,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        routeId.name: routeId,
        orderId.name: orderId,
        synced.name: synced,
        updated.name: updated,
        fromServer.name: fromServer,
      };
  Customer fromMap(Map map) {
    Customer model = Customer();
    model.id = adapter.parseValue(map['id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.userId = adapter.parseValue(map['user_id']);
    model.qrcode = adapter.parseValue(map['qrcode']);
    model.regionId = adapter.parseValue(map['region_id']);
    model.locationId = adapter.parseValue(map['location_id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.address = adapter.parseValue(map['address']);
    model.location = adapter.parseValue(map['location']);
    model.shopPhoneno = adapter.parseValue(map['shop_phoneno']);
    model.customerType = adapter.parseValue(map['customer_type']);
    model.groupName = adapter.parseValue(map['group_name']);
    model.creditLimit = adapter.parseValue(map['credit_limit']);
    model.tier = adapter.parseValue(map['tier']);
    model.slatitude = adapter.parseValue(map['slatitude']);
    model.slongitude = adapter.parseValue(map['slongitude']);
    model.visitTime = adapter.parseValue(map['visit_time']);
    model.updatedTime = adapter.parseValue(map['updated_time']);
    model.shopEmail = adapter.parseValue(map['shop_email']);
    model.specificLocation = adapter.parseValue(map['specific_location']);
    model.shopCatId = adapter.parseValue(map['shop_cat_id']);
    model.shopSubCatId = adapter.parseValue(map['shop_sub_cat_id']);
    model.groupId = adapter.parseValue(map['group_id']);
    model.shopLocationId = adapter.parseValue(map['shop_location_id']);
    model.kraPin = adapter.parseValue(map['kra_pin']);
    model.addedBy = adapter.parseValue(map['added_by']);
    model.contactPerson = adapter.parseValue(map['contact_person']);
    model.postalAddress = adapter.parseValue(map['postal_address']);
    model.status = adapter.parseValue(map['status']);
    model.shopStatust = adapter.parseValue(map['shop_statust']);
    model.verified = adapter.parseValue(map['verified']);
    model.verifiedby = adapter.parseValue(map['verifiedby']);
    model.verificationDate = adapter.parseValue(map['verification_date']);
    model.photo = adapter.parseValue(map['photo']);
    model.loyaltyEnrolledAt = adapter.parseValue(map['loyalty_enrolled_at']);
    model.pezeshaEnrolledAt = adapter.parseValue(map['pezesha_enrolled_at']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.routeId = adapter.parseValue(map['route_id']);
    model.orderId = adapter.parseValue(map['order_id']);
    model.synced = adapter.parseValue(map['synced']);
    model.updated = adapter.parseValue(map['updated']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Customer model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(shopId.set(model.shopId));
      ret.add(userId.set(model.userId));
      ret.add(qrcode.set(model.qrcode));
      ret.add(regionId.set(model.regionId));
      ret.add(locationId.set(model.locationId));
      ret.add(shopName.set(model.shopName));
      ret.add(address.set(model.address));
      ret.add(location.set(model.location));
      ret.add(shopPhoneno.set(model.shopPhoneno));
      ret.add(customerType.set(model.customerType));
      ret.add(groupName.set(model.groupName));
      ret.add(creditLimit.set(model.creditLimit));
      ret.add(tier.set(model.tier));
      ret.add(slatitude.set(model.slatitude));
      ret.add(slongitude.set(model.slongitude));
      ret.add(visitTime.set(model.visitTime));
      ret.add(updatedTime.set(model.updatedTime));
      ret.add(shopEmail.set(model.shopEmail));
      ret.add(specificLocation.set(model.specificLocation));
      ret.add(shopCatId.set(model.shopCatId));
      ret.add(shopSubCatId.set(model.shopSubCatId));
      ret.add(groupId.set(model.groupId));
      ret.add(shopLocationId.set(model.shopLocationId));
      ret.add(kraPin.set(model.kraPin));
      ret.add(addedBy.set(model.addedBy));
      ret.add(contactPerson.set(model.contactPerson));
      ret.add(postalAddress.set(model.postalAddress));
      ret.add(status.set(model.status));
      ret.add(shopStatust.set(model.shopStatust));
      ret.add(verified.set(model.verified));
      ret.add(verifiedby.set(model.verifiedby));
      ret.add(verificationDate.set(model.verificationDate));
      ret.add(photo.set(model.photo));
      ret.add(loyaltyEnrolledAt.set(model.loyaltyEnrolledAt));
      ret.add(pezeshaEnrolledAt.set(model.pezeshaEnrolledAt));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(routeId.set(model.routeId));
      ret.add(orderId.set(model.orderId));
      ret.add(synced.set(model.synced));
      ret.add(updated.set(model.updated));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(userId.name)) ret.add(userId.set(model.userId));
      if (only.contains(qrcode.name)) ret.add(qrcode.set(model.qrcode));
      if (only.contains(regionId.name)) ret.add(regionId.set(model.regionId));
      if (only.contains(locationId.name))
        ret.add(locationId.set(model.locationId));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(address.name)) ret.add(address.set(model.address));
      if (only.contains(location.name)) ret.add(location.set(model.location));
      if (only.contains(shopPhoneno.name))
        ret.add(shopPhoneno.set(model.shopPhoneno));
      if (only.contains(customerType.name))
        ret.add(customerType.set(model.customerType));
      if (only.contains(groupName.name))
        ret.add(groupName.set(model.groupName));
      if (only.contains(creditLimit.name))
        ret.add(creditLimit.set(model.creditLimit));
      if (only.contains(tier.name)) ret.add(tier.set(model.tier));
      if (only.contains(slatitude.name))
        ret.add(slatitude.set(model.slatitude));
      if (only.contains(slongitude.name))
        ret.add(slongitude.set(model.slongitude));
      if (only.contains(visitTime.name))
        ret.add(visitTime.set(model.visitTime));
      if (only.contains(updatedTime.name))
        ret.add(updatedTime.set(model.updatedTime));
      if (only.contains(shopEmail.name))
        ret.add(shopEmail.set(model.shopEmail));
      if (only.contains(specificLocation.name))
        ret.add(specificLocation.set(model.specificLocation));
      if (only.contains(shopCatId.name))
        ret.add(shopCatId.set(model.shopCatId));
      if (only.contains(shopSubCatId.name))
        ret.add(shopSubCatId.set(model.shopSubCatId));
      if (only.contains(groupId.name)) ret.add(groupId.set(model.groupId));
      if (only.contains(shopLocationId.name))
        ret.add(shopLocationId.set(model.shopLocationId));
      if (only.contains(kraPin.name)) ret.add(kraPin.set(model.kraPin));
      if (only.contains(addedBy.name)) ret.add(addedBy.set(model.addedBy));
      if (only.contains(contactPerson.name))
        ret.add(contactPerson.set(model.contactPerson));
      if (only.contains(postalAddress.name))
        ret.add(postalAddress.set(model.postalAddress));
      if (only.contains(status.name)) ret.add(status.set(model.status));
      if (only.contains(shopStatust.name))
        ret.add(shopStatust.set(model.shopStatust));
      if (only.contains(verified.name)) ret.add(verified.set(model.verified));
      if (only.contains(verifiedby.name))
        ret.add(verifiedby.set(model.verifiedby));
      if (only.contains(verificationDate.name))
        ret.add(verificationDate.set(model.verificationDate));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(loyaltyEnrolledAt.name))
        ret.add(loyaltyEnrolledAt.set(model.loyaltyEnrolledAt));
      if (only.contains(pezeshaEnrolledAt.name))
        ret.add(pezeshaEnrolledAt.set(model.pezeshaEnrolledAt));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(routeId.name)) ret.add(routeId.set(model.routeId));
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(updated.name)) ret.add(updated.set(model.updated));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.userId != null) {
        ret.add(userId.set(model.userId));
      }
      if (model.qrcode != null) {
        ret.add(qrcode.set(model.qrcode));
      }
      if (model.regionId != null) {
        ret.add(regionId.set(model.regionId));
      }
      if (model.locationId != null) {
        ret.add(locationId.set(model.locationId));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.address != null) {
        ret.add(address.set(model.address));
      }
      if (model.location != null) {
        ret.add(location.set(model.location));
      }
      if (model.shopPhoneno != null) {
        ret.add(shopPhoneno.set(model.shopPhoneno));
      }
      if (model.customerType != null) {
        ret.add(customerType.set(model.customerType));
      }
      if (model.groupName != null) {
        ret.add(groupName.set(model.groupName));
      }
      if (model.creditLimit != null) {
        ret.add(creditLimit.set(model.creditLimit));
      }
      if (model.tier != null) {
        ret.add(tier.set(model.tier));
      }
      if (model.slatitude != null) {
        ret.add(slatitude.set(model.slatitude));
      }
      if (model.slongitude != null) {
        ret.add(slongitude.set(model.slongitude));
      }
      if (model.visitTime != null) {
        ret.add(visitTime.set(model.visitTime));
      }
      if (model.updatedTime != null) {
        ret.add(updatedTime.set(model.updatedTime));
      }
      if (model.shopEmail != null) {
        ret.add(shopEmail.set(model.shopEmail));
      }
      if (model.specificLocation != null) {
        ret.add(specificLocation.set(model.specificLocation));
      }
      if (model.shopCatId != null) {
        ret.add(shopCatId.set(model.shopCatId));
      }
      if (model.shopSubCatId != null) {
        ret.add(shopSubCatId.set(model.shopSubCatId));
      }
      if (model.groupId != null) {
        ret.add(groupId.set(model.groupId));
      }
      if (model.shopLocationId != null) {
        ret.add(shopLocationId.set(model.shopLocationId));
      }
      if (model.kraPin != null) {
        ret.add(kraPin.set(model.kraPin));
      }
      if (model.addedBy != null) {
        ret.add(addedBy.set(model.addedBy));
      }
      if (model.contactPerson != null) {
        ret.add(contactPerson.set(model.contactPerson));
      }
      if (model.postalAddress != null) {
        ret.add(postalAddress.set(model.postalAddress));
      }
      if (model.status != null) {
        ret.add(status.set(model.status));
      }
      if (model.shopStatust != null) {
        ret.add(shopStatust.set(model.shopStatust));
      }
      if (model.verified != null) {
        ret.add(verified.set(model.verified));
      }
      if (model.verifiedby != null) {
        ret.add(verifiedby.set(model.verifiedby));
      }
      if (model.verificationDate != null) {
        ret.add(verificationDate.set(model.verificationDate));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.loyaltyEnrolledAt != null) {
        ret.add(loyaltyEnrolledAt.set(model.loyaltyEnrolledAt));
      }
      if (model.pezeshaEnrolledAt != null) {
        ret.add(pezeshaEnrolledAt.set(model.pezeshaEnrolledAt));
      }
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.updatedAt != null) {
        ret.add(updatedAt.set(model.updatedAt));
      }
      if (model.routeId != null) {
        ret.add(routeId.set(model.routeId));
      }
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
      if (model.updated != null) {
        ret.add(updated.set(model.updated));
      }
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(shopId.name, isNullable: true);
    st.addInt(userId.name, isNullable: true);
    st.addStr(qrcode.name, isNullable: true);
    st.addInt(regionId.name, isNullable: true);
    st.addInt(locationId.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addStr(address.name, isNullable: true);
    st.addStr(location.name, isNullable: true);
    st.addStr(shopPhoneno.name, isNullable: true);
    st.addStr(customerType.name, isNullable: true);
    st.addStr(groupName.name, isNullable: true);
    st.addInt(creditLimit.name, isNullable: true);
    st.addStr(tier.name, isNullable: true);
    st.addStr(slatitude.name, isNullable: true);
    st.addStr(slongitude.name, isNullable: true);
    st.addStr(visitTime.name, isNullable: true);
    st.addStr(updatedTime.name, isNullable: true);
    st.addStr(shopEmail.name, isNullable: true);
    st.addStr(specificLocation.name, isNullable: true);
    st.addInt(shopCatId.name, isNullable: true);
    st.addInt(shopSubCatId.name, isNullable: true);
    st.addInt(groupId.name, isNullable: true);
    st.addInt(shopLocationId.name, isNullable: true);
    st.addStr(kraPin.name, isNullable: true);
    st.addInt(addedBy.name, isNullable: true);
    st.addStr(contactPerson.name, isNullable: true);
    st.addStr(postalAddress.name, isNullable: true);
    st.addInt(status.name, isNullable: true);
    st.addStr(shopStatust.name, isNullable: true);
    st.addStr(verified.name, isNullable: true);
    st.addInt(verifiedby.name, isNullable: true);
    st.addStr(verificationDate.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addStr(loyaltyEnrolledAt.name, isNullable: true);
    st.addStr(pezeshaEnrolledAt.name, isNullable: true);
    st.addStr(createdAt.name, isNullable: true);
    st.addStr(updatedAt.name, isNullable: true);
    st.addInt(routeId.name, isNullable: true);
    st.addInt(orderId.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(updated.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Customer model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Customer newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Customer> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Customer model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    var retId;
    if (isForeignKeyEnabled) {
      final Insert insert = Insert(tableName, ignoreIfExist: true)
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.insert(insert);
      if (retId == null) {
        final Update update = updater
            .where(this.id.eq(model.id))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .id(id.name);
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Customer newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Customer> models,
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

  Future<int> update(Customer model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Customer> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Customer> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Customer> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
