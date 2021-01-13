# ebuzz
### A Flutter application as a ERPNext Frontend for simplified data entry and report access.

### To run code
Clone the source code<br/>
```sh
git clone https://github.com/Ambibuzz/erpnext-flutter-app.git
```
Then go to cloned directory<br/>
For installing packages<br/>
```sh
pub packages get
```
To run the project<br/>
```sh
flutter run
```
To run test cases<br/>
```sh
flutter test
```

### Packages Used

| Package Name            | Version       |
| ----------------------- | ------------- |
| autocomplete_textfield  | 1.7.3         |
| cupertino_icons         | 0.1.3         |
| dio                     | 3.0.10        |
| flutter_barcode_scanner | 1.0.1         |
| flutter_spinkit         | 4.1.2+1       |
| flutter_typeahead       | 1.8.8         |
| fluttertoast            | 7.1.1         |
| get                     | 3.15.0        |
| http                    | 0.12.2        |
| shared_preferences      | 0.5.10        |
| intl                    | 0.16.1        |

## Modules

**loginpage :**
User need to enter baseurl,username and password after entering these credentials user can login<br/>
Baseurl uses autocomplete functionality so when user enters url next time it suggests url which user had entered previously<br/><br/>
 **Homepage :**<br/>
 Homepage contains bom ,item ,purchase order ,leave balance leave list ,work order ,quality inspection ,stock entry .<br/><br/>
**Bom :**<br/>
Bom(Bill Of Material) takes itemcode as input and returns list of itemcode and itemname and their warehouse name and quantity.<br/><br/>
**Item:**<br/>
Item takes itemcode or itemname as input or user can scan barcode which will return itemcode if valid and then user gets details about that particular item.<br/><br/>
**Purchase Order:**<br/>
It returns list of purchase order which contain supplier name and id.<br/>
User can press particular list item for getting detail of it which contains detail of that purchase order.<br/><br/>
User can press button in bottom right to create purchase reciept.<br/><br/>
**Purchase Reciept:**<br/>
In purchase reciept form user can only edit quantity rest other fields are readable only also user can delete items and the form is saved as draft when user saves the form<br/><br/>
**Leave balance:**<br/>
Based on the username it gives leave balance of particukar user.<br/><br/>
**Leave list :**<br/>
Leave list displays list of leaves applied by user which contains date ,approver name  and its status which can be approved or rejected green dot means approved and red means rejected.<br/><br/>
**Work Order :**<br/>
Work Order displays list of work orders which shows itemcode ,itemname ,expected date and status in list tiles and when user clicks on particlar work order tile it shows complete detail of that work order.<br/><br/>
**Quality Inspection :**<br/>
Quality inspection displays list of quality inspections which contains name ,inspection type ,itemcode ,status in list tiles and when user clicks on particlar quality inspection tile it shows complete detail of that quality inspection<br/>
User can press button in bottom right to create quality inspection form.<br/><br/>
**Quality Inspection Form :**<br/>
Form is divided into multiple screens.<br/>
First screen takes date ,inspection type ,reference type as input.<br/>
Second screen displays previous screen details and takes reference name as input.<br/>
Third screen displays previous screen details and takes item name as input.<br/>
Fourth screen displays previous screen details and takes quality inspection template ,status as input and autofills item code ,sample size based on item name.<br/>
Fifth screen displays quality inspection template and takes input in form of readings based on quality inspection template and after that user can save form which is saved as draft.<br/><br/>
**Stock Entry :**<br/>
Stock Entry displays list of stock entries which shows stock entry type ,posting date and status in list tiles and when user clicks on particlar entry tile it shows complete detail of that stock entry.<br/><br/>

### Future Plans
Configuration for ios 

### License
MIT
