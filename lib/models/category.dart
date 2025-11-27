class MagentoCategory {
    MagentoCategory({
        required this.id,
        required this.parentId,
        required this.name,
        required this.isActive,
        required this.position,
        required this.level,
        required this.productCount,
        required this.childrenData,
    });

    final int? id;
    final int? parentId;
    final String? name;
    final bool? isActive;
    final int? position;
    final int? level;
    final int? productCount;
    final List<MagentoCategory> childrenData;

    factory MagentoCategory.fromJson(Map<String, dynamic> json){ 
        return MagentoCategory(
            id: json["id"],
            parentId: json["parent_id"],
            name: json["name"],
            isActive: json["is_active"],
            position: json["position"],
            level: json["level"],
            productCount: json["product_count"],
            childrenData: json["children_data"] == null ? [] : List<MagentoCategory>.from(json["children_data"]!.map((x) => MagentoCategory.fromJson(x))),
        );
    }

}
