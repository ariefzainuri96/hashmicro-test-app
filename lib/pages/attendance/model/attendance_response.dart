class AttendanceResponse {
  int? status;
  String? message;
  AttendanceObj? data;

  AttendanceResponse({this.status, this.message, this.data});

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AttendanceObj.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class AttendanceObj {
  String? name;
  String? locationId;
  String? locationName;
  double? latitude;
  double? longitude;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AttendanceObj({
    this.name,
    this.locationId,
    this.locationName,
    this.latitude,
    this.longitude,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AttendanceObj.fromJson(Map<String, dynamic> json) => AttendanceObj(
        name: json['name'] as String?,
        locationId: json['locationId'] as String?,
        locationName: json['locationName'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        id: json['_id'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'locationId': locationId,
        'locationName': locationName,
        'latitude': latitude,
        'longitude': longitude,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
