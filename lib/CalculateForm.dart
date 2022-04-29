import 'dart:ui';

import 'package:flutter/material.dart';

import 'MyRadioListTile.dart';

class CalculateForm extends StatefulWidget {
  const CalculateForm({Key? key}) : super(key: key);

  @override
  _CalculateFormState createState() => _CalculateFormState();
}

List<TextEditingController> _controllers = [];
var dropDownPerusahaan = [""];
var dropDownCustomer = [""];
var dataCustomerTextField = [];
var dataAddBarang= [];
var dropDownPrintingLayer = [""];
var currentSelectedPerusahaan;
var currentSelectedPrintingLayer;
var currentSelectedCustomer;
int _valueCurrentMonthlyLiving = 0;
int _valueCurrentTolWaste = 0;
int _valueCurrentTolTerm = 0;
int _valueCurrentLeadTime = 0;
int _valueCurrentConditions = 0;
var controllerTebal = new TextEditingController();
var controllerPitch = new TextEditingController();
var controllerZipper = new TextEditingController();
var controllerCatatan = new TextEditingController();
var controllerCashDiscount = new TextEditingController();
var controllerCashQty = new TextEditingController();
var controllerCylinder = new TextEditingController();
var controllerDelivery = new TextEditingController();
var controllerValidity = new TextEditingController();
var controllerCatatan2 = new TextEditingController();
var controllerPayment = new TextEditingController();
var controllerConditions = new TextEditingController();
var controllerLeadTime = new TextEditingController();
bool isChecked = false;
bool isCheckedZipper = false;
String txtHasil = "result";

class _CalculateFormState extends State<CalculateForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (dropDownPerusahaan.length > 0) {
      dropDownPerusahaan.clear();
    }

    dropDownPerusahaan.add(" Aneka Pratama Plasindo");
    dropDownPerusahaan.add("Aneka Kencana Plasindo");
    dropDownPerusahaan.add("Indonesia Pratama Multipak");

    if (dropDownCustomer.length > 0) {
      dropDownCustomer.clear();
    }

    dropDownCustomer.add("Amin Jaya");
    dropDownCustomer.add("Bagus Sejati");
    dropDownCustomer.add("Abadi Jaya");
    dropDownCustomer.add("Bukit Tinggi");
    dropDownCustomer.add("Cahaya Indah");

    if (dropDownPrintingLayer.length > 0) {
      dropDownPrintingLayer.clear();
    }

    dropDownPrintingLayer.add("OPP");
    dropDownPrintingLayer.add("OPP MF");
    dropDownPrintingLayer.add("OPP HS");
    dropDownPrintingLayer.add("PET");
    dropDownPrintingLayer.add("NYLON");
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Price Quote",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDopDown("Pilih Perusahaan", currentSelectedPerusahaan,
                    dropDownPerusahaan, 1),
                Row(
                  children: [
                    Expanded(
                      child: buildDopDown("Pilih Customer",
                          currentSelectedCustomer, dropDownCustomer, 2),
                    ),
                    buildAddButton()
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Text("nama customer"),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      )),
                  height: 200,
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: dataCustomerTextField.length,
                    itemBuilder: (context, index) {
                      _controllers.add(new TextEditingController());
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            isDense: true, // Added this
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                            hintText: dataCustomerTextField[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                buildKodeProduksi(),
                buildDopDown("Printing Layer", currentSelectedPrintingLayer,
                    dropDownPrintingLayer, 3),
                buildTextField("Tebal" , controllerTebal),
                buildTextField("Catatan" , controllerCatatan),
                buildButtonAdd(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      )),
                  height: 200,
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: dataAddBarang.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        margin: EdgeInsets.all(5),
                        child: Container(
                          margin: EdgeInsets.all(3),
                          child: Row(
                            children: [
                              Expanded(child: Text(dataAddBarang[index])),
                              InkWell(onTap: () {
                                setState(() {
                                  dataAddBarang.removeAt(index);
                                });
                              },child: Icon(Icons.delete_forever_rounded),)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Checkbox(

                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text("Bag Making")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isCheckedZipper,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedZipper = value!;
                        });
                      },
                    ),
                    Text("Zipper")
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: buildTextField("Pitch" , controllerPitch),),
                    Expanded(child: buildTextField("Zipper" , controllerZipper),)
                  ],
                ),
                buildTolWaste(),
                buildTextFieldPrefix("Cash Discount" , controllerCashDiscount , Icons.percent),
                buildTextFieldPrefix("Qty Discount" , controllerCashQty , Icons.percent),
                buildButtonCalculate(),
                buildTextCalculate(),
                SizedBox(height: 20,),
                buildTextField("Cylinder" , controllerCylinder),
                buildTextField("Delivery" , controllerDelivery),
                buildTermOfPayment(),
                SizedBox(height: 20,),
                buildLeadTime(),
                SizedBox(height: 20,),
                buildTextField("Offer Validity" , controllerValidity),
                buildConditions(),
                SizedBox(height: 20,),
                buildTextField("Catatan" , controllerCatatan2),
                buildButtonSubmit("Submit"),
                buildButtonSubmit("Cancel"),
              ],
            ),
          ),
        ));
  }

  Widget buildDopDown(
      String hint, currentSelected, List<String> dropDown, int type) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 40,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: new BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: new BorderRadius.circular(5.0)),
            ),
            child: Container(
              height: 50,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  itemHeight: 50,
                  iconSize: 18,
                  hint: Text(
                    hint,
                    style: TextStyle(fontSize: 12),
                  ),
                  value: currentSelected,
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      switch (type) {
                        case 1:
                          currentSelectedPerusahaan = newValue;
                          break;
                        case 2:
                          currentSelectedCustomer = newValue;
                          break;
                        case 3:
                          currentSelectedPrintingLayer = newValue;
                          break;
                      }
                    });
                  },
                  items: dropDown
                      .asMap()
                      .map((i, element) => MapEntry(
                          i,
                          DropdownMenuItem<String>(
                            value: element,
                            child: Container(
                              // margin: EdgeInsets.all(5),
                              // height: 50,
                              child: Text(element,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )))
                      .values
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAddButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            dataCustomerTextField.add(currentSelectedCustomer);
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildKodeProduksi() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text("Kode Produksi"),
          ),
          MyRadioListTile<int>(
            width: 30,
            value: 1,
            groupValue: _valueCurrentMonthlyLiving,
            leading: '1',
            // title: Text('One'),
            onChanged: (value) => setState(() {
              _valueCurrentMonthlyLiving = value;
            }),
          ),
          SizedBox(
            width: 10,
          ),
          MyRadioListTile<int>(
            width: 30,
            value: 2,
            groupValue: _valueCurrentMonthlyLiving,
            leading: '2',
            // title: Text('Two'),
            onChanged: (value) => setState(() {
              _valueCurrentMonthlyLiving = value;
            }),
          ),
          SizedBox(
            width: 10,
          ),
          MyRadioListTile<int>(
            width: 30,
            value: 3,
            groupValue: _valueCurrentMonthlyLiving,
            leading: '3',
            // title: Text('Three'),
            onChanged: (value) => setState(() {
              _valueCurrentMonthlyLiving = value;
            }),
          ),
        ],
      ),
    );
  }
  Widget buildTolWaste() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text("Tol. waste"),
          ),
          MyRadioListTile<int>(
            width: 30,
            value: 8,
            groupValue: _valueCurrentTolWaste,
            leading: '8',
            // title: Text('One'),
            onChanged: (value) => setState(() {
              _valueCurrentTolWaste = value;
              controllerCashDiscount.text = _valueCurrentTolWaste.toString();
            }),
          ),
          SizedBox(
            width: 10,
          ),
          MyRadioListTile<int>(
            width: 30,
            value: 10,
            groupValue: _valueCurrentTolWaste,
            leading: '10',
            // title: Text('Two'),
            onChanged: (value) => setState(() {
              _valueCurrentTolWaste = value;
              controllerCashDiscount.text = _valueCurrentTolWaste.toString();
            }),
          ),
          SizedBox(
            width: 10,
          ),
          MyRadioListTile<int>(
            width: 30,
            value: 15,
            groupValue: _valueCurrentTolWaste,
            leading: '15',
            // title: Text('Three'),
            onChanged: (value) => setState(() {
              _valueCurrentTolWaste = value;
              controllerCashDiscount.text = _valueCurrentTolWaste.toString();
            }),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return
      Container(
        margin: EdgeInsets.all(10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(),
            hintText: hint,
          ),
        ),
      );
  }
  Widget buildTextFieldPrefix(String hint, TextEditingController controller, IconData iconData) {
    return
      Container(
        margin: EdgeInsets.all(10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            suffix: Icon(iconData,size: 15,),
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(),
            hintText: hint,
          ),
        ),
      );
  }

  Widget buildButtonAdd() {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          setState(() {
            dataAddBarang.add(currentSelectedPrintingLayer.toString());
          });
        },child: Center(
        child: Text("Tambah",style: TextStyle(color: Colors.white),),
      ),
      ),
    );
  }
  Widget buildButtonCalculate() {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          setState(() {
            txtHasil = "Rp. 100.000";
          });
        },child: Center(
        child: Text("Calculate",style: TextStyle(color: Colors.white),),
      ),
      ),
    );
  }
  Widget buildButtonSubmit(String text) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          setState(() {
          });
        },child: Center(
        child: Text(text,style: TextStyle(color: Colors.white),),
      ),
      ),
    );
  }

  Widget buildTextCalculate() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Center(
        child: Text(txtHasil, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,fontStyle: FontStyle.normal),),
      ),
    );
  }

  Widget buildTermOfPayment() {
    return Column(
      children: [
        buildTextField("Term of payment" , controllerPayment),
        Container(
          margin: EdgeInsets.only(right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyRadioListTile<int>(
                width: 60,
                value: 1,
                groupValue: _valueCurrentTolTerm,
                leading: 'DP 50%',
                // title: Text('One'),
                onChanged: (value) => setState(() {
                  _valueCurrentTolTerm = value;
                  controllerPayment.text = "DP 50%, 50% setelah pengiriman";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 2,
                groupValue: _valueCurrentTolTerm,
                leading: '7 days',
                // title: Text('Two'),
                onChanged: (value) => setState(() {
                  _valueCurrentTolTerm = value;
                  controllerPayment.text = "7 hari setelah pengiriman";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 3,
                groupValue: _valueCurrentTolTerm,
                leading: '14 days',
                // title: Text('Three'),
                onChanged: (value) => setState(() {
                  _valueCurrentTolTerm = value;
                  controllerPayment.text = "14 hari setelah pengiriman";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 4,
                groupValue: _valueCurrentTolTerm,
                leading: '30 days',
                // title: Text('Three'),
                onChanged: (value) => setState(() {
                  _valueCurrentTolTerm = value;
                  controllerPayment.text = "30 hari setelah pengiriman";
                }),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildLeadTime() {
    return Column(
      children: [
        buildTextField("Lead Time" , controllerLeadTime),
        Container(
          margin: EdgeInsets.only(right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyRadioListTile<int>(
                width: 60,
                value: 1,
                groupValue: _valueCurrentLeadTime,
                leading: '5 days',
                // title: Text('One'),
                onChanged: (value) => setState(() {
                  _valueCurrentLeadTime = value;
                  controllerLeadTime.text = "5 days from PO received";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 2,
                groupValue: _valueCurrentLeadTime,
                leading: '15 days',
                // title: Text('Two'),
                onChanged: (value) => setState(() {
                  _valueCurrentLeadTime = value;
                  controllerLeadTime.text = "15 days from PO received";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 3,
                groupValue: _valueCurrentLeadTime,
                leading: '30 days',
                // title: Text('Three'),
                onChanged: (value) => setState(() {
                  _valueCurrentLeadTime = value;
                  controllerLeadTime.text = "30 days from PO received";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 4,
                groupValue: _valueCurrentLeadTime,
                leading: '45 days',
                // title: Text('Three'),
                onChanged: (value) => setState(() {
                  _valueCurrentLeadTime = value;
                  controllerLeadTime.text = "45 days from PO received";
                }),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget buildConditions() {
    return Column(
      children: [
        buildTextField("Conditions" , controllerConditions),
        Container(
          margin: EdgeInsets.only(right: 10,left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyRadioListTile<int>(
                width: 60,
                value: 1,
                groupValue: _valueCurrentConditions,
                leading: '10%',
                // title: Text('One'),
                onChanged: (value) => setState(() {
                  _valueCurrentConditions = value;
                  controllerConditions.text = "Tolerance ± 10%, exclude PPN";
                }),
              ),
              SizedBox(
                width: 10,
              ),
              MyRadioListTile<int>(
                width: 60,
                value: 2,
                groupValue: _valueCurrentConditions,
                leading: '15%',
                // title: Text('Two'),
                onChanged: (value) => setState(() {
                  _valueCurrentConditions = value;
                  controllerConditions.text = "Tolerance ± 15%, exclude PPN";
                }),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
