class MagentoShippingMethod {
  MagentoShippingMethod({
    required this.carrierCode,
    required this.methodCode,
    required this.carrierTitle,
    required this.methodTitle,
    required this.amount,
    required this.baseAmount,
    required this.available,
    required this.errorMessage,
    required this.priceExclTax,
    required this.priceInclTax,
  });

  final String? carrierCode;
  final String? methodCode;
  final String? carrierTitle;
  final String? methodTitle;
  final int? amount;
  final int? baseAmount;
  final bool? available;
  final String? errorMessage;
  final int? priceExclTax;
  final int? priceInclTax;

  factory MagentoShippingMethod.fromJson(Map<String, dynamic> json) {
    return MagentoShippingMethod(
      carrierCode: json["carrier_code"],
      methodCode: json["method_code"],
      carrierTitle: json["carrier_title"],
      methodTitle: json["method_title"],
      amount: json["amount"],
      baseAmount: json["base_amount"],
      available: json["available"],
      errorMessage: json["error_message"],
      priceExclTax: json["price_excl_tax"],
      priceInclTax: json["price_incl_tax"],
    );
  }

  Map<String, dynamic> toJson() => {
    "carrier_code": carrierCode,
    "method_code": methodCode,
    "carrier_title": carrierTitle,
    "method_title": methodTitle,
    "amount": amount,
    "base_amount": baseAmount,
    "available": available,
    "error_message": errorMessage,
    "price_excl_tax": priceExclTax,
    "price_incl_tax": priceInclTax,
  };
}

class MagentoPaymentMethod {
  MagentoPaymentMethod({required this.code, required this.title});

  final String? code;
  final String? title;

  factory MagentoPaymentMethod.fromJson(Map<String, dynamic> json) {
    return MagentoPaymentMethod(code: json['code'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'title': title};
  }
}

class MagentoShippingAddressInput {
  MagentoShippingAddressInput({
    required this.firstname,
    required this.lastname,
    required this.street,
    required this.city,
    required this.region,
    required this.postcode,
    required this.countryId,
    required this.telephone,
    required this.email,
    this.regionId,
    this.regionCode,
  });

  final String firstname;
  final String lastname;
  final List<String> street;
  final String city;
  final String region;
  final String postcode;
  final String countryId;
  final String telephone;
  final String email;
  final int? regionId;
  final String? regionCode;

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'street': street,
      'city': city,
      'region': region,
      'postcode': postcode,
      'country_id': countryId,
      'telephone': telephone,
      'email': email,
      if (regionId != null) 'region_id': regionId,
      if (regionCode != null) 'region_code': regionCode,
    };
  }
}

class MagentoShippingInformationInput {
  MagentoShippingInformationInput({
    required this.shippingAddress,
    required this.shippingCarrierCode,
    required this.shippingMethodCode,
  });

  final MagentoShippingAddressInput shippingAddress;
  final String shippingCarrierCode;
  final String shippingMethodCode;

  Map<String, dynamic> toJson() {
    return {
      'addressInformation': {
        'shipping_address': shippingAddress.toJson(),
        'shipping_carrier_code': shippingCarrierCode,
        'shipping_method_code': shippingMethodCode,
      },
    };
  }
}

class MagentoPaymentInformationInput {
  MagentoPaymentInformationInput({
    required this.paymentMethod,
    this.billingAddress,
    this.email,
  });

  final MagentoPaymentMethod paymentMethod;
  final MagentoShippingAddressInput? billingAddress;
  final String? email;

  Map<String, dynamic> toJson() {
    return {
      'paymentMethod': {'method': paymentMethod.code},
      if (billingAddress != null) 'billing_address': billingAddress!.toJson(),
      if (email != null) 'email': email,
    };
  }
}
