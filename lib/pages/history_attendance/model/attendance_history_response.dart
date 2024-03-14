class AttendanceHistoryResponse {
  int? status;
  String? message;
  List<AttendanceHistoryObj>? data;

  AttendanceHistoryResponse({this.status, this.message, this.data});

  factory AttendanceHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AttendanceHistoryObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class AttendanceHistoryObj {
  String? id;
  String? name;
  String? locationId;
  String? locationName;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? distance;

  AttendanceHistoryObj({
    this.id,
    this.name,
    this.locationId,
    this.locationName,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.distance,
  });

  factory AttendanceHistoryObj.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryObj(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        locationId: json['locationId'] as String?,
        locationName: json['locationName'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        distance: json['distance'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'locationId': locationId,
        'locationName': locationName,
        'latitude': latitude,
        'longitude': longitude,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'distance': distance,
      };
}
