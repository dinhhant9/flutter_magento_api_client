// /// Order model
class MagentoOrder {
  MagentoOrder({
    required this.entityId,
    required this.incrementId,
    required this.status,
    required this.state,
    required this.grandTotal,
    required this.subtotal,
    required this.shippingAmount,
    required this.taxAmount,
    required this.discountAmount,
    required this.currencyCode,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.billingAddress,
    required this.shippingAddress,
    required this.payment,
  });

  final int? entityId;
  final String? incrementId;
  final String? status;
  final String? state;
  final int? grandTotal;
  final int? subtotal;
  final int? shippingAmount;
  final int? taxAmount;
  final int? discountAmount;
  final String? currencyCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<MagentoOrderItem> items;
  final MagentoOrderAddress? billingAddress;
  final MagentoOrderAddress? shippingAddress;
  final MagentoOrderPayment? payment;

  factory MagentoOrder.fromJson(Map<String, dynamic> json) {
    return MagentoOrder(
      entityId: json['entity_id'],
      incrementId: json['increment_id'],
      status: json['status'],
      state: json['state'],
      grandTotal: json['grand_total'],
      subtotal: json['subtotal'],
      shippingAmount: json['shipping_amount'],
      taxAmount: json['tax_amount'],
      discountAmount: json['discount_amount'],
      currencyCode: json['order_currency_code'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      items: json['items'] == null
          ? []
          : List<MagentoOrderItem>.from(
              json['items']!.map((x) => MagentoOrderItem.fromJson(x)),
            ),
      billingAddress: json['billing_address'] == null
          ? null
          : MagentoOrderAddress.fromJson(json['billing_address']),
      shippingAddress:
          json['extension_attributes'] != null &&
              json['extension_attributes']['shipping_assignments'] != null &&
              json['extension_attributes']['shipping_assignments'].isNotEmpty
          ? MagentoOrderAddress.fromJson(
              json['extension_attributes']['shipping_assignments'][0]['shipping']['address'],
            )
          : null,
      payment: json['payment'] == null
          ? null
          : MagentoOrderPayment.fromJson(json['payment']),
    );
  }
}

class MagentoOrderItem {
  MagentoOrderItem({
    required this.itemId,
    required this.sku,
    required this.name,
    required this.qtyOrdered,
    required this.price,
    required this.rowTotal,
  });

  final int? itemId;
  final String? sku;
  final String? name;
  final int? qtyOrdered;
  final int? price;
  final int? rowTotal;

  factory MagentoOrderItem.fromJson(Map<String, dynamic> json) {
    return MagentoOrderItem(
      itemId: json['item_id'],
      sku: json['sku'],
      name: json['name'],
      qtyOrdered: json['qty_ordered'],
      price: json['price'],
      rowTotal: json['row_total'],
    );
  }
}

class MagentoOrderAddress {
  MagentoOrderAddress({
    required this.firstname,
    required this.lastname,
    required this.street,
    required this.city,
    required this.region,
    required this.postcode,
    required this.countryId,
    required this.telephone,
    required this.email,
  });

  final String? firstname;
  final String? lastname;
  final List<String>? street;
  final String? city;
  final String? region;
  final String? postcode;
  final String? countryId;
  final String? telephone;
  final String? email;

  factory MagentoOrderAddress.fromJson(Map<String, dynamic> json) {
    return MagentoOrderAddress(
      firstname: json['firstname'],
      lastname: json['lastname'],
      street: json['street'] == null ? null : List<String>.from(json['street']),
      city: json['city'],
      region: json['region'],
      postcode: json['postcode'],
      countryId: json['country_id'],
      telephone: json['telephone'],
      email: json['email'],
    );
  }
}

class MagentoOrderPayment {
  MagentoOrderPayment({
    required this.method,
    required this.additionalInformation,
  });

  final String? method;
  final List<String>? additionalInformation;

  factory MagentoOrderPayment.fromJson(Map<String, dynamic> json) {
    return MagentoOrderPayment(
      method: json['method'],
      additionalInformation: json['additional_information'] == null
          ? null
          : List<String>.from(json['additional_information']),
    );
  }
}
