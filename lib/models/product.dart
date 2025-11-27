class MagentoProductResult {
    MagentoProductResult({
        required this.items,
        required this.searchCriteria,
        required this.totalCount,
    });

    final List<MagentoProduct> items;
    final MagentoSearchCriteria? searchCriteria;
    final int? totalCount;

    factory MagentoProductResult.fromJson(Map<String, dynamic> json){ 
        return MagentoProductResult(
            items: json["items"] == null ? [] : List<MagentoProduct>.from(json["items"]!.map((x) => MagentoProduct.fromJson(x))),
            searchCriteria: json["search_criteria"] == null ? null : MagentoSearchCriteria.fromJson(json["search_criteria"]),
            totalCount: json["total_count"],
        );
    }

}

class MagentoProduct {
    MagentoProduct({
        required this.id,
        required this.sku,
        required this.name,
        required this.attributeSetId,
        required this.price,
        required this.status,
        required this.visibility,
        required this.typeId,
        required this.createdAt,
        required this.updatedAt,
        required this.weight,
        required this.extensionAttributes,
        required this.productLinks,
        required this.options,
        required this.mediaGalleryEntries,
        required this.tierPrices,
        required this.customAttributes,
    });

    final int? id;
    final String? sku;
    final String? name;
    final int? attributeSetId;
    final int? price;
    final int? status;
    final int? visibility;
    final String? typeId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final double? weight;
    final MagentoItemExtensionAttributes? extensionAttributes;
    final List<MagentoProductLink> productLinks;
    final List<dynamic> options;
    final List<MagentoMediaGalleryEntry> mediaGalleryEntries;
    final List<dynamic> tierPrices;
    final List<MagentoCustomAttribute> customAttributes;

    factory MagentoProduct.fromJson(Map<String, dynamic> json){ 
        return MagentoProduct(
            id: json["id"],
            sku: json["sku"],
            name: json["name"],
            attributeSetId: json["attribute_set_id"],
            price: json["price"],
            status: json["status"],
            visibility: json["visibility"],
            typeId: json["type_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            weight: json["weight"]?.toDouble(),
            extensionAttributes: json["extension_attributes"] == null ? null : MagentoItemExtensionAttributes.fromJson(json["extension_attributes"]),
            productLinks: json["product_links"] == null ? [] : List<MagentoProductLink>.from(json["product_links"]!.map((x) => MagentoProductLink.fromJson(x))),
            options: json["options"] == null ? [] : List<dynamic>.from(json["options"]!.map((x) => x)),
            mediaGalleryEntries: json["media_gallery_entries"] == null ? [] : List<MagentoMediaGalleryEntry>.from(json["media_gallery_entries"]!.map((x) => MagentoMediaGalleryEntry.fromJson(x))),
            tierPrices: json["tier_prices"] == null ? [] : List<dynamic>.from(json["tier_prices"]!.map((x) => x)),
            customAttributes: json["custom_attributes"] == null ? [] : List<MagentoCustomAttribute>.from(json["custom_attributes"]!.map((x) => MagentoCustomAttribute.fromJson(x))),
        );
    }

}

class MagentoCustomAttribute {
    MagentoCustomAttribute({
        required this.attributeCode,
        required this.value,
    });

    final String? attributeCode;
    final dynamic value;

    factory MagentoCustomAttribute.fromJson(Map<String, dynamic> json){ 
        return MagentoCustomAttribute(
            attributeCode: json["attribute_code"],
            value: json["value"],
        );
    }

}

class MagentoItemExtensionAttributes {
    MagentoItemExtensionAttributes({
        required this.websiteIds,
        required this.categoryLinks,
        required this.downloadableProductLinks,
        required this.downloadableProductSamples,
        required this.configurableProductOptions,
        required this.configurableProductLinks,
    });

    final List<int> websiteIds;
    final List<MagentoCategoryLink> categoryLinks;
    final List<MagentoDownloadableProductLink> downloadableProductLinks;
    final List<dynamic> downloadableProductSamples;
    final List<MagentoConfigurableProductOption> configurableProductOptions;
    final List<int> configurableProductLinks;

    factory MagentoItemExtensionAttributes.fromJson(Map<String, dynamic> json){ 
        return MagentoItemExtensionAttributes(
            websiteIds: json["website_ids"] == null ? [] : List<int>.from(json["website_ids"]!.map((x) => x)),
            categoryLinks: json["category_links"] == null ? [] : List<MagentoCategoryLink>.from(json["category_links"]!.map((x) => MagentoCategoryLink.fromJson(x))),
            downloadableProductLinks: json["downloadable_product_links"] == null ? [] : List<MagentoDownloadableProductLink>.from(json["downloadable_product_links"]!.map((x) => MagentoDownloadableProductLink.fromJson(x))),
            downloadableProductSamples: json["downloadable_product_samples"] == null ? [] : List<dynamic>.from(json["downloadable_product_samples"]!.map((x) => x)),
            configurableProductOptions: json["configurable_product_options"] == null ? [] : List<MagentoConfigurableProductOption>.from(json["configurable_product_options"]!.map((x) => MagentoConfigurableProductOption.fromJson(x))),
            configurableProductLinks: json["configurable_product_links"] == null ? [] : List<int>.from(json["configurable_product_links"]!.map((x) => x)),
        );
    }

}

class MagentoCategoryLink {
    MagentoCategoryLink({
        required this.position,
        required this.categoryId,
    });

    final int? position;
    final String? categoryId;

    factory MagentoCategoryLink.fromJson(Map<String, dynamic> json){ 
        return MagentoCategoryLink(
            position: json["position"],
            categoryId: json["category_id"],
        );
    }

}

class MagentoConfigurableProductOption {
    MagentoConfigurableProductOption({
        required this.id,
        required this.attributeId,
        required this.label,
        required this.position,
        required this.values,
        required this.productId,
    });

    final int? id;
    final String? attributeId;
    final String? label;
    final int? position;
    final List<MagentoValueElement> values;
    final int? productId;

    factory MagentoConfigurableProductOption.fromJson(Map<String, dynamic> json){ 
        return MagentoConfigurableProductOption(
            id: json["id"],
            attributeId: json["attribute_id"],
            label: json["label"],
            position: json["position"],
            values: json["values"] == null ? [] : List<MagentoValueElement>.from(json["values"]!.map((x) => MagentoValueElement.fromJson(x))),
            productId: json["product_id"],
        );
    }

}

class MagentoValueElement {
    MagentoValueElement({
        required this.valueIndex,
    });

    final int? valueIndex;

    factory MagentoValueElement.fromJson(Map<String, dynamic> json){ 
        return MagentoValueElement(
            valueIndex: json["value_index"],
        );
    }

}

class MagentoDownloadableProductLink {
    MagentoDownloadableProductLink({
        required this.id,
        required this.title,
        required this.sortOrder,
        required this.isShareable,
        required this.price,
        required this.numberOfDownloads,
        required this.linkType,
        required this.linkFile,
        required this.sampleType,
    });

    final int? id;
    final String? title;
    final int? sortOrder;
    final int? isShareable;
    final int? price;
    final int? numberOfDownloads;
    final String? linkType;
    final String? linkFile;
    final dynamic sampleType;

    factory MagentoDownloadableProductLink.fromJson(Map<String, dynamic> json){ 
        return MagentoDownloadableProductLink(
            id: json["id"],
            title: json["title"],
            sortOrder: json["sort_order"],
            isShareable: json["is_shareable"],
            price: json["price"],
            numberOfDownloads: json["number_of_downloads"],
            linkType: json["link_type"],
            linkFile: json["link_file"],
            sampleType: json["sample_type"],
        );
    }

}

class MagentoMediaGalleryEntry {
    MagentoMediaGalleryEntry({
        required this.id,
        required this.mediaType,
        required this.label,
        required this.position,
        required this.disabled,
        required this.types,
        required this.file,
    });

    final int? id;
    final String? mediaType;
    final String? label;
    final int? position;
    final bool? disabled;
    final List<String> types;
    final String? file;

    factory MagentoMediaGalleryEntry.fromJson(Map<String, dynamic> json){ 
        return MagentoMediaGalleryEntry(
            id: json["id"],
            mediaType: json["media_type"],
            label: json["label"],
            position: json["position"],
            disabled: json["disabled"],
            types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
            file: json["file"],
        );
    }

}

class MagentoProductLink {
    MagentoProductLink({
        required this.sku,
        required this.linkType,
        required this.linkedProductSku,
        required this.linkedProductType,
        required this.position,
        required this.extensionAttributes,
    });

    final String? sku;
    final String? linkType;
    final String? linkedProductSku;
    final String? linkedProductType;
    final int? position;
    final MagentoProductLinkExtensionAttributes? extensionAttributes;

    factory MagentoProductLink.fromJson(Map<String, dynamic> json){ 
        return MagentoProductLink(
            sku: json["sku"],
            linkType: json["link_type"],
            linkedProductSku: json["linked_product_sku"],
            linkedProductType: json["linked_product_type"],
            position: json["position"],
            extensionAttributes: json["extension_attributes"] == null ? null : MagentoProductLinkExtensionAttributes.fromJson(json["extension_attributes"]),
        );
    }

}

class MagentoProductLinkExtensionAttributes {
    MagentoProductLinkExtensionAttributes({
        required this.qty,
    });

    final int? qty;

    factory MagentoProductLinkExtensionAttributes.fromJson(Map<String, dynamic> json){ 
        return MagentoProductLinkExtensionAttributes(
            qty: json["qty"],
        );
    }

}

class MagentoSearchCriteria {
    MagentoSearchCriteria({
        required this.filterGroups,
        required this.sortOrders,
        required this.pageSize,
        required this.currentPage,
    });

    final List<dynamic> filterGroups;
    final List<MagentoSortOrder> sortOrders;
    final int? pageSize;
    final int? currentPage;

    factory MagentoSearchCriteria.fromJson(Map<String, dynamic> json){ 
        return MagentoSearchCriteria(
            filterGroups: json["filter_groups"] == null ? [] : List<dynamic>.from(json["filter_groups"]!.map((x) => x)),
            sortOrders: json["sort_orders"] == null ? [] : List<MagentoSortOrder>.from(json["sort_orders"]!.map((x) => MagentoSortOrder.fromJson(x))),
            pageSize: json["page_size"],
            currentPage: json["current_page"],
        );
    }

}

class MagentoSortOrder {
    MagentoSortOrder({
        required this.field,
        required this.direction,
    });

    final String? field;
    final String? direction;

    factory MagentoSortOrder.fromJson(Map<String, dynamic> json){ 
        return MagentoSortOrder(
            field: json["field"],
            direction: json["direction"],
        );
    }

}
