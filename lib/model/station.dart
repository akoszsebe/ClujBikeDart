class StationsData {
    List<Station> data;
    int total;
    dynamic aggregateResults;
    dynamic errors;

    StationsData({
        this.data,
        this.total,
        this.aggregateResults,
        this.errors,
    });

    factory StationsData.fromJson(Map<String, dynamic> json) => new StationsData(
        data: new List<Station>.from(json["Data"].map((x) => Station.fromJson(x))),
        total: json["Total"],
        aggregateResults: json["AggregateResults"],
        errors: json["Errors"],
    );
}

class Station {
    String stationName;
    String address;
    int ocuppiedSpots;
    int emptySpots;
    int maximumNumberOfBikes;
    String lastSyncDate;
    int idStatus;
    Status status;
    StatusType statusType;
    double latitude;
    double longitude;
    bool isValid;
    bool customIsValid;
    List<dynamic> notifies;
    int id;

    Station({
        this.stationName,
        this.address,
        this.ocuppiedSpots,
        this.emptySpots,
        this.maximumNumberOfBikes,
        this.lastSyncDate,
        this.idStatus,
        this.status,
        this.statusType,
        this.latitude,
        this.longitude,
        this.isValid,
        this.customIsValid,
        this.notifies,
        this.id,
    });

    factory Station.fromJson(Map<String, dynamic> json) => new Station(
        stationName: json["StationName"],
        address: json["Address"],
        ocuppiedSpots: json["OcuppiedSpots"],
        emptySpots: json["EmptySpots"],
        maximumNumberOfBikes: json["MaximumNumberOfBikes"],
        lastSyncDate: json["LastSyncDate"],
        idStatus: json["IdStatus"],
        status: statusValues.map[json["Status"]],
        statusType: statusTypeValues.map[json["StatusType"]],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
        isValid: json["IsValid"],
        customIsValid: json["CustomIsValid"],
        notifies: new List<dynamic>.from(json["Notifies"].map((x) => x)),
        id: json["Id"],
    );
}

enum Status { FUNCTIONALA, DEFECTA }

final statusValues = new EnumValues({
    "Defecta": Status.DEFECTA,
    "Functionala": Status.FUNCTIONALA
});

enum StatusType { ONLINE, OFFLINE, SUBPOPULATED, SUPRAPOPULATED }

final statusTypeValues = new EnumValues({
    "Offline": StatusType.OFFLINE,
    "Online": StatusType.ONLINE,
    "Subpopulated":StatusType.SUBPOPULATED,
    "Suprapopulated":StatusType.SUPRAPOPULATED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}






 