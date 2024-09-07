// pi_detail_bloc.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import '../../models/pi_detail/branch_name.dart';
import '../../models/pi_detail/load_combo.dart';
import '../../models/pi_detail/make.dart';
import '../../models/pi_detail/model.dart';
import '../../models/pi_detail/vehicle_category.dart';
import '../../screens/dropdownlist_screen.dart';
import 'pi_detail_event.dart';
import 'pi_detail_state.dart';
import '../../core/services.dart' as api;

class PIDetailBloc extends Bloc<PIDetailEvent, PIDetailState> {
  PIDetailBloc() : super(PIDetailInitial()) {
    on<LoadPIDetail>((event, emit) async {
      emit(PIDetailLoading());

      try {
        if (event.ownpi || event.otherpi) {
          // Si your ownpiflow logic
          // await ownpiflow(event.ownpi, event.otherpi);
        } else {
          // Simulate your hitapi logic
          // await hitapi(event.ishitapi, event.preinsid, event.partid);
        }

        emit(const BranchListLoaded(getList: []));
      } catch (error) {
        emit(PIDetailError(message: error.toString()));
      }
    });
    on<ChooseDDValue>(selectddvalue);
    on<FetchBranchNameApi>(getBranchDetail);
    on<FetchLoadComboApi>(getLoadComboDetail);
    on<ShowEndorsementType>(onShowEndorsementType);
    on<FetchVehicleCategoryApi>(getvehiclecategory);
    on<ProductSelected>(onProductSelected);
    on<FetchSeatingCapacity>(getSeatingCapacity);
    on<Fetchgvw>(getgvw);
    on<FetchMakeApi>(getMake);
    on<FetchModelApi>(getModel);
  }

  // Event handler for product selection
  void onProductSelected(ProductSelected event, Emitter<PIDetailState> emit) {
    emit(PIDetailLoading());
    final productCode = _fetchProductCode(event.productName);
    final type = event.api;
    emit(PIDetailProductCodeFetched(productCode, type));
  }

  String _fetchProductCode(String selectedProduct) {
    switch (selectedProduct) {
      case 'TRAILERS':
        return "MOT-PRD-004";
      case 'Misc.-D':
        return "MOT-PRD-006";
      case 'PCCV':
        return "MOT-PRD-005";
      case 'PRIVATE CAR':
        return "MOT-PRD-001";
      case 'MOTORISED-TWO WHEELERS':
        return "MOT-PRD-002";
      case 'GCCV':
        return "MOT-PRD-003";
      default:
        return "";
    }
  }

  selectddvalue(dynamic event, Emitter<PIDetailState> emit) async {
    event.controller.text = await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => DropDownListScreen(
          datalist: event.getList,
          listtype: event.screenName,
        ),
      ),
    );
  }

  getBranchDetail(FetchBranchNameApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading()); // Show loading state while fetching data
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ServiceTransaction.svc/RestService/getMainBranchList",
          jsonEncode({
            "PartySearch": "sgi",
            "searchCondition": "1",
            "Userpartyid": "mobile_test",
            "Userip": "sgi",
            "ROOTORGBY": "102"
          }));
      if (res.statusCode == 200) {
        var resModel = pibranchlistResponseFromJson(res.resBody);
        if (resModel.messageResult.result == 'Success') {
          List<Tuple2<String?, String?>?> branchlist = [];

          for (int i = 0; i < resModel.response.length; i++) {
            branchlist.add(Tuple2(
                resModel.response[i].partyid, resModel.response[i].partyname));
          }
          emit(BranchListLoaded(getList: branchlist));
          // debugPrint(res.resBody);
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: 'Failed to fetch data from API'));
        // Provider.of<PIDetailScreenNotifier>(context, listen: false)
        //     .getpidetailLoadingState(false);
        // // Navigator.pop(context);
        // showDialog(
        //   context: context,
        //   builder: (alertDialogContext) => AlertDialog(
        //     title: const Text(
        //       "Error",
        //       style: TextStyle(color: redcolor, fontSize: 24),
        //     ),
        //     content: const Text("Request Failed!"),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () {
        //           Navigator.pop(alertDialogContext);
        //         },
        //         child: const Text('Ok'),
        //       ),
        //     ],
        //   ),
        // );
      }

      // Example API call
      // final response =
      //     await http.get(Uri.parse('https://api.example.com/data'));

      // if (response.statusCode == 200) {
      //   // Successfully fetched data
      //   emit(PIDetailLoaded(
      //     galleryAccessString: response.body, // Just for illustration
      //     galleryAccess: true,
      //   ));
      // } else {
      //   // Error handling
      //   emit(const PIDetailError(message: 'Failed to fetch data from API'));
      // }
    } catch (e) {
      emit(PIDetailError(message: 'Error: ${e.toString()}'));
    }
  }

  Future<void> getLoadComboDetail(
      FetchLoadComboApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      // API call to fetch data
      api.Response res = await api.ApiService().postRequest(
          "http://shrigenservice.shriramgi.com/SHRIGENSERVICE/ShrigenServices/ServiceTransaction.svc/RestService/GetScreenLoadCombo",
          jsonEncode({"Userip": "", "Userpartyid": event.partyId}));

      if (res.statusCode == 200) {
        var resModel = getLoadComboResponseFromJson(res.resBody);

        if (resModel.messageResult!.result == 'Success') {
          // Lists for the different fields
          List<Tuple2<String, String>> productList = [];
          List<Tuple2<String, String>> piPurposeList = [];
          List<Tuple2<String, String>> fuelTypeList = [];
          List<Tuple2<String, String>> endorsementList = [];

          // Populate product list
          for (var item in resModel.mProductDetailsResObj!) {
            if (item.productname != "TRAILERS") {
              productList
                  .add(Tuple2(item.productid ?? "", item.productname ?? ""));
            }
          }

          // Populate PI Purpose list
          for (var item in resModel.mPreinspectionStatusResObj!) {
            piPurposeList
                .add(Tuple2(item.statusid ?? "", item.statusname ?? ""));
          }

          // Populate Fuel Type list
          for (var item in resModel.mFuelTypeResObj!) {
            fuelTypeList.add(Tuple2("", item.fuelType ?? ""));
          }

          // Populate Endorsement list
          for (var item in resModel.mEndorsementTypertnObj!) {
            endorsementList.add(Tuple2("", item.endorsementCombo ?? ""));
          }

          // Additional conditions based on the values of the controllers (Product, VehicleCategory, etc.)
          final productControllerText = event.name;

          if (productControllerText == "Misc.-D") {
            // Remove specific items from piPurposeList for "Misc.-D"
            piPurposeList.removeWhere((item) =>
                item.item2 ==
                    resModel.mPreinspectionStatusResObj![3].statusname ||
                item.item2 ==
                    resModel.mPreinspectionStatusResObj![5].statusname);
          } else if (productControllerText == "PCCV") {
            // Conditional removal for "PCCV"
            if (event.name.contains("PCCV-4") && event.name.contains(">11")) {
              piPurposeList.removeWhere((item) =>
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![3].statusname ||
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![5].statusname);
            }
          } else if (productControllerText == "GCCV") {
            final vehicleCategoryControllerText = event.name.toUpperCase();
            if (vehicleCategoryControllerText.contains(
                    "GOODS CARRYING MOTORISED THREE WHEELERS AND MOTORISED PEDAL CYCLES-PUBLIC CARRIERS") ||
                vehicleCategoryControllerText.contains(
                    "GOODS CARRYING MOTORISED THREE WHEELERS AND MOTORISED PEDAL CYCLES-PRIVATE CARRIERS")) {
              piPurposeList.removeWhere((item) =>
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![3].statusname ||
                  item.item2 ==
                      resModel.mPreinspectionStatusResObj![5].statusname);
            }
          }

          // Determine which list to send to the dropdown screen based on the name (Product, PI Purpose, Fuel Type, Endorsement)
          List<Tuple2<String, String>> dataList;
          switch (event.name) {
            case "Product":
              dataList = productList;
              // Emit success state with loaded data
              emit(ProductListLoaded(getList: dataList, name: event.name));
              break;
            case "PI Purpose":
              dataList = piPurposeList;
              emit(PiPuroseListLoaded(getList: dataList, name: event.name));
              break;
            case "Fuel Type":
              dataList = fuelTypeList;
              emit(FuelTypeListLoaded(getList: dataList, name: event.name));
              break;
            default:
              dataList = endorsementList;
              emit(EndoresementTypeListLoaded(
                  getList: dataList, name: event.name));
          }
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  void getvehiclecategory(
      FetchVehicleCategoryApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    // Call the API
    try {
      api.Response res = await api.ApiService().postRequest(
          "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/ServiceTransaction.svc/RestService/getProductCategory",
          jsonEncode({
            "Flag": "NEW",
            "Userip": "",
            "Userpartyid": event.partyId,
            "VAP_PROD_CODE": event.vehCode
          }));

      if (res.statusCode == 200) {
        var resModel = vehicleCategoryResponseFromJson(res.resBody);
        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String?, String?>> vehCategoryList = [];

          for (int i = 0; i < resModel.response!.length; i++) {
            vehCategoryList.add(Tuple2(
                resModel.response![i].pcCode, resModel.response![i].pcDesc));
          }
          vehCategoryList
              .sort((a, b) => (a.item2 ?? "").compareTo(b.item2 ?? ""));

          emit(VehicleCategoryListLoaded(getList: vehCategoryList));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  getSeatingCapacity(FetchSeatingCapacity event, Emitter<PIDetailState> emit) {
    List<Tuple2<String, String>> seatingCapacityList = [];

    // Hardcoded seating capacity list
    List<dynamic> seatingCapacityListData = ["UPTO 10+1", ">11"];
    for (var seating in seatingCapacityListData) {
      seatingCapacityList.add(Tuple2("", seating));
    }

    // Emit the loaded seating capacity state
    emit(SeatingCapacityLoaded(getList: seatingCapacityList));
  }

  getgvw(Fetchgvw event, Emitter<PIDetailState> emit) {
    List<Tuple2<String, String>> gvwList = [];

    // Hardcoded seating capacity list
    List<dynamic> gvwListData = ["UPTO 2500 GVW", "UPTO 7500 GVW", ">7500 GVW"];
    for (var gvw in gvwListData) {
      gvwList.add(Tuple2("", gvw));
    }

    // Emit the loaded seating capacity state
    emit(GVWLoaded(getList: gvwList));
  }

  getMake(FetchMakeApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      api.Response res = await api.ApiService().postRequest(
        "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/GetVehicleMakeDetails",
        jsonEncode({
          "Userip": "",
          "Userpartyid": event.partyId,
          "PremiaPoductCode": event.productCode,
          "ProductCategory": ""
        }),
      );

      if (res.statusCode == 200) {
        var resModel = makeResponseFromJson(res.resBody);

        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String, String>> makeList = [];

          for (var vehicleMakeDetail in resModel.vehicleMakeDetails!) {
            makeList.add(Tuple2(vehicleMakeDetail.vehicleMakeCode ?? "",
                vehicleMakeDetail.vehicleMakeDesc ?? ""));
          }

          emit(MakeListLoaded(getList: makeList));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  String makecode = "";

  getModel(FetchModelApi event, Emitter<PIDetailState> emit) async {
    emit(PIDetailLoading());

    try {
      api.Response res = await api.ApiService().postRequest(
        "http://novaapiuat.shriramgi.com/UATShrigenAppService2.0/ShrigenServices/PreInspectionDetails.svc/RestService/GetVehicleMakeDetails",
        jsonEncode({
          "Userip": "",
          "Userpartyid": event.partyId,
          "PremiaPoductCode": event.productCode,
          "ProductCategory": "",
          "VehicleMake": event.makeCode
        }),
      );

      if (res.statusCode == 200) {
        var resModel = modelResponseFromJson(res.resBody);

        if (resModel.messageResult!.result == 'Success') {
          List<Tuple2<String, String>> modelList = [];

          for (var vehicleMakeDetail in resModel.vehicleModelDetails!) {
            modelList.add(Tuple2(vehicleMakeDetail.vehicleModel ?? "",
                vehicleMakeDetail.modelDesc ?? ""));
          }

          emit(ModelListLoaded(getList: modelList));
        } else {
          emit(PIDetailError(
              message:
                  resModel.messageResult?.errorMessage ?? "Request Failed!"));
        }
      } else {
        emit(const PIDetailError(message: "Request Failed!"));
      }
    } catch (e) {
      emit(PIDetailError(message: e.toString()));
    }
  }

  onShowEndorsementType(
      ShowEndorsementType event, Emitter<PIDetailState> emit) {
    if (event.piPurpose == "Endorsement") {
      emit(const PIDetailShowEndorsementState(
        isShowEndorsementType: true,
        isShowPolicyNumber: true,
      ));
    } else {
      emit(const PIDetailShowEndorsementState(
        isShowEndorsementType: false,
        isShowPolicyNumber: false,
      ));
    }
  }
}
