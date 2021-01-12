String bomUrl(String text) {
  return '/api/resource/BOM/$text';
}

String batchUrl() {
  return '/api/resource/Batch/?fields=["*"]&limit_page_length=*';
}

String batchListUrl(String text) {
  return '/api/resource/Batch?fields=[%22*%22]&filters=[[%22Batch%22,%22item%22,%22like%22,%22$text%22]]&limit_page_length=*';
}

String barcodeUrl(String text) {
  return '/api/method/erpnext.stock.doctype.quick_stock_balance.quick_stock_balance.get_stock_item_details?warehouse=&date=&barcode=$text';
}

String deliveryNoteUrl() {
  return '/api/resource/Delivery%20Note/?fields=["*"]&filters=[["Delivery%20Note","status","like","%Completed%"]]&limit_page_length=*';
}

String deliveryNoteDataUrl(String text) {
  return '/api/resource/Delivery%20Note/$text';
}

String employeeListUrl() {
  return '/api/resource/Leave%20Application/?fields=["employee_name"]&limit_page_length=*';
}

String qualityInspectionListUrl() {
  return '/api/resource/Quality%20Inspection/?fields=["*"]&limit_page_length=*';
}

String qualityInspectionTemplateUrl(String text) {
  return '/api/resource/Quality%20Inspection%20Template/$text';
}

String qualityInspectionDetailUrl(String text) {
  return '/api/resource/Quality%20Inspection/$text';
}

String itemNameSearchUrl(String text) {
  return '/api/resource/Item/?fields=["item_code","item_name"]&filters=[["Item","item_name","like","%$text%"]]';
}

String itemDataUrl(String text) {
  return '/api/resource/Item/$text';
}

String itemListUrl() {
  return '/api/resource/Item/?fields=["item_code","item_name"]&limit_page_length=*';
}

String leaveLedgerEntryUrl(String name) {
  return '/api/resource/Leave%20Ledger%20Entry/?fields=["*"]&filters=[["Leave%20Ledger%20Entry","employee_name","like","$name"]]';
}

String loginUrl(String baseurl) {
  return '$baseurl/api/method/login';
}

String logoutUrl(String baseurl) {
  return '$baseurl/api/method/logout';
}

String particularEmployeeListUrl(String employeeName) {
  return '/api/resource/Leave%20Application/?fields=["*"]&filters=[["Leave%20Application","employee_name","like","$employeeName"]]&limit_page_length=*';
}

String purchaseInvoiceSubmittedUrl() {
  return '/api/resource/Purchase%20Invoice/?fields=["*"]&filters=[["Purchase%20Invoice","workflow_state","like","%Submitted%"]]&limit_page_length=*';
}

String purchaseInvoiceDataUrl(String text) {
  return '/api/resource/Purchase%20Invoice/$text';
}

String purchaseOrderListUrl() {
  return '/api/resource/Purchase%20Order/?fields=["*"]&filters=[["Purchase%20Order","status","in","To%20Receive%2CTo%20Receive%20and%20Bill"]]&limit_page_length=*';
}

String purchaseOrderDetailUrl(String text) {
  return '/api/resource/Purchase%20Order/$text';
}

String purchaseRecieptSubmittedUrl() {
  return '/api/resource/Purchase%20Receipt/?fields=["*"]&filters=[["Purchase%20Receipt","workflow_state","like","%Submitted%"]]&limit_page_length=*';
}

String purchaseRecieptDataUrl(String text) {
  return '/api/resource/Purchase%20Receipt/$text';
}

String purchaseRecieptUrl() {
  return '/api/resource/Purchase%20Receipt';
}

String qualityinspectionTemplateUrl() {
  return '/api/resource/Quality%20Inspection%20Template/?fields=["*"]&limit_page_length=*';
}

String qualityInspectionTemplateReadingsListUrl(String text) {
  return '/api/resource/Quality%20Inspection%20Template/$text';
}

String qualityInspectionUrl() {
  return '/api/resource/Quality%20Inspection';
}

// String qualityinspectionTemplateUrl(String text) {
//  return '/api/resource/Quality%20Inspection%20Template?fields=[%22*%22]&filters=[[%Quality%20Inspection%20Template%22,%22item%22,%22like%22,%22$text%22]]&limit_page_length=*';
// }

String salesInvoiceSubmittedUrl() {
  return '/api/resource/Sales%20Invoice/?fields=["*"]&filters=[["Sales%20Invoice","workflow_state","like","%Submitted%"]]&limit_page_length=*';
}

String salesInvoiceDataUrl(String text) {
  return '/api/resource/Sales%20Invoice/$text';
}

String sampleApiCheckUrl(String text) {
  return '/api/resource/Item/$text';
}

String specificItemNameSearchUrl(String text) {
  return '/api/resource/Item/?fields=["item_code","item_name"]&filters=[["Item","item_name","like","$text"]]';
}

String specificItemNameDataUrl(String text) {
  return '/api/resource/Item/?fields=["*"]&filters=[["Item","item_name","like","$text"]]';
}

String stockEntryUrl() {
  return '/api/resource/Stock%20Entry/?fields=["*"]&limit_page_length=*';
}

String stockEntryDetailUrl(String text) {
  return '/api/resource/Stock%20Entry/$text';
}

String stockEntrySubmittedUrl() {
  return '/api/resource/Stock%20Entry/?fields=["*"]&filters=[["Stock%20Entry","workflow_state","like","%Submitted%"]]&limit_page_length=*';
}

String stockEntryDataUrl(String text) {
  return '/api/resource/Stock%20Entry/$text';
}

String stockLedgerUrl(String text) {
  return '/api/resource/Stock%20Ledger%20Entry/?fields=["*"]&filters=[["Stock%20Ledger%20Entry","item_code","=","$text"]]';
}

String workOrderListUrl() {
  return '/api/resource/Work%20Order/?fields=["*"]&limit_page_length=*';
}

String usernameUrl() {
  return '/api/method/frappe.auth.get_logged_user';
}

String workOrderUrl(String text) {
  return '/api/resource/Work%20Order/$text';
}
