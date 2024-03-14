class StandartResponse {
  int? status;
  String? message;

  StandartResponse({this.status, this.message});

  factory StandartResponse.fromJson(Map<String, dynamic> json) {
    return StandartResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
