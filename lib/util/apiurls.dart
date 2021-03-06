
String batchUrl() {
  return '/api/resource/Batch/?fields=["*"]&limit_page_length=*';
}

String batchListUrl(String text) {
  return '/api/resource/Batch?fields=[%22*%22]&filters=[[%22Batch%22,%22item%22,%22like%22,%22$text%22]]&limit_page_length=*';
}

String barcodeUrl(String text) {
  return '/api/method/erpnext.stock.doctype.quick_stock_balance.quick_stock_balance.get_stock_item_details?warehouse=&date=&barcode=$text';
}

String bomItemDetailUrl(String text) {
  return '/api/resource/BOM/$text';
}

String bomListUrl() {
  return '/api/resource/BOM/?fields=["*"]&limit_page_length=*';
}

String bomNameFromItemNameUrl(String text) {
  return '/api/resource/BOM/?fields=["*"]&filters=[["BOM","item_name","=","$text"]]&limit_page_length=*';
}

String bomNameFromItemUrl(String text) {
  return '/api/resource/BOM/?fields=["*"]&filters=[["BOM","item","=","$text"]]&limit_page_length=*';
}

String bomUrl(String text) {
  return '/api/resource/BOM/$text';
}

String bomPostUrl() {
  return '/api/resource/BOM';
}

String brandDataUrl(String text) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","brand","=","$text"]]&limit_page_length=*';
}

String brandListUrl() {
  return '/api/resource/Brand?fields=["name"]&limit_page_length=*';
}

String customerGroupUrl() {
  return '/api/resource/Customer%20Group?fields=["*"]&limit_page_length=*';
}

String customerPostUrl() {
  return '/api/resource/Customer';
}

String customerDetailUrl(String text) {
  return '/api/resource/Customer/$text';
}

String companyListUrl() {
  return '/api/resource/Company?fields=["*"]&limit_page_length=*';
}

String customerUrl() {
  return '/api/resource/Customer/?fields=["name"]&filters=[["Customer","disabled","=","No"]]&limit_page_length=*';
}

String currencyListUrl() {
  return '/api/resource/Currency/?fields=["name"]&filters=[["Currency","enabled","=","Yes"]]&limit_page_length=*';
}

String customerListUrl() {
  return '/api/resource/Customer?fields=["*"]&limit_page_length=*';
}

String deliveryNoteUrl() {
  return '/api/resource/Delivery%20Note/?fields=["*"]&filters=[["Delivery%20Note","status","like","%Completed%"]]&limit_page_length=*';
}

String deliveryNoteDataUrl(String text) {
  return '/api/resource/Delivery%20Note/$text';
}

String evaluassiStaffUrl() {
  return '/api/resource/Evaluasi%20Staff';
}

String evaluassiStaffListUrl() {
  return '/api/resource/Evaluasi%20Staff/?fields=["*"]&limit_page_length=*';
}

String evaluassiStaffDetailUrl(String text) {
  return '/api/resource/Evaluasi%20Staff/$text';
}

String fileUploadUrl() {
  return '/api/method/upload_file';
}

String employeeListUrl() {
  return '/api/resource/Leave%20Application/?fields=["employee_name"]&limit_page_length=*';
}

String globalDefaultsUrl() {
  return '/api/resource/Global%20Defaults/Global%20Defaults';
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

String itemUrl() {
  return '/api/resource/Item';
}

String itemDataUrl(String text) {
  return '/api/resource/Item/$text';
}

String itemGroupDataUrl(String text) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","item_group","=","$text"]]&limit_page_length=*';
}

String itemGroupandWeightDataUrl(String groupText, String weight) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","item_group","=","$groupText"],["Item","weight_per_unit","=","$weight"]]&limit_page_length=*';
}

String itemGroupandWeight1DataUrl(String groupText, String weight1) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","item_group","=","$groupText"],["Item","weight_per_unit",">=","$weight1"]]&limit_page_length=*';
}

String itemGroupandWeight2DataUrl(String groupText, String weight2) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","item_group","=","$groupText"],["Item","weight_per_unit","<=","$weight2"]]&limit_page_length=*';
}

String itemBrandandWeight1DataUrl(String brandText, String weight1) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","brand","=","$brandText"],["Item","weight_per_unit",">=","$weight1"]]&limit_page_length=*';
}

String itemBrandandWeight2DataUrl(String brandText, String weight2) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","brand","=","$brandText"],["Item","weight_per_unit","<=","$weight2"]]&limit_page_length=*';
}

String itemGroupAndWeightDataSeriesUrl(
    String groupText, String weight1, String weight2) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","weight_per_unit",">=","$weight1"],["Item","weight_per_unit","<=","$weight2"],["Item","item_group","=","$groupText"]]&limit_page_length=*';
}

String itemBrandAndWeightDataSeriesUrl(
    String brand, String weight1, String weight2) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","weight_per_unit",">=","$weight1"],["Item","weight_per_unit","<=","$weight2"],["Item","brand","=","$brand"]]&limit_page_length=*';
}

String itemGroupUrl() {
  return '/api/resource/Item%20Group?fields=["*"]&limit_page_length=*';
}

String itemNameSearchUrl(String text) {
  return '/api/resource/Item/?fields=["item_code","item_name"]&filters=[["Item","item_name","like","%$text%"]]&limit_page_length=*';
}

String itemNameBasedOnItemGroupUrl(String text) {
  return '/api/resource/Item/?fields=["item_name"]&filters=[["Item","item_group","=","$text"]]&limit_page_length=*';
}

String itemPriceUrl() {
  return '/api/method/erpnext.stock.get_item_details.get_item_details';
}

String itemWeightUrl(String weight1, String weight2) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","weight_per_unit",">=","$weight1"],["Item","weight_per_unit","<=","$weight2"]]&limit_page_length=*';
}

String itemWeightInSeriesUrl(String text1, String text2) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","weight_per_unit",">=","$text1"],["Item","weight_per_unit","<=","$text2"]]&limit_page_length=*';
}

String itemListUrl() {
  return '/api/resource/Item/?fields=["item_code","item_name"]&limit_page_length=*';
}

String itemListForSalesItemUrl() {
  return '/api/resource/Item/?fields=["item_code","item_name"]&filters=[["Item","is_sales_item","=","Yes"]]&limit_page_length=*';
}

String labelsListUrl() {
  return '/api/method/frappe.desk.desktop.get_desktop_page';
}

String leaveLedgerEntryUrl(String name) {
  return '/api/resource/Leave%20Ledger%20Entry/?fields=["*"]&filters=[["Leave%20Ledger%20Entry","employee_name","like","$name"]]&limit_page_length=*';
}

String leadDetailUrl(String text) {
  return '/api/resource/Lead/$text';
}

String leadDetailFromLeadNameUrl(String text) {
  return '/api/resource/Lead/?fields=["*"]&filters=[["Lead","lead_name","=","$text"]]';
}

String leadListUrl() {
  return '/api/resource/Lead?fields=["*"]&limit_page_length=*';
}

String leadPostUrl() {
  return '/api/resource/Lead';
}

String locationUrl() {
  return '/api/resource/Location/?fields=["*"]&limit_page_length=*';
}

String loginUrl(String baseurl) {
  return '$baseurl/api/method/login';
}

String logoutUrl(String baseurl) {
  return '$baseurl/api/method/logout';
}

String modulesListUrl() {
  return '/api/method/frappe.desk.desktop.get_desk_sidebar_items';
}

String particularEmployeeListUrl(String employeeName) {
  return '/api/resource/Leave%20Application/?fields=["*"]&filters=[["Leave%20Application","employee_name","like","$employeeName"]]&limit_page_length=*';
}

String pdfUrl(String doctype, String docname) {
  return '/api/method/frappe.utils.print_format.download_pdf?doctype=$doctype&name=$docname&format=Standard&no_letterhead=1&letterhead=No%20Letterhead&settings=%7B%7D&_lang=en';
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

String quotationUrl() {
  return '/api/resource/Quotation';
}

String quotationListUrl() {
  return '/api/resource/Quotation/?fields=["*"]&limit_page_length=*';
}

String quotationIndividualUrl(String text) {
  return '/api/resource/Quotation/$text';
}

String salesInvoiceSubmittedUrl() {
  return '/api/resource/Sales%20Invoice/?fields=["*"]&filters=[["Sales%20Invoice","workflow_state","like","%Submitted%"]]&limit_page_length=*';
}

String salesInvoiceDataUrl(String text) {
  return '/api/resource/Sales%20Invoice/$text';
}

String salesOrderListUrl() {
  return '/api/resource/Sales%20Order?fields=["*"]&limit_page_length=*';
}

String salesOrderDetailUrl(String text) {
  return '/api/resource/Sales%20Order/$text';
}

String salesOrderUrl() {
  return '/api/resource/Sales%20Order';
}

String sampleApiCheckUrl(String text) {
  return '/api/resource/Item/$text';
}

String specificItemNameSearchUrl(String text) {
  return '/api/resource/Item/?fields=["item_code","item_name","image"]&filters=[["Item","item_name","like","$text"]]';
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

String territoryUrl() {
  return '/api/resource/Territory?fields=["*"]&limit_page_length=*';
}

String workOrderListUrl() {
  return '/api/resource/Work%20Order/?fields=["*"]&limit_page_length=*';
}

String usernameUrl() {
  return '/api/method/frappe.auth.get_logged_user';
}

String userListUrl() {
  return '/api/resource/User/?fields=["*"]&limit_page_length=*';
}

String userEmailFromUserName(String username) {
  return '/api/resource/User?fields=["*"]&filters=[["User","username","=","$username"]]&limit_page_length=*';
}

String uomUrl() {
  return '/api/resource/UOM/?fields=["*"]&limit_page_length=*';
}

String workOrderUrl(String text) {
  return '/api/resource/Work%20Order/$text';
}

String warehouseList(String text) {
  return '/api/resource/Warehouse/?fields=["*"]&filters=[["Warehouse","disabled","=","0"],["Warehouse","company","=","$text"]]&limit_page_length=*';
}
