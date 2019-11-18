class LeavesList{
  final int id;
  final String leaveStatus;
  final String approvalsComment;
  final BigInt leavesCount;
  final String leaveType;
  final String startDate;
  final String endDate;
  final String description;
  final String supervisor;
  final int accountId;
  final String appliedBy;
  final int supervisorId;
  final String halfDayLeave;
  final String leaveSessionType;

  LeavesList({
    this.leaveStatus,
    this.id,
    this.approvalsComment,
    this.leavesCount,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.description,
    this.supervisor,
    this.accountId,
    this.appliedBy,
    this.supervisorId,
    this.halfDayLeave,
    this.leaveSessionType,

  });
  factory LeavesList.fromJson(Map<String, dynamic> json) {
    return LeavesList(
      id: json['id'],
      leaveStatus: json['leaveStatus'],
      approvalsComment: json['approvalsComment'],
     // leavesCount: json['leavesCount'],
      leaveType: json['leaveType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      description: json['description'],
      supervisor: json['supervisor'],
      accountId: json['accountId'],
      appliedBy: json['appliedBy'],
      supervisorId: json['supervisorId'],
      //halfDayLeave: json['halfDayLeave'],
      //leaveSessionType: json['leaveSessionType'],

    );
  }
}

