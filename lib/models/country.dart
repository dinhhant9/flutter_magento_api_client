class MagentoCountryItem {
    MagentoCountryItem({
        required this.id,
        required this.twoLetterAbbreviation,
        required this.threeLetterAbbreviation,
        required this.fullNameLocale,
        required this.fullNameEnglish,
        required this.availableRegions,
    });

    final String? id;
    final String? twoLetterAbbreviation;
    final String? threeLetterAbbreviation;
    final String? fullNameLocale;
    final String? fullNameEnglish;
    final List<MagentoAvailableRegion> availableRegions;

    factory MagentoCountryItem.fromJson(Map<String, dynamic> json){ 
        return MagentoCountryItem(
            id: json["id"],
            twoLetterAbbreviation: json["two_letter_abbreviation"],
            threeLetterAbbreviation: json["three_letter_abbreviation"],
            fullNameLocale: json["full_name_locale"],
            fullNameEnglish: json["full_name_english"],
            availableRegions: json["available_regions"] == null ? [] : List<MagentoAvailableRegion>.from(json["available_regions"]!.map((x) => MagentoAvailableRegion.fromJson(x))),
        );
    }

}

class MagentoAvailableRegion {
    MagentoAvailableRegion({
        required this.id,
        required this.code,
        required this.name,
    });

    final String? id;
    final String? code;
    final String? name;

    factory MagentoAvailableRegion.fromJson(Map<String, dynamic> json){ 
        return MagentoAvailableRegion(
            id: json["id"],
            code: json["code"],
            name: json["name"],
        );
    }

}
