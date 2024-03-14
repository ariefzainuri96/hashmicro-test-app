class LocationsResponse {
  int? status;
  String? message;
  List<LocationObj>? data;

  LocationsResponse({this.status, this.message, this.data});

  factory LocationsResponse.fromJson(Map<String, dynamic> json) {
    return LocationsResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LocationObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class LocationObj {
  String? id;
  String? name;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LocationObj({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LocationObj.fromJson(Map<String, dynamic> json) => LocationObj(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
