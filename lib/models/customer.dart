/// Customer model
class MagentoCustomer {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? prefix;
  final String? suffix;
  final int? gender;
  final String? dateOfBirth;
  final String? taxvat;
  final bool? isSubscribed;
  final List<MagentoAddress>? addresses;
  final int? defaultBilling;
  final int? defaultShipping;
  final MagentoCustomerExtensionAttributes? extensionAttributes;

  MagentoCustomer({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.middleName,
    this.prefix,
    this.suffix,
    this.gender,
    this.dateOfBirth,
    this.taxvat,
    this.isSubscribed,
    this.addresses,
    this.defaultBilling,
    this.defaultShipping,
    this.extensionAttributes,
  });

  factory MagentoCustomer.fromJson(Map<String, dynamic> json) {
    return MagentoCustomer(
      id: json['id'],
      email: json['email'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      middleName: json['middlename'],
      prefix: json['prefix'],
      suffix: json['suffix'],
      gender: json['gender'],
      dateOfBirth: json['dob'],
      taxvat: json['taxvat'],
      isSubscribed: json['extension_attributes']?['is_subscribed'],
      addresses: json['addresses'] != null
          ? (json['addresses'] as List)
              .map((a) => MagentoAddress.fromJson(a))
              .toList()
          : null,
      defaultBilling: json['default_billing'],
      defaultShipping: json['default_shipping'],
      extensionAttributes: json['extension_attributes'] != null
          ? MagentoCustomerExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (firstName != null) 'firstname': firstName,
      if (lastName != null) 'lastname': lastName,
      if (middleName != null) 'middlename': middleName,
      if (prefix != null) 'prefix': prefix,
      if (suffix != null) 'suffix': suffix,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'dob': dateOfBirth,
      if (taxvat != null) 'taxvat': taxvat,
      if (isSubscribed != null)
        'extension_attributes': {'is_subscribed': isSubscribed},
      if (addresses != null)
        'addresses': addresses!.map((a) => a.toJson()).toList(),
      if (defaultBilling != null) 'default_billing': defaultBilling,
      if (defaultShipping != null) 'default_shipping': defaultShipping,
    };
  }
}

/// Customer address model
class MagentoAddress {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? prefix;
  final String? suffix;
  final String? company;
  final List<String>? street;
  final String? city;
  final String? region;
  final String? regionCode;
  final int? regionId;
  final String? postcode;
  final String? countryId;
  final String? telephone;
  final bool? defaultBilling;
  final bool? defaultShipping;

  MagentoAddress({
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.prefix,
    this.suffix,
    this.company,
    this.street,
    this.city,
    this.region,
    this.regionCode,
    this.regionId,
    this.postcode,
    this.countryId,
    this.telephone,
    this.defaultBilling,
    this.defaultShipping,
  });

  factory MagentoAddress.fromJson(Map<String, dynamic> json) {
    return MagentoAddress(
      id: json['id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      middleName: json['middlename'],
      prefix: json['prefix'],
      suffix: json['suffix'],
      company: json['company'],
      street: json['street'] != null
          ? List<String>.from(json['street'])
          : null,
      city: json['city'],
      region: json['region'],
      regionCode: json['region_code'],
      regionId: json['region_id'],
      postcode: json['postcode'],
      countryId: json['country_id'],
      telephone: json['telephone'],
      defaultBilling: json['default_billing'],
      defaultShipping: json['default_shipping'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (firstName != null) 'firstname': firstName,
      if (lastName != null) 'lastname': lastName,
      if (middleName != null) 'middlename': middleName,
      if (prefix != null) 'prefix': prefix,
      if (suffix != null) 'suffix': suffix,
      if (company != null) 'company': company,
      if (street != null) 'street': street,
      if (city != null) 'city': city,
      if (region != null) 'region': region,
      if (regionCode != null) 'region_code': regionCode,
      if (regionId != null) 'region_id': regionId,
      if (postcode != null) 'postcode': postcode,
      if (countryId != null) 'country_id': countryId,
      if (telephone != null) 'telephone': telephone,
      if (defaultBilling != null) 'default_billing': defaultBilling,
      if (defaultShipping != null) 'default_shipping': defaultShipping,
    };
  }
}

/// Extension attributes for customer
class MagentoCustomerExtensionAttributes {
  final bool? isSubscribed;
  final Map<String, dynamic>? additionalAttributes;

  MagentoCustomerExtensionAttributes({
    this.isSubscribed,
    this.additionalAttributes,
  });

  factory MagentoCustomerExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return MagentoCustomerExtensionAttributes(
      isSubscribed: json['is_subscribed'],
      additionalAttributes: json,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (isSubscribed != null) 'is_subscribed': isSubscribed,
      if (additionalAttributes != null) ...additionalAttributes!,
    };
  }
}

