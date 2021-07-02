//QualityInspectionModel class contains model to store data of quality inspection api
//All fields are  not been used only limited fields which were useful in app have been used

class QualityInspectionModel {
  final String? batchNo;
  final String? description;
  final String? itemCode;
  final String? itemname;
  final String? inspectionType;
  final String? inspectedBy;
  final String? name;
  final String? qualityInspectionTemplate;
  final String? referenceType;
  final String? referenceName;
  final String? reportDate;
  final String? remarks;
  final double? sampleSize;
  final String? status;
  final List<QualityInspectionReadings>? qiReadings;
  final int? docstatus;

  QualityInspectionModel(
      {this.batchNo,
      this.description,
      this.docstatus,
      this.itemCode,
      this.itemname,
      this.inspectionType,
      this.inspectedBy,
      this.name,
      this.qualityInspectionTemplate,
      this.referenceType,
      this.referenceName,
      this.reportDate,
      this.remarks,
      this.sampleSize,
      this.qiReadings,
      this.status});

  //For fetching json data from quality inspection api and storing it in quality inspection model
  factory QualityInspectionModel.fromJson(Map<String, dynamic> json) {
    return QualityInspectionModel(
      batchNo: json['batch_no'] ?? '',
      description: json['description'] ?? '',
      inspectedBy: json['inspected_by'] ?? '',
      inspectionType: json['inspection_type'] ?? '',
      itemCode: json['item_code'] ?? '',
      itemname: json['item_name'] ?? '',
      name: json['name'] ?? '',
      qualityInspectionTemplate: json['quality_inspection_template'] ?? '',
      referenceName: json['reference_name'] ?? '',
      referenceType: json['reference_type'] ?? '',
      reportDate: json['report_date'] ?? '',
      sampleSize: json['sample_size'] ?? '',
      remarks: json['remarks'] ?? '',
      status: json['status'] ?? '',
      
    );
  }
  //For converting model to json format for storing it in quality inspection model
  Map toJson() {
    List<Map>? qualityInspectionReadings = this.qiReadings != null
        ? this.qiReadings!.map((i) => i.toJson()).toList()
        : null;
    return {
      'docstatus': docstatus,
      'batch_no': null,
      'inspection_type': inspectionType,
      'item_code': itemCode,
      'item_name': itemname,
      "inspected_by": inspectedBy,
      'quality_inspection_template': qualityInspectionTemplate,
      'reference_name': referenceName,
      'reference_type': referenceType,
      'posting_date': reportDate,
      'sample_size': sampleSize,
      'status': status,
      "remarks": null,
      'readings': qualityInspectionReadings
    };
  }
}
//QualityInspectionReadings class contains model to store data of quality inspection api
class QualityInspectionReadings {
  String? parameter;
  String? acceptanceCriteria;
  String? status;
  String? reading1;
  String? reading2;
  String? reading3;
  String? reading4;
  String? reading5;
  String? reading6;

  QualityInspectionReadings({
    this.parameter,
    this.acceptanceCriteria,
    this.status,
    this.reading1,
    this.reading2,
    this.reading3,
    this.reading4,
    this.reading5,
    this.reading6,
  });
  //For fetching json data from quality inspection api and storing it in quality inspection readings
  factory QualityInspectionReadings.fromJson(Map<String, dynamic> json) {
    return QualityInspectionReadings(
      acceptanceCriteria: json['value'] ?? '',
      parameter: json['specification'] ?? '',
      reading1: json['reading_1'] ?? '',
      reading2: json['reading_2'] ?? '',
      reading3: json['reading_3'] ?? '',
      reading4: json['reading_4'] ?? '',
      reading5: json['reading_5'] ?? '',
      reading6: json['reading_6'] ?? '',
      status: json['status'] ?? '',
    );
  }

  //For converting model to json format for storing it in quality inspection readings
  Map toJson() => {
        'specification': parameter,
        'value': acceptanceCriteria,
        'status': status,
        'reading_1': reading1,
        'reading_2': reading2,
        'reading_3': reading3,
        'reading_4': reading4,
        'reading_5': reading5,
        'reading_6': reading6,
      };
}
