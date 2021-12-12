class Infographic {
  Infographic({
    this.onlineUsersCount,
    this.successfullCallCount,
    this.succesfullCallDuration,
    this.succesfullCallDurationFormatted,
    this.succesfullCallDurationFormattedShort,
    this.failedCallCount,
    this.remainingCredit,
    this.remainingCreditFormatted,
    this.remainingCreditFormattedSort,
  });

  int onlineUsersCount;
  int successfullCallCount;
  String succesfullCallDuration;
  String succesfullCallDurationFormatted;
  String succesfullCallDurationFormattedShort;
  int failedCallCount;
  int remainingCredit;
  String remainingCreditFormatted;
  String remainingCreditFormattedSort;

  factory Infographic.fromJson(Map<String, dynamic> json) => Infographic(
        onlineUsersCount: json["online_users_count"],
        successfullCallCount: json["successfull_call_count"],
        succesfullCallDuration: json["succesfull_call_duration"].toString(),
        succesfullCallDurationFormatted:
            json["succesfull_call_duration_formatted"],
        succesfullCallDurationFormattedShort:
            json["succesfull_call_duration_formatted_short"],
        failedCallCount: json["failed_call_count"],
        remainingCredit: json["remaining_credit"],
        remainingCreditFormatted: json["remaining_credit_formatted"],
        remainingCreditFormattedSort: json["remaining_credit_formatted_sort"],
      );
}
