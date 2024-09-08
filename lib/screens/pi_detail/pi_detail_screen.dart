import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mnovapi/utils/widgets/drop_down_pi_widget.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'dart:ui' as ui;

import '../../bloc/pi_detail/pi_detail_bloc.dart';
import '../../bloc/pi_detail/pi_detail_event.dart';
import '../../bloc/pi_detail/pi_detail_state.dart';
import '../../utils/constant.dart';
import '../../utils/widgets/custom_bottom_clipper.dart';
import '../../utils/widgets/text_field_pi_widget.dart';

class PIDetailScreen extends StatefulWidget {
  final String preinsid;
  final bool hitapiflow;
  final bool iseditable;
  final bool otherflow;
  final bool ownflow;
  final Position position;
  final Placemark place;

  const PIDetailScreen({
    super.key,
    required this.preinsid,
    required this.hitapiflow,
    required this.iseditable,
    required this.otherflow,
    required this.ownflow,
    required this.position,
    required this.place,
  });
  @override
  State<PIDetailScreen> createState() => _PIDetailScreenState();
}

class _PIDetailScreenState extends State<PIDetailScreen> {
  final TextEditingController branchnametextcontoller = TextEditingController();
  final TextEditingController surveyornametextcontoller =
      TextEditingController();
  final TextEditingController producttextcontoller = TextEditingController();
  final TextEditingController vehiclecategorytextcontoller =
      TextEditingController();
  final TextEditingController seatingCapcitytextcontoller =
      TextEditingController();
  final TextEditingController gvwtextcontoller = TextEditingController();
  final TextEditingController pipurposetextcontoller = TextEditingController();
  final TextEditingController endoresementtypetextcontoller =
      TextEditingController();
  final TextEditingController policynumbertextcontoller =
      TextEditingController();
  final TextEditingController maketextcontoller = TextEditingController();
  final TextEditingController modeltextcontoller = TextEditingController();
  final TextEditingController fueltypetextcontoller = TextEditingController();
  final TextEditingController rtocodetextcontoller = TextEditingController();
  final TextEditingController rtonametextcontoller = TextEditingController();
  final TextEditingController yearofmanuftextcontoller =
      TextEditingController();
  final TextEditingController enginenumbertextcontoller =
      TextEditingController();
  final TextEditingController chassisnumbertextcontoller =
      TextEditingController();
  final TextEditingController idvtextcontoller = TextEditingController();
  final TextEditingController prefixtextcontoller = TextEditingController();
  final TextEditingController insurednametextcontoller =
      TextEditingController();
  final TextEditingController inspectionlocationtextcontoller =
      TextEditingController();
  final TextEditingController proposaltypetextcontoller =
      TextEditingController();
  final TextEditingController sgicpolicynumbertextcontoller =
      TextEditingController();
  final TextEditingController odometertextcontoller = TextEditingController();
  final TextEditingController preinspectionstatustextcontoller =
      TextEditingController();
  final TextEditingController ncbtextcontoller = TextEditingController();
  final TextEditingController dentedpartstextcontoller =
      TextEditingController();
  final TextEditingController scratchedpartstextcontoller =
      TextEditingController();
  final TextEditingController modeofpaymenttextcontoller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => PIDetailBloc(),
      child: BlocConsumer<PIDetailBloc, PIDetailState>(
          listener: (context, state) async {
        if (state is BranchListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: branchnametextcontoller,
              getList: state.getList,
              screenName: "Branch",
              context: context));
        } else if (state is ProductListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: producttextcontoller,
              getList: state.getList,
              screenName: "Product",
              context: context));
        } else if (state is FuelTypeListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: fueltypetextcontoller,
              getList: state.getList,
              screenName: "Fuel Type",
              context: context));
        } else if (state is PIDetailProductCodeFetched) {
          state.api == "vc"
              ? {
                  context.read<PIDetailBloc>().add(FetchVehicleCategoryApi(
                      partyId: "100000000138661", vehCode: state.productCode))
                }
              : state.api == "make"
                  ? {
                      context.read<PIDetailBloc>().add(FetchMakeApi(
                          partyId: "100000000138661",
                          productCode: state.productCode))
                    }
                  : {
                      context.read<PIDetailBloc>().add(FetchModelApi(
                          partyId: "100000000138661",
                          productCode: state.productCode,
                          makeCode: ''))
                    };
          debugPrint(state.productCode);
        } else if (state is VehicleCategoryListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: vehiclecategorytextcontoller,
              getList: state.getList,
              screenName: "Vehicle Category",
              context: context));
        } else if (state is SeatingCapacityLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: seatingCapcitytextcontoller,
              getList: state.getList,
              screenName: "Seating Capacity",
              context: context));
        } else if (state is GVWLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: gvwtextcontoller,
              getList: state.getList,
              screenName: "Gross Vehicle Weight",
              context: context));
        } else if (state is PiPuroseListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: pipurposetextcontoller,
              getList: state.getList,
              screenName: "PI Purpose",
              context: context));
        } else if (state is EndoresementTypeListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: endoresementtypetextcontoller,
              getList: state.getList,
              screenName: "Endoresement Type",
              context: context));
        } else if (state is MakeListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: maketextcontoller,
              getList: state.getList,
              screenName: "Make",
              context: context));
        } else if (state is ModelListLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: modeltextcontoller,
              getList: state.getList,
              screenName: "Model",
              context: context));
        } else if (state is IdvLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: idvtextcontoller,
              getList: state.getList,
              screenName: "IDV",
              context: context));
        } else if (state is PrefixLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: prefixtextcontoller,
              getList: state.getList,
              screenName: "Prefix",
              context: context));
        } else if (state is ProposalTypeLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: proposaltypetextcontoller,
              getList: state.getList,
              screenName: "Proposal Type",
              context: context));
        } else if (state is PreInspectionLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: preinspectionstatustextcontoller,
              getList: state.getList,
              screenName: "Pre Inspection",
              context: context));
        } else if (state is NCBLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: ncbtextcontoller,
              getList: state.getList,
              screenName: "NCB",
              context: context));
        } else if (state is PaymentLoaded) {
          context.read<PIDetailBloc>().add(ChooseDDValue(
              controller: modeofpaymenttextcontoller,
              getList: state.getList,
              screenName: "Mode of Payment",
              context: context));
        } else if (state is PIDetailShowEndorsementState) {
          debugPrint("isShowEndorsementType: ${state.isShowEndorsementType}");
          debugPrint("isShowPolicyNumber: ${state.isShowPolicyNumber}");
        }
      }, builder: (context, state) {
        // inspectionlocationtextcontoller.text = widget.place.postalCode ?? "";
        bool? isShowEndorsementType;
        bool isShowPolicyNumber;

        if (state is PIDetailShowEndorsementState) {
          isShowEndorsementType = state.isShowEndorsementType;
          isShowPolicyNumber = state.isShowPolicyNumber;
          debugPrint("Endoresement 1- $isShowEndorsementType");
          debugPrint("Endoresement 2- ${state.isShowEndorsementType}");
        }
        return OverlayLoaderWithAppIcon(
          appIconSize: 60,
          circularProgressColor: Colors.transparent,
          overlayBackgroundColor: Colors.black87,
          isLoading: state is PIDetailLoading,
          appIcon: Image.asset(
            'assest/loadgif.gif',
          ),
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: appcolor,
                title: const Text('PreInspection'),
                centerTitle: true),
            body: SingleChildScrollView(
              child: Container(
                height: height / 1.1,
                width: width,
                color: Colors.grey.shade300,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CurvedBottomClipper(),
                      child: Container(
                        height: height / 4,
                        width: width,
                        color: appcolor,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: SizedBox(
                          height: height / 1.13,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                child: Form(
                                  //   key: provider.formKey,
                                  child: IgnorePointer(
                                    ignoring:
                                        false /* provider.allowedit(context) */,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DropDownPiWidget(
                                          controller: branchnametextcontoller,
                                          labelText: "Branch Name",
                                          onTap: () async {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(FetchBranchNameApi());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          controller: surveyornametextcontoller,
                                          labelText: "Surveyor Name",
                                          suffixIcon: widget.otherflow
                                              ? const IconButton(
                                                  onPressed: null,
                                                  icon: Icon(Icons.search))
                                              : null,
                                        ),
                                        DropDownPiWidget(
                                          controller: producttextcontoller,
                                          labelText: "Product",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                const FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "Product"));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller:
                                              vehiclecategorytextcontoller,
                                          labelText: "Vehicle Category",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                ProductSelected(
                                                    producttextcontoller.text,
                                                    "vc"));

                                            // context.read<PIDetailBloc>().add(
                                            //     FetchVehicleCategoryApi(
                                            //         partyId: "100000000138661",
                                            //         vehCode: state
                                            //                 is PIDetailProductCodeFetched
                                            //             ? state.productCode
                                            //             : ""));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller:
                                              seatingCapcitytextcontoller,
                                          labelText: "Seating Capacity",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(FetchSeatingCapacity());
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: gvwtextcontoller,
                                          labelText: "Gross Vehicle Weight",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(Fetchgvw());
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: pipurposetextcontoller,
                                          labelText: "PI Purpose",
                                          onTap: () async {
                                            context.read<PIDetailBloc>().add(
                                                const FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "PI Purpose"));
                                          },
                                        ),
                                        Visibility(
                                          visible:
                                              true /*  provider
                                                                    .productcontroller
                                                                    .text ==
                                                                "PRIVATE CAR" */
                                          ,
                                          child: Column(
                                            children: [
                                              Visibility(
                                                visible:
                                                    true /*  provider
                                                                              .pipuposecontroller
                                                                              .text ==
                                                                          "Nil Dep." ||
                                                                      provider.pipuposecontroller
                                                                              .text ==
                                                                          "Break-In with Nil Dep." */
                                                ,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                  child: TextFormField(
                                                    // key: provider
                                                    //     .engineprotectorcoverkey,
                                                    onTap: () {
                                                      // provider
                                                      //     .showprotectorcoverselectvalue();
                                                    },
                                                    // controller: provider
                                                    //     .protectorcoverrequiredcontroller,
                                                    cursorColor: Colors.black,
                                                    cursorHeight: 20,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Does Engine Protector Cover Required?",
                                                      hintTextDirection:
                                                          ui.TextDirection.ltr,
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      suffixIcon: IconButton(
                                                          onPressed: () {
                                                            // provider
                                                            //     .showprotectorcoverselectvalue();
                                                          },
                                                          icon: const Icon(Icons
                                                              .arrow_drop_down)),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 14.0,
                                                              bottom: 8.0,
                                                              top: 8.0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    true /* provider
                                                                              .productcontroller
                                                                              .text ==
                                                                          "PRIVATE CAR" &&
                                                                      provider
                                                                          .isprotectedcoverrequired */
                                                ,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        tileColor:
                                                            greycolor.shade100,
                                                        title: const Center(
                                                            child: Text("Yes")),
                                                        onTap: () {
                                                          // provider
                                                          //     .selectyesprotectorcovervalue();
                                                        },
                                                      ),
                                                      const Divider(),
                                                      ListTile(
                                                        tileColor:
                                                            greycolor.shade100,
                                                        title: const Center(
                                                            child: Text("No")),
                                                        onTap: () {
                                                          // provider
                                                          //     .selectnoprotectorcovervalue();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Visibility(
                                          visible:
                                              true /* provider
                                                                    .productcontroller
                                                                    .text ==
                                                                "PRIVATE CAR" */
                                          ,
                                          child: Visibility(
                                            visible:
                                                true /* provider
                                                                          .pipuposecontroller
                                                                          .text ==
                                                                      "Nil Dep." ||
                                                                  provider.pipuposecontroller
                                                                          .text ==
                                                                      "Break-In with Nil Dep." */
                                            ,
                                            child: SizedBox(
                                              height: 10,
                                            ),
                                          ),
                                        ),
                                        DropDownPiWidget(
                                          // visible:
                                          //     isShowEndorsementType ?? false,
                                          controller:
                                              endoresementtypetextcontoller,
                                          labelText: "Endorsement Type",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                const FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "Endorsement Type"));
                                          },
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          // visible: isShowPolicyNumber,
                                          labelText: "Policy Number",
                                        ),
                                        DropDownPiWidget(
                                          controller: maketextcontoller,
                                          labelText: "Make",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                ProductSelected(
                                                    producttextcontoller.text,
                                                    "make"));
                                            //  context.read<PIDetailBloc>().add(
                                            //     FetchMakeApi(
                                            //       partyId: ,
                                            //       productCode: ,
                                            //        ));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: modeltextcontoller,
                                          labelText: "Model",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                ProductSelected(
                                                    producttextcontoller.text,
                                                    "model"));
                                            // BlocProvider.of<PIDetailBloc>(
                                            //         context)
                                            //     .add(
                                            //   const FetchModelApi(
                                            //       partyId: "100000000138661",
                                            //       productCode: "",
                                            //       makeCode: ),
                                            // );
                                            // context.read<PIDetailBloc>().add(
                                            //     ProductSelected(
                                            //         producttextcontoller.text,
                                            //         "model"));
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: fueltypetextcontoller,
                                          labelText: "Fuel Type",
                                          onTap: () {
                                            context.read<PIDetailBloc>().add(
                                                const FetchLoadComboApi(
                                                    partyId: "100000000138661",
                                                    name: "Fuel Type"));
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          readOnly: true,
                                          labelText: "Vehicle Type",
                                          suffixIcon: Switch(
                                            onChanged:
                                                (value) {} /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                true /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Registration Type",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              false /*  widget.ishitapi ||
                                                                provider.issubmitted */
                                          ,
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue:
                                                    null /*  provider
                                                                      .selectedregistrationtypeRadio */
                                                ,
                                                activeColor: Colors.green,
                                                onChanged: (value) {
                                                  // provider
                                                  //     .setregistrationtypeSelectedRadio(
                                                  //         value!);
                                                },
                                              ),
                                              const Text('Normal'),
                                              const SizedBox(width: 20),
                                              Radio(
                                                value: 2,
                                                groupValue:
                                                    null /*  provider
                                                                      .selectedregistrationtypeRadio */
                                                ,
                                                activeColor: Colors.green,
                                                onChanged: (value) {
                                                  // provider
                                                  //     .setregistrationtypeSelectedRadio(
                                                  //         value!);
                                                },
                                              ),
                                              const Text('Bharat'),
                                            ],
                                          ),
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "RTO Code",
                                          suffixIcon: IconButton(
                                              onPressed: null,
                                              icon: Icon(Icons.search)),
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "RTO Name",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.otherflow,
                                          readOnly: true,
                                          labelText:
                                              "Registration Number Format",
                                          suffixIcon: Switch(
                                            onChanged:
                                                (value) {} /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                true /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Registration Number",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  maxLength: 2,
                                                  // inputFormatters: <TextInputFormatter>[
                                                  //   FilteringTextInputFormatter
                                                  //       .allow(RegExp(
                                                  //           "[0-9a-zA-Z]")),
                                                  // ],
                                                  onChanged: (value) {
                                                    // if (provider
                                                    //         .selectedregistrationtypeRadio ==
                                                    //     2) {
                                                    //   if (value.length ==
                                                    //       2) {
                                                    //     var dateTime =
                                                    //         DateTime
                                                    //             .now();
                                                    //     var currentyear =
                                                    //         DateFormat(
                                                    //                 "yy")
                                                    //             .format(
                                                    //                 dateTime);
                                                    //     var currectyearone =
                                                    //         int.parse(
                                                    //                 currentyear) -
                                                    //             1;
                                                    //     var currectyeartwo =
                                                    //         int.parse(
                                                    //                 currentyear) -
                                                    //             2;
                                                    //     var currectyearthree =
                                                    //         int.parse(
                                                    //                 currentyear) -
                                                    //             3;
                                                    //     debugPrint(
                                                    //         "$currentyear $currectyearone $currectyeartwo $currectyearthree");
                                                    //     if (provider.regisnumberonecontroller.text ==
                                                    //             currentyear ||
                                                    //         provider.regisnumberonecontroller
                                                    //                 .text ==
                                                    //             currectyearone
                                                    //                 .toString() ||
                                                    //         provider.regisnumberonecontroller
                                                    //                 .text ==
                                                    //             currectyeartwo
                                                    //                 .toString()) {
                                                    //     } else {
                                                    //       provider
                                                    //           .regisnumberonecontroller
                                                    //           .text = "";
                                                    //       showDialog(
                                                    //         context:
                                                    //             context,
                                                    //         builder:
                                                    //             (alertDialogContext) =>
                                                    //                 AlertDialog(
                                                    //           content: SizedBox(
                                                    //               height: 60,
                                                    //               width: 60,
                                                    //               child: Center(
                                                    //                   child: Text(
                                                    //                 "Please enter the value greater than $currectyearthree and lesser than or equal to current year",
                                                    //                 style:
                                                    //                     const TextStyle(color: redcolor),
                                                    //               ))),
                                                    //         ),
                                                    //       );
                                                    //     }
                                                    //   }
                                                    // }
                                                  },
                                                  // controller: provider
                                                  //     .regisnumberonecontroller,
                                                  // focusNode: provider
                                                  //     .focusregisnumberone,
                                                  // readOnly:
                                                  //     provider.selectedregistrationtypeRadio ==
                                                  //             2
                                                  //         ? false
                                                  //         : true,
                                                  cursorColor: Colors.black,
                                                  cursorHeight: 20,
                                                  // keyboardType:
                                                  //     provider.selectedregistrationtypeRadio ==
                                                  //             2
                                                  //         ? TextInputType
                                                  //             .number
                                                  //         : TextInputType
                                                  //             .name,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    hintTextDirection:
                                                        ui.TextDirection.ltr,
                                                    filled: true,
                                                    fillColor:
                                                        const Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  onChanged: (value) {},
                                                  // controller: provider
                                                  //     .regisnumbertwocontroller,
                                                  cursorColor: Colors.black,
                                                  cursorHeight: 20,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    hintTextDirection:
                                                        ui.TextDirection.ltr,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Visibility(
                                                visible:
                                                    true /*  provider
                                                                              .selectedregistrationtypeRadio ==
                                                                          2 ||
                                                                      provider
                                                                          .isregistrationnumberformat */
                                                ,
                                                child: Expanded(
                                                  child: TextFormField(
                                                    // maxLength:
                                                    //     provider.selectedregistrationtypeRadio ==
                                                    //             2
                                                    //         ? 4
                                                    //         : 3,
                                                    onChanged: (value) {
                                                      // if (provider
                                                      //         .selectedregistrationtypeRadio ==
                                                      //     1) {
                                                      //   if (value
                                                      //       .isNotEmpty) {
                                                      //     if (RegExp(
                                                      //             r'^[0-9]*$')
                                                      //         .hasMatch(
                                                      //             value)) {
                                                      //       provider
                                                      //           .regisnumberthreecontroller
                                                      //           .text = "";
                                                      //       showDialog(
                                                      //         context:
                                                      //             context,
                                                      //         builder:
                                                      //             (alertDialogContext) =>
                                                      //                 const AlertDialog(
                                                      //           content: SizedBox(
                                                      //               height: 60,
                                                      //               width: 60,
                                                      //               child: Center(
                                                      //                   child: Text(
                                                      //                 "Only alphabets are allowed",
                                                      //                 style:
                                                      //                     TextStyle(color: redcolor),
                                                      //               ))),
                                                      //         ),
                                                      //       );
                                                      //     }
                                                      //   }
                                                      // }
                                                    },
                                                    // inputFormatters: <TextInputFormatter>[
                                                    //   FilteringTextInputFormatter
                                                    //       .allow(RegExp(
                                                    //           "[0-9a-zA-Z]")),
                                                    // ],
                                                    // controller: provider
                                                    //     .regisnumberthreecontroller,
                                                    // focusNode: provider
                                                    //     .focusregisnumberthree,
                                                    cursorColor: Colors.black,
                                                    cursorHeight: 20,
                                                    // keyboardType: provider
                                                    //             .selectedregistrationtypeRadio ==
                                                    //         2
                                                    //     ? TextInputType
                                                    //         .number
                                                    //     : TextInputType
                                                    //         .text,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .characters,
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                      hintTextDirection:
                                                          ui.TextDirection.ltr,
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 14.0,
                                                              bottom: 8.0,
                                                              top: 8.0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: greycolor
                                                              .shade400,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Visibility(
                                                visible:
                                                    true /* provider
                                                                              .selectedregistrationtypeRadio ==
                                                                          2 ||
                                                                      provider
                                                                          .isregistrationnumberformat */
                                                ,
                                                child: SizedBox(
                                                  width: 10,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  // maxLength:
                                                  //     provider.selectedregistrationtypeRadio ==
                                                  //             2
                                                  //         ? 2
                                                  //         : 4,
                                                  // inputFormatters: <TextInputFormatter>[
                                                  //   FilteringTextInputFormatter
                                                  //       .allow(RegExp(
                                                  //           "[0-9a-zA-Z]")),
                                                  // ],
                                                  onChanged: (value) {
                                                    // if (provider
                                                    //         .selectedregistrationtypeRadio ==
                                                    //     2) {
                                                    //   if (RegExp(
                                                    //           r'^[a-zA-Z]*$')
                                                    //       .hasMatch(
                                                    //           value)) {
                                                    //     if (value
                                                    //             .toUpperCase()
                                                    //             .contains(
                                                    //                 "I") ||
                                                    //         value
                                                    //             .toUpperCase()
                                                    //             .contains(
                                                    //                 "O")) {
                                                    //       provider
                                                    //           .regisnumberfourcontroller
                                                    //           .text = "";
                                                    //       showDialog(
                                                    //         context:
                                                    //             context,
                                                    //         builder:
                                                    //             (alertDialogContext) =>
                                                    //                 const AlertDialog(
                                                    //           content: SizedBox(
                                                    //               height: 60,
                                                    //               width: 60,
                                                    //               child: Center(
                                                    //                   child: Text(
                                                    //                 "Registration Number Should Not Contain \"I\" and \"O\"",
                                                    //                 style:
                                                    //                     TextStyle(color: redcolor),
                                                    //               ))),
                                                    //         ),
                                                    //       );
                                                    //     }
                                                    //   } else {
                                                    //     provider
                                                    //         .regisnumberfourcontroller
                                                    //         .text = "";
                                                    //     showDialog(
                                                    //       context:
                                                    //           context,
                                                    //       builder:
                                                    //           (alertDialogContext) =>
                                                    //               const AlertDialog(
                                                    //         content: SizedBox(
                                                    //             height: 60,
                                                    //             width: 60,
                                                    //             child: Center(
                                                    //                 child: Text(
                                                    //               "Only alphabets are allowed",
                                                    //               style: TextStyle(
                                                    //                   color:
                                                    //                       redcolor),
                                                    //             ))),
                                                    //       ),
                                                    //     );
                                                    //   }
                                                    // }
                                                  },
                                                  // controller: provider
                                                  //     .regisnumberfourcontroller,
                                                  // focusNode: provider
                                                  //     .focusregistrationfournumber,
                                                  cursorColor: Colors.black,
                                                  cursorHeight: 20,
                                                  // keyboardType: provider
                                                  //             .selectedregistrationtypeRadio ==
                                                  //         2
                                                  //     ? TextInputType.text
                                                  //     : TextInputType
                                                  //         .number,
                                                  // textCapitalization: provider
                                                  //             .selectedregistrationtypeRadio ==
                                                  //         2
                                                  //     ? TextCapitalization
                                                  //         .characters
                                                  //     : TextCapitalization
                                                  //         .none,
                                                  onTapOutside: (event) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    hintTextDirection:
                                                        ui.TextDirection.ltr,
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 14.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            greycolor.shade400,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Year Of Manufacturing",
                                          suffixIcon: IconButton(
                                              onPressed: null,
                                              icon: Icon(Icons.date_range)),
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Engine Number",
                                          maxLength: 30,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Chassis Number",
                                          maxLength: 30,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                        ),
                                        DropDownPiWidget(
                                          controller: idvtextcontoller,
                                          labelText: "IDV Of Vehicle",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(IdvSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: widget.otherflow,
                                          labelText: "Contact Person",
                                        ),
                                        TextFieldPiWidget(
                                          ignoring: false,
                                          visible: widget.otherflow,
                                          labelText: "Contact Mobile Number",
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                          onChanged: (value) {
                                            if (int.parse(value) < 6) {}
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: prefixtextcontoller,
                                          labelText: "Prefix",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(PrefixSelect());
                                          },
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Insured Name",
                                        ),
                                        TextFieldPiWidget(
                                          controller:
                                              inspectionlocationtextcontoller,
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Inspection Location",
                                          suffixIcon: const IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                  Icons.my_location_sharp)),
                                        ),
                                        DropDownPiWidget(
                                          controller: proposaltypetextcontoller,
                                          labelText: "Proposal Type",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(ProposalTypeSelect());
                                          },
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "SGIC Policy Number",
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          labelText: "Odometer Reading",
                                          keyboardType: TextInputType.number,
                                          maxLength: 8,
                                          inputformat: "number",
                                          onChanged: (value) {},
                                        ),
                                        DropDownPiWidget(
                                          controller:
                                              preinspectionstatustextcontoller,
                                          visible: !widget.otherflow,
                                          labelText: "Pre-Inspection Status",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(PreInspectionSelect());
                                          },
                                        ),
                                        DropDownPiWidget(
                                          controller: ncbtextcontoller,
                                          labelText: "Eligible NCB%",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(NCBSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          readOnly: true,
                                          labelText: "RC Verified",
                                          suffixIcon: Switch(
                                            onChanged:
                                                (value) {} /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                true /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Dented Parts",
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Scratched Parts",
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Broken Parts",
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          readOnly: true,
                                          labelText:
                                              "Vehicle Runninig Condition",
                                          suffixIcon: Switch(
                                            onChanged:
                                                (value) {} /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                true /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          labelText: "Surveyor Remarks",
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Current Status",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.hitapiflow,
                                          labelText:
                                              "Approve/Reject/Hold Remarks",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.hitapiflow,
                                          labelText: "Details Remarks",
                                        ),
                                        IgnorePointer(
                                          ignoring: false
                                          //  provider
                                          //             .currentstatuscontroller
                                          //             .text ==
                                          //         "Survey On Hold"
                                          //     ? false
                                          //     :
                                          /*     widget.ishitapi ||
                                                                    provider.issubmitted */
                                          ,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: greycolor.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "RC Copy",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: /*  provider
                                                                                    .isrccopyupload
                                                                                ? null
                                                                                : */
                                                              () {
                                                            // provider
                                                            //         .isrccopyupload
                                                            //     ? showDialog(
                                                            //         context:
                                                            //             context,
                                                            //         builder: (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //           content:
                                                            //               const Wrap(
                                                            //             children: [
                                                            //               Center(
                                                            //                   child: Text(
                                                            //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
                                                            //                 style: TextStyle(color: redcolor),
                                                            //               )),
                                                            //             ],
                                                            //           ),
                                                            //           actions: [
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                 },
                                                            //                 child: const Text("Cancel")),
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                   provider.deleterccopy("RC Copy");
                                                            //                 },
                                                            //                 child: const Text("Delete")),
                                                            //           ],
                                                            //         ),
                                                            //       )
                                                            //     : provider.showbottomsheet(
                                                            //         "RC Copy",
                                                            //         context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.upload),
                                                          color: /*  provider
                                                                                    .isrccopyupload
                                                                                ? greycolor
                                                                                : */
                                                              Colors.green,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // if (provider
                                                            //     .isrccopyupload) {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "Do you want to delete the file",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Cancel")),
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //               provider.deleterccopy("RC Copy");
                                                            //             },
                                                            //             child: const Text("Delete")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "No file available to delete",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Ok")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              true /*  provider
                                                                                .isrccopyupload */
                                                          ,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              false /*  widget.ishitapi ||
                                                                provider.issubmitted */
                                          ,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: greycolor.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Previous Policy",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: /* provider
                                                                                    .ispreviouspolicyupload
                                                                                ? null
                                                                                :  */
                                                              () {
                                                            // provider
                                                            //         .ispreviouspolicyupload
                                                            //     ? showDialog(
                                                            //         context:
                                                            //             context,
                                                            //         builder: (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //           content:
                                                            //               const Wrap(
                                                            //             children: [
                                                            //               Center(
                                                            //                   child: Text(
                                                            //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
                                                            //                 style: TextStyle(color: redcolor),
                                                            //               )),
                                                            //             ],
                                                            //           ),
                                                            //           actions: [
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                 },
                                                            //                 child: const Text("Cancel")),
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                   provider.deletepreviouspolicy("Previous Policy");
                                                            //                 },
                                                            //                 child: const Text("Delete")),
                                                            //           ],
                                                            //         ),
                                                            //       )
                                                            //     : provider.showbottomsheet(
                                                            //         "Previous Policy",
                                                            //         context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.upload),
                                                          color: /* provider
                                                                                    .ispreviouspolicyupload
                                                                                ? greycolor
                                                                                : */
                                                              Colors.green,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // if (provider
                                                            //     .ispreviouspolicyupload) {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "Do you want to delete the file",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Cancel")),
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //               provider.deletepreviouspolicy("Previous Policy");
                                                            //             },
                                                            //             child: const Text("Delete")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "No file available to delete",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Ok")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              true /*  provider
                                                                                .ispreviouspolicyupload */
                                                          ,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          ignoring:
                                              false /*  widget.ishitapi ||
                                                                provider.issubmitted */
                                          ,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: greycolor.shade400,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Invoice Copy",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: /* provider
                                                                                    .isinvoicecopyupload
                                                                                ? null
                                                                                :  */
                                                              () {
                                                            // provider
                                                            //         .isinvoicecopyupload
                                                            //     ? showDialog(
                                                            //         context:
                                                            //             context,
                                                            //         builder: (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //           content:
                                                            //               const Wrap(
                                                            //             children: [
                                                            //               Center(
                                                            //                   child: Text(
                                                            //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
                                                            //                 style: TextStyle(color: redcolor),
                                                            //               )),
                                                            //             ],
                                                            //           ),
                                                            //           actions: [
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                 },
                                                            //                 child: const Text("Cancel")),
                                                            //             TextButton(
                                                            //                 onPressed: () {
                                                            //                   Navigator.pop(context);
                                                            //                   provider.deleteinvoicecopy("Invoice Copy");
                                                            //                 },
                                                            //                 child: const Text("Delete")),
                                                            //           ],
                                                            //         ),
                                                            //       )
                                                            //     : provider.showbottomsheet(
                                                            //         "Invoice Copy",
                                                            //         context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.upload),
                                                          color: /*  provider
                                                                                    .isinvoicecopyupload
                                                                                ? greycolor
                                                                                : */
                                                              Colors.green,
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            // if (provider
                                                            //     .isinvoicecopyupload) {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "Do you want to delete the file",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Cancel")),
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //               provider.deleteinvoicecopy("Invoice Copy");
                                                            //             },
                                                            //             child: const Text("Delete")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            //   showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     builder:
                                                            //         (alertDialogContext) =>
                                                            //             AlertDialog(
                                                            //       content:
                                                            //           const Wrap(
                                                            //         children: [
                                                            //           Center(
                                                            //               child: Text(
                                                            //             "No file available to delete",
                                                            //             style: TextStyle(color: redcolor),
                                                            //           )),
                                                            //         ],
                                                            //       ),
                                                            //       actions: [
                                                            //         TextButton(
                                                            //             onPressed: () {
                                                            //               Navigator.pop(context);
                                                            //             },
                                                            //             child: const Text("Ok")),
                                                            //       ],
                                                            //     ),
                                                            //   );
                                                            // }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.red,
                                                        ),
                                                        Visibility(
                                                          visible:
                                                              true /*  provider
                                                                                .isinvoicecopyupload */
                                                          ,
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.verified),
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextFieldPiWidget(
                                          visible: !widget.otherflow,
                                          readOnly: true,
                                          labelText: "PI Fee Collected",
                                          suffixIcon: Switch(
                                            onChanged:
                                                (value) {} /*  provider
                                                                        .pifeecollectedtoggleSwitch */
                                            ,
                                            value:
                                                true /* provider
                                                                        .ispifeescollected */
                                            ,
                                            activeColor: const Color(kAppTheme),
                                            activeTrackColor: greycolor,
                                            inactiveThumbColor:
                                                Colors.redAccent,
                                            inactiveTrackColor: greycolor,
                                          ),
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "PI Fee Amount",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                        ),
                                        const TextFieldPiWidget(
                                          ignoring: false,
                                          visible: true,
                                          labelText: "Conveyance Amount",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                        ),
                                        DropDownPiWidget(
                                          controller:
                                              modeofpaymenttextcontoller,
                                          labelText: "Mode Of Payment",
                                          onTap: () {
                                            context
                                                .read<PIDetailBloc>()
                                                .add(PaymentSelect());
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.otherflow,
                                          maxLength: 10,
                                          labelText: "Contact no for SMS",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                          onChanged: (value) {
                                            if (int.parse(value) < 6) {}
                                          },
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.otherflow,
                                          labelText: "Intimation Remarks",
                                        ),
                                        TextFieldPiWidget(
                                          visible: widget.otherflow,
                                          maxLength: 10,
                                          labelText:
                                              "Contact no to send link for self PI",
                                          keyboardType: TextInputType.number,
                                          inputformat: "number",
                                          onChanged: (value) {
                                            if (int.parse(value) < 6) {}
                                          },
                                        ),

                                        /*   !(provider.intimationstatus ==
                                                                          "Survey On Hold" ||
                                                                      provider.intimationstatus ==
                                                                          "Request Assign to Surveyor") &&
                                                                  (widget.ishitapi ||
                                                                      provider.issubmitted)
                                                              ? const SizedBox()
                                                              : */
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  // provider.ifelsecondigtionforsubmit(
                                                  //     widget.ownpi,
                                                  //     widget
                                                  //         .otherpi,
                                                  //     widget
                                                  //         .ishitapi,
                                                  //     context);
                                                },
                                                child: const Text("Submit")),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),

            //  Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Latitude: ${position.latitude}'),
            //       Text('Longitude: ${position.longitude}'),
            //       const SizedBox(height: 10),
            //       Text(
            //         'Location: ${place.street}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}',
            //         style: const TextStyle(fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        );
      }),
    );
  }
}

// class PIDetailScreen extends StatelessWidget {
//   final String preinsid;
//   final bool hitapiflow;
//   final bool iseditable;
//   final bool otherflow;
//   final bool ownflow;
//   final Position position;
//   final Placemark place;

//   PIDetailScreen({
//     super.key,
//     required this.preinsid,
//     required this.hitapiflow,
//     required this.iseditable,
//     required this.otherflow,
//     required this.ownflow,
//     required this.position,
//     required this.place,
//   });

//   final TextEditingController branchnametextcontoller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return BlocProvider(
//       create: (context) => PIDetailBloc(),
//       child: BlocConsumer<PIDetailBloc, PIDetailState>(
//           listener: (context, state) async {
//         if (state is PIDetailLoaded) {
        
//           // context.read<PIDetailBloc>().add(PlaceValueInTextField(
//           //     controller: branchnametextcontoller, getList: state.getList));
//           // branchnametextcontoller.text = await Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => DropDownListScreen(
//           //       datalist: state.getList,
//           //       // textEditingController:
//           //       //     controller,
//           //       listtype: "Branch",
//           //       isotherflow: false,
//           //     ),
//           //   ),
//           // );
//         }
//       }, builder: (context, state) {
//         return OverlayLoaderWithAppIcon(
//           appIconSize: 60,
//           circularProgressColor: Colors.transparent,
//           overlayBackgroundColor: Colors.black87,
//           isLoading: state is PIDetailLoading,
//           appIcon: Image.asset(
//             'assest/loadgif.gif',
//           ),
//           child: Scaffold(
//             appBar: AppBar(
//                 backgroundColor: appcolor,
//                 title: const Text('PreInspection'),
//                 centerTitle: true),
//             body: SingleChildScrollView(
//               child: Container(
//                 height: height / 1.1,
//                 width: width,
//                 color: Colors.grey.shade300,
//                 child: Stack(
//                   children: [
//                     ClipPath(
//                       clipper: CurvedBottomClipper(),
//                       child: Container(
//                         height: height / 4,
//                         width: width,
//                         color: appcolor,
//                       ),
//                     ),
//                     Positioned(
//                       top: 10,
//                       child: SizedBox(
//                           height: height / 1.13,
//                           width: width,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: SingleChildScrollView(
//                                 child: Form(
//                                   //   key: provider.formKey,
//                                   child: IgnorePointer(
//                                     ignoring:
//                                         false /* provider.allowedit(context) */,
//                                     child: Column(
//                                       children: [
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         DropDownPiWidget(
//                                           controller: branchnametextcontoller,
//                                           labelText: "Branch Name",
//                                           onTap: () async {
//                                             context
//                                                 .read<PIDetailBloc>()
//                                                 .add(FetchBranchNameApi());
//                                             if (state is PIDetailLoaded) {
//                                               debugPrint(
//                                                   DateTime.now().toString());
//                                             } else {}
//                                           },
//                                         ),
//                                         TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Surveyor Name",
//                                           suffixIcon: otherflow
//                                               ? const IconButton(
//                                                   onPressed: null,
//                                                   icon: Icon(Icons.search))
//                                               : null,
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Product",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Vehicle Category",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Seating Capacity",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Gross Vehicle Weight",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "PI Purpose",
//                                           onTap: () {},
//                                         ),
//                                         Visibility(
//                                           visible:
//                                               true /*  provider
//                                                                     .productcontroller
//                                                                     .text ==
//                                                                 "PRIVATE CAR" */
//                                           ,
//                                           child: Column(
//                                             children: [
//                                               Visibility(
//                                                 visible:
//                                                     true /*  provider
//                                                                               .pipuposecontroller
//                                                                               .text ==
//                                                                           "Nil Dep." ||
//                                                                       provider.pipuposecontroller
//                                                                               .text ==
//                                                                           "Break-In with Nil Dep." */
//                                                 ,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 10,
//                                                           right: 10,
//                                                           top: 10),
//                                                   child: TextFormField(
//                                                     // key: provider
//                                                     //     .engineprotectorcoverkey,
//                                                     onTap: () {
//                                                       // provider
//                                                       //     .showprotectorcoverselectvalue();
//                                                     },
//                                                     // controller: provider
//                                                     //     .protectorcoverrequiredcontroller,
//                                                     cursorColor: Colors.black,
//                                                     cursorHeight: 20,
//                                                     readOnly: true,
//                                                     decoration: InputDecoration(
//                                                       labelText:
//                                                           "Does Engine Protector Cover Required?",
//                                                       hintTextDirection:
//                                                           ui.TextDirection.ltr,
//                                                       filled: true,
//                                                       fillColor: Colors.white,
//                                                       suffixIcon: IconButton(
//                                                           onPressed: () {
//                                                             // provider
//                                                             //     .showprotectorcoverselectvalue();
//                                                           },
//                                                           icon: const Icon(Icons
//                                                               .arrow_drop_down)),
//                                                       contentPadding:
//                                                           const EdgeInsets.only(
//                                                               left: 14.0,
//                                                               bottom: 8.0,
//                                                               top: 8.0),
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       enabledBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       disabledBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Visibility(
//                                                 visible:
//                                                     true /* provider
//                                                                               .productcontroller
//                                                                               .text ==
//                                                                           "PRIVATE CAR" &&
//                                                                       provider
//                                                                           .isprotectedcoverrequired */
//                                                 ,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 10, right: 10),
//                                                   child: Column(
//                                                     children: [
//                                                       ListTile(
//                                                         tileColor:
//                                                             greycolor.shade100,
//                                                         title: const Center(
//                                                             child: Text("Yes")),
//                                                         onTap: () {
//                                                           // provider
//                                                           //     .selectyesprotectorcovervalue();
//                                                         },
//                                                       ),
//                                                       const Divider(),
//                                                       ListTile(
//                                                         tileColor:
//                                                             greycolor.shade100,
//                                                         title: const Center(
//                                                             child: Text("No")),
//                                                         onTap: () {
//                                                           // provider
//                                                           //     .selectnoprotectorcovervalue();
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const Visibility(
//                                           visible:
//                                               true /* provider
//                                                                     .productcontroller
//                                                                     .text ==
//                                                                 "PRIVATE CAR" */
//                                           ,
//                                           child: Visibility(
//                                             visible:
//                                                 true /* provider
//                                                                           .pipuposecontroller
//                                                                           .text ==
//                                                                       "Nil Dep." ||
//                                                                   provider.pipuposecontroller
//                                                                           .text ==
//                                                                       "Break-In with Nil Dep." */
//                                             ,
//                                             child: SizedBox(
//                                               height: 10,
//                                             ),
//                                           ),
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Endorsement Type",
//                                           onTap: () {},
//                                         ),
//                                         TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Policy Number",
//                                           suffixIcon: otherflow
//                                               ? const IconButton(
//                                                   onPressed: null,
//                                                   icon: Icon(Icons.search))
//                                               : null,
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Make",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Model",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Fuel Type",
//                                           onTap: () {},
//                                         ),
//                                         TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           readOnly: true,
//                                           labelText: "Vehicle Type",
//                                           suffixIcon: Switch(
//                                             onChanged:
//                                                 (value) {} /*  provider
//                                                                         .pifeecollectedtoggleSwitch */
//                                             ,
//                                             value:
//                                                 true /* provider
//                                                                         .ispifeescollected */
//                                             ,
//                                             activeColor: const Color(kAppTheme),
//                                             activeTrackColor: greycolor,
//                                             inactiveThumbColor:
//                                                 Colors.redAccent,
//                                             inactiveTrackColor: greycolor,
//                                           ),
//                                         ),
//                                         const Row(
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: Text(
//                                                 "Registration Type",
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         IgnorePointer(
//                                           ignoring:
//                                               false /*  widget.ishitapi ||
//                                                                 provider.issubmitted */
//                                           ,
//                                           child: Row(
//                                             children: [
//                                               Radio(
//                                                 value: 1,
//                                                 groupValue:
//                                                     null /*  provider
//                                                                       .selectedregistrationtypeRadio */
//                                                 ,
//                                                 activeColor: Colors.green,
//                                                 onChanged: (value) {
//                                                   // provider
//                                                   //     .setregistrationtypeSelectedRadio(
//                                                   //         value!);
//                                                 },
//                                               ),
//                                               const Text('Normal'),
//                                               const SizedBox(width: 20),
//                                               Radio(
//                                                 value: 2,
//                                                 groupValue:
//                                                     null /*  provider
//                                                                       .selectedregistrationtypeRadio */
//                                                 ,
//                                                 activeColor: Colors.green,
//                                                 onChanged: (value) {
//                                                   // provider
//                                                   //     .setregistrationtypeSelectedRadio(
//                                                   //         value!);
//                                                 },
//                                               ),
//                                               const Text('Bharat'),
//                                             ],
//                                           ),
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "RTO Code",
//                                           suffixIcon: IconButton(
//                                               onPressed: null,
//                                               icon: Icon(Icons.search)),
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "RTO Name",
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: otherflow,
//                                           readOnly: true,
//                                           labelText:
//                                               "Registration Number Format",
//                                           suffixIcon: Switch(
//                                             onChanged:
//                                                 (value) {} /*  provider
//                                                                         .pifeecollectedtoggleSwitch */
//                                             ,
//                                             value:
//                                                 true /* provider
//                                                                         .ispifeescollected */
//                                             ,
//                                             activeColor: const Color(kAppTheme),
//                                             activeTrackColor: greycolor,
//                                             inactiveThumbColor:
//                                                 Colors.redAccent,
//                                             inactiveTrackColor: greycolor,
//                                           ),
//                                         ),
//                                         const Row(
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: Text(
//                                                 "Registration Number",
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   maxLength: 2,
//                                                   // inputFormatters: <TextInputFormatter>[
//                                                   //   FilteringTextInputFormatter
//                                                   //       .allow(RegExp(
//                                                   //           "[0-9a-zA-Z]")),
//                                                   // ],
//                                                   onChanged: (value) {
//                                                     // if (provider
//                                                     //         .selectedregistrationtypeRadio ==
//                                                     //     2) {
//                                                     //   if (value.length ==
//                                                     //       2) {
//                                                     //     var dateTime =
//                                                     //         DateTime
//                                                     //             .now();
//                                                     //     var currentyear =
//                                                     //         DateFormat(
//                                                     //                 "yy")
//                                                     //             .format(
//                                                     //                 dateTime);
//                                                     //     var currectyearone =
//                                                     //         int.parse(
//                                                     //                 currentyear) -
//                                                     //             1;
//                                                     //     var currectyeartwo =
//                                                     //         int.parse(
//                                                     //                 currentyear) -
//                                                     //             2;
//                                                     //     var currectyearthree =
//                                                     //         int.parse(
//                                                     //                 currentyear) -
//                                                     //             3;
//                                                     //     debugPrint(
//                                                     //         "$currentyear $currectyearone $currectyeartwo $currectyearthree");
//                                                     //     if (provider.regisnumberonecontroller.text ==
//                                                     //             currentyear ||
//                                                     //         provider.regisnumberonecontroller
//                                                     //                 .text ==
//                                                     //             currectyearone
//                                                     //                 .toString() ||
//                                                     //         provider.regisnumberonecontroller
//                                                     //                 .text ==
//                                                     //             currectyeartwo
//                                                     //                 .toString()) {
//                                                     //     } else {
//                                                     //       provider
//                                                     //           .regisnumberonecontroller
//                                                     //           .text = "";
//                                                     //       showDialog(
//                                                     //         context:
//                                                     //             context,
//                                                     //         builder:
//                                                     //             (alertDialogContext) =>
//                                                     //                 AlertDialog(
//                                                     //           content: SizedBox(
//                                                     //               height: 60,
//                                                     //               width: 60,
//                                                     //               child: Center(
//                                                     //                   child: Text(
//                                                     //                 "Please enter the value greater than $currectyearthree and lesser than or equal to current year",
//                                                     //                 style:
//                                                     //                     const TextStyle(color: redcolor),
//                                                     //               ))),
//                                                     //         ),
//                                                     //       );
//                                                     //     }
//                                                     //   }
//                                                     // }
//                                                   },
//                                                   // controller: provider
//                                                   //     .regisnumberonecontroller,
//                                                   // focusNode: provider
//                                                   //     .focusregisnumberone,
//                                                   // readOnly:
//                                                   //     provider.selectedregistrationtypeRadio ==
//                                                   //             2
//                                                   //         ? false
//                                                   //         : true,
//                                                   cursorColor: Colors.black,
//                                                   cursorHeight: 20,
//                                                   // keyboardType:
//                                                   //     provider.selectedregistrationtypeRadio ==
//                                                   //             2
//                                                   //         ? TextInputType
//                                                   //             .number
//                                                   //         : TextInputType
//                                                   //             .name,
//                                                   decoration: InputDecoration(
//                                                     counterText: "",
//                                                     hintTextDirection:
//                                                         ui.TextDirection.ltr,
//                                                     filled: true,
//                                                     fillColor:
//                                                         const Color.fromRGBO(
//                                                             255, 255, 255, 1),
//                                                     contentPadding:
//                                                         const EdgeInsets.only(
//                                                             left: 14.0,
//                                                             bottom: 8.0,
//                                                             top: 8.0),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     disabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     errorBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   onChanged: (value) {},
//                                                   // controller: provider
//                                                   //     .regisnumbertwocontroller,
//                                                   cursorColor: Colors.black,
//                                                   cursorHeight: 20,
//                                                   readOnly: true,
//                                                   decoration: InputDecoration(
//                                                     hintTextDirection:
//                                                         ui.TextDirection.ltr,
//                                                     filled: true,
//                                                     fillColor: Colors.white,
//                                                     contentPadding:
//                                                         const EdgeInsets.only(
//                                                             left: 14.0,
//                                                             bottom: 8.0,
//                                                             top: 8.0),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     disabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     errorBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Visibility(
//                                                 visible:
//                                                     true /*  provider
//                                                                               .selectedregistrationtypeRadio ==
//                                                                           2 ||
//                                                                       provider
//                                                                           .isregistrationnumberformat */
//                                                 ,
//                                                 child: Expanded(
//                                                   child: TextFormField(
//                                                     // maxLength:
//                                                     //     provider.selectedregistrationtypeRadio ==
//                                                     //             2
//                                                     //         ? 4
//                                                     //         : 3,
//                                                     onChanged: (value) {
//                                                       // if (provider
//                                                       //         .selectedregistrationtypeRadio ==
//                                                       //     1) {
//                                                       //   if (value
//                                                       //       .isNotEmpty) {
//                                                       //     if (RegExp(
//                                                       //             r'^[0-9]*$')
//                                                       //         .hasMatch(
//                                                       //             value)) {
//                                                       //       provider
//                                                       //           .regisnumberthreecontroller
//                                                       //           .text = "";
//                                                       //       showDialog(
//                                                       //         context:
//                                                       //             context,
//                                                       //         builder:
//                                                       //             (alertDialogContext) =>
//                                                       //                 const AlertDialog(
//                                                       //           content: SizedBox(
//                                                       //               height: 60,
//                                                       //               width: 60,
//                                                       //               child: Center(
//                                                       //                   child: Text(
//                                                       //                 "Only alphabets are allowed",
//                                                       //                 style:
//                                                       //                     TextStyle(color: redcolor),
//                                                       //               ))),
//                                                       //         ),
//                                                       //       );
//                                                       //     }
//                                                       //   }
//                                                       // }
//                                                     },
//                                                     // inputFormatters: <TextInputFormatter>[
//                                                     //   FilteringTextInputFormatter
//                                                     //       .allow(RegExp(
//                                                     //           "[0-9a-zA-Z]")),
//                                                     // ],
//                                                     // controller: provider
//                                                     //     .regisnumberthreecontroller,
//                                                     // focusNode: provider
//                                                     //     .focusregisnumberthree,
//                                                     cursorColor: Colors.black,
//                                                     cursorHeight: 20,
//                                                     // keyboardType: provider
//                                                     //             .selectedregistrationtypeRadio ==
//                                                     //         2
//                                                     //     ? TextInputType
//                                                     //         .number
//                                                     //     : TextInputType
//                                                     //         .text,
//                                                     textCapitalization:
//                                                         TextCapitalization
//                                                             .characters,
//                                                     decoration: InputDecoration(
//                                                       counterText: "",
//                                                       hintTextDirection:
//                                                           ui.TextDirection.ltr,
//                                                       filled: true,
//                                                       fillColor: Colors.white,
//                                                       contentPadding:
//                                                           const EdgeInsets.only(
//                                                               left: 14.0,
//                                                               bottom: 8.0,
//                                                               top: 8.0),
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       enabledBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       disabledBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       errorBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                           color: greycolor
//                                                               .shade400,
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const Visibility(
//                                                 visible:
//                                                     true /* provider
//                                                                               .selectedregistrationtypeRadio ==
//                                                                           2 ||
//                                                                       provider
//                                                                           .isregistrationnumberformat */
//                                                 ,
//                                                 child: SizedBox(
//                                                   width: 10,
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   // maxLength:
//                                                   //     provider.selectedregistrationtypeRadio ==
//                                                   //             2
//                                                   //         ? 2
//                                                   //         : 4,
//                                                   // inputFormatters: <TextInputFormatter>[
//                                                   //   FilteringTextInputFormatter
//                                                   //       .allow(RegExp(
//                                                   //           "[0-9a-zA-Z]")),
//                                                   // ],
//                                                   onChanged: (value) {
//                                                     // if (provider
//                                                     //         .selectedregistrationtypeRadio ==
//                                                     //     2) {
//                                                     //   if (RegExp(
//                                                     //           r'^[a-zA-Z]*$')
//                                                     //       .hasMatch(
//                                                     //           value)) {
//                                                     //     if (value
//                                                     //             .toUpperCase()
//                                                     //             .contains(
//                                                     //                 "I") ||
//                                                     //         value
//                                                     //             .toUpperCase()
//                                                     //             .contains(
//                                                     //                 "O")) {
//                                                     //       provider
//                                                     //           .regisnumberfourcontroller
//                                                     //           .text = "";
//                                                     //       showDialog(
//                                                     //         context:
//                                                     //             context,
//                                                     //         builder:
//                                                     //             (alertDialogContext) =>
//                                                     //                 const AlertDialog(
//                                                     //           content: SizedBox(
//                                                     //               height: 60,
//                                                     //               width: 60,
//                                                     //               child: Center(
//                                                     //                   child: Text(
//                                                     //                 "Registration Number Should Not Contain \"I\" and \"O\"",
//                                                     //                 style:
//                                                     //                     TextStyle(color: redcolor),
//                                                     //               ))),
//                                                     //         ),
//                                                     //       );
//                                                     //     }
//                                                     //   } else {
//                                                     //     provider
//                                                     //         .regisnumberfourcontroller
//                                                     //         .text = "";
//                                                     //     showDialog(
//                                                     //       context:
//                                                     //           context,
//                                                     //       builder:
//                                                     //           (alertDialogContext) =>
//                                                     //               const AlertDialog(
//                                                     //         content: SizedBox(
//                                                     //             height: 60,
//                                                     //             width: 60,
//                                                     //             child: Center(
//                                                     //                 child: Text(
//                                                     //               "Only alphabets are allowed",
//                                                     //               style: TextStyle(
//                                                     //                   color:
//                                                     //                       redcolor),
//                                                     //             ))),
//                                                     //       ),
//                                                     //     );
//                                                     //   }
//                                                     // }
//                                                   },
//                                                   // controller: provider
//                                                   //     .regisnumberfourcontroller,
//                                                   // focusNode: provider
//                                                   //     .focusregistrationfournumber,
//                                                   cursorColor: Colors.black,
//                                                   cursorHeight: 20,
//                                                   // keyboardType: provider
//                                                   //             .selectedregistrationtypeRadio ==
//                                                   //         2
//                                                   //     ? TextInputType.text
//                                                   //     : TextInputType
//                                                   //         .number,
//                                                   // textCapitalization: provider
//                                                   //             .selectedregistrationtypeRadio ==
//                                                   //         2
//                                                   //     ? TextCapitalization
//                                                   //         .characters
//                                                   //     : TextCapitalization
//                                                   //         .none,
//                                                   onTapOutside: (event) {
//                                                     FocusScope.of(context)
//                                                         .unfocus();
//                                                   },
//                                                   decoration: InputDecoration(
//                                                     counterText: "",
//                                                     hintTextDirection:
//                                                         ui.TextDirection.ltr,
//                                                     filled: true,
//                                                     fillColor: Colors.white,
//                                                     contentPadding:
//                                                         const EdgeInsets.only(
//                                                             left: 14.0,
//                                                             bottom: 8.0,
//                                                             top: 8.0),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     disabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     errorBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             greycolor.shade400,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Year Of Manufacturing",
//                                           suffixIcon: IconButton(
//                                               onPressed: null,
//                                               icon: Icon(Icons.date_range)),
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Engine Number",
//                                           maxLength: 30,
//                                           keyboardType:
//                                               TextInputType.visiblePassword,
//                                           textCapitalization:
//                                               TextCapitalization.characters,
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Chassis Number",
//                                           maxLength: 30,
//                                           keyboardType:
//                                               TextInputType.visiblePassword,
//                                           textCapitalization:
//                                               TextCapitalization.characters,
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "IDV Of Vehicle",
//                                           onTap: () {},
//                                         ),
//                                         TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: otherflow,
//                                           labelText: "Contact Person",
//                                         ),
//                                         TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: otherflow,
//                                           labelText: "Contact Mobile Number",
//                                           maxLength: 10,
//                                           keyboardType: TextInputType.number,
//                                           inputformat: "number",
//                                           onChanged: (value) {
//                                             if (int.parse(value) < 6) {}
//                                           },
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Prefix",
//                                           onTap: () {},
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Insured Name",
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Inspection Location",
//                                           suffixIcon: IconButton(
//                                               onPressed: null,
//                                               icon: Icon(
//                                                   Icons.my_location_sharp)),
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Proposal Type",
//                                           onTap: () {},
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "SGIC Policy Number",
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: !otherflow,
//                                           labelText: "Odometer Reading",
//                                           keyboardType: TextInputType.number,
//                                           maxLength: 8,
//                                           inputformat: "number",
//                                           onChanged: (value) {},
//                                         ),
//                                         DropDownPiWidget(
//                                           visible: !otherflow,
//                                           labelText: "Pre-Inspection Status",
//                                           onTap: () {},
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Eligible NCB%",
//                                           onTap: () {},
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: !otherflow,
//                                           readOnly: true,
//                                           labelText: "RC Verified",
//                                           suffixIcon: Switch(
//                                             onChanged:
//                                                 (value) {} /*  provider
//                                                                         .pifeecollectedtoggleSwitch */
//                                             ,
//                                             value:
//                                                 true /* provider
//                                                                         .ispifeescollected */
//                                             ,
//                                             activeColor: const Color(kAppTheme),
//                                             activeTrackColor: greycolor,
//                                             inactiveThumbColor:
//                                                 Colors.redAccent,
//                                             inactiveTrackColor: greycolor,
//                                           ),
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Dented Parts",
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Scratched Parts",
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Broken Parts",
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: !otherflow,
//                                           readOnly: true,
//                                           labelText:
//                                               "Vehicle Runninig Condition",
//                                           suffixIcon: Switch(
//                                             onChanged:
//                                                 (value) {} /*  provider
//                                                                         .pifeecollectedtoggleSwitch */
//                                             ,
//                                             value:
//                                                 true /* provider
//                                                                         .ispifeescollected */
//                                             ,
//                                             activeColor: const Color(kAppTheme),
//                                             activeTrackColor: greycolor,
//                                             inactiveThumbColor:
//                                                 Colors.redAccent,
//                                             inactiveTrackColor: greycolor,
//                                           ),
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: !otherflow,
//                                           labelText: "Surveyor Remarks",
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Current Status",
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: hitapiflow,
//                                           labelText:
//                                               "Approve/Reject/Hold Remarks",
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: hitapiflow,
//                                           labelText: "Details Remarks",
//                                         ),
//                                         IgnorePointer(
//                                           ignoring: false
//                                           //  provider
//                                           //             .currentstatuscontroller
//                                           //             .text ==
//                                           //         "Survey On Hold"
//                                           //     ? false
//                                           //     :
//                                           /*     widget.ishitapi ||
//                                                                     provider.issubmitted */
//                                           ,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 10,
//                                                 right: 10,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                   color: greycolor.shade400,
//                                                   width: 1,
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10, right: 10),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     const Text(
//                                                       "RC Copy",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           fontSize: 16),
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         IconButton(
//                                                           onPressed: /*  provider
//                                                                                     .isrccopyupload
//                                                                                 ? null
//                                                                                 : */
//                                                               () {
//                                                             // provider
//                                                             //         .isrccopyupload
//                                                             //     ? showDialog(
//                                                             //         context:
//                                                             //             context,
//                                                             //         builder: (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //           content:
//                                                             //               const Wrap(
//                                                             //             children: [
//                                                             //               Center(
//                                                             //                   child: Text(
//                                                             //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
//                                                             //                 style: TextStyle(color: redcolor),
//                                                             //               )),
//                                                             //             ],
//                                                             //           ),
//                                                             //           actions: [
//                                                             //             TextButton(
//                                                             //                 onPressed: () {
//                                                             //                   Navigator.pop(context);
//                                                             //                 },
//                                                             //                 child: const Text("Cancel")),
//                                                             //             TextButton(
//                                                             //                 onPressed: () {
//                                                             //                   Navigator.pop(context);
//                                                             //                   provider.deleterccopy("RC Copy");
//                                                             //                 },
//                                                             //                 child: const Text("Delete")),
//                                                             //           ],
//                                                             //         ),
//                                                             //       )
//                                                             //     : provider.showbottomsheet(
//                                                             //         "RC Copy",
//                                                             //         context);
//                                                           },
//                                                           icon: const Icon(
//                                                               Icons.upload),
//                                                           color: /*  provider
//                                                                                     .isrccopyupload
//                                                                                 ? greycolor
//                                                                                 : */
//                                                               Colors.green,
//                                                         ),
//                                                         IconButton(
//                                                           onPressed: () {
//                                                             // if (provider
//                                                             //     .isrccopyupload) {
//                                                             //   showDialog(
//                                                             //     context:
//                                                             //         context,
//                                                             //     builder:
//                                                             //         (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //       content:
//                                                             //           const Wrap(
//                                                             //         children: [
//                                                             //           Center(
//                                                             //               child: Text(
//                                                             //             "Do you want to delete the file",
//                                                             //             style: TextStyle(color: redcolor),
//                                                             //           )),
//                                                             //         ],
//                                                             //       ),
//                                                             //       actions: [
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //             },
//                                                             //             child: const Text("Cancel")),
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //               provider.deleterccopy("RC Copy");
//                                                             //             },
//                                                             //             child: const Text("Delete")),
//                                                             //       ],
//                                                             //     ),
//                                                             //   );
//                                                             // } else {
//                                                             //   showDialog(
//                                                             //     context:
//                                                             //         context,
//                                                             //     builder:
//                                                             //         (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //       content:
//                                                             //           const Wrap(
//                                                             //         children: [
//                                                             //           Center(
//                                                             //               child: Text(
//                                                             //             "No file available to delete",
//                                                             //             style: TextStyle(color: redcolor),
//                                                             //           )),
//                                                             //         ],
//                                                             //       ),
//                                                             //       actions: [
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //             },
//                                                             //             child: const Text("Ok")),
//                                                             //       ],
//                                                             //     ),
//                                                             //   );
//                                                             // }
//                                                           },
//                                                           icon: const Icon(
//                                                               Icons.delete),
//                                                           color: Colors.red,
//                                                         ),
//                                                         Visibility(
//                                                           visible:
//                                                               true /*  provider
//                                                                                 .isrccopyupload */
//                                                           ,
//                                                           child: IconButton(
//                                                             onPressed: () {},
//                                                             icon: const Icon(
//                                                                 Icons.verified),
//                                                             color: Colors.blue,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         IgnorePointer(
//                                           ignoring:
//                                               false /*  widget.ishitapi ||
//                                                                 provider.issubmitted */
//                                           ,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 10,
//                                                 right: 10,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                   color: greycolor.shade400,
//                                                   width: 1,
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10, right: 10),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     const Text(
//                                                       "Previous Policy",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           fontSize: 16),
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         IconButton(
//                                                           onPressed: /* provider
//                                                                                     .ispreviouspolicyupload
//                                                                                 ? null
//                                                                                 :  */
//                                                               () {
//                                                             // provider
//                                                             //         .ispreviouspolicyupload
//                                                             //     ? showDialog(
//                                                             //         context:
//                                                             //             context,
//                                                             //         builder: (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //           content:
//                                                             //               const Wrap(
//                                                             //             children: [
//                                                             //               Center(
//                                                             //                   child: Text(
//                                                             //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
//                                                             //                 style: TextStyle(color: redcolor),
//                                                             //               )),
//                                                             //             ],
//                                                             //           ),
//                                                             //           actions: [
//                                                             //             TextButton(
//                                                             //                 onPressed: () {
//                                                             //                   Navigator.pop(context);
//                                                             //                 },
//                                                             //                 child: const Text("Cancel")),
//                                                             //             TextButton(
//                                                             //                 onPressed: () {
//                                                             //                   Navigator.pop(context);
//                                                             //                   provider.deletepreviouspolicy("Previous Policy");
//                                                             //                 },
//                                                             //                 child: const Text("Delete")),
//                                                             //           ],
//                                                             //         ),
//                                                             //       )
//                                                             //     : provider.showbottomsheet(
//                                                             //         "Previous Policy",
//                                                             //         context);
//                                                           },
//                                                           icon: const Icon(
//                                                               Icons.upload),
//                                                           color: /* provider
//                                                                                     .ispreviouspolicyupload
//                                                                                 ? greycolor
//                                                                                 : */
//                                                               Colors.green,
//                                                         ),
//                                                         IconButton(
//                                                           onPressed: () {
//                                                             // if (provider
//                                                             //     .ispreviouspolicyupload) {
//                                                             //   showDialog(
//                                                             //     context:
//                                                             //         context,
//                                                             //     builder:
//                                                             //         (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //       content:
//                                                             //           const Wrap(
//                                                             //         children: [
//                                                             //           Center(
//                                                             //               child: Text(
//                                                             //             "Do you want to delete the file",
//                                                             //             style: TextStyle(color: redcolor),
//                                                             //           )),
//                                                             //         ],
//                                                             //       ),
//                                                             //       actions: [
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //             },
//                                                             //             child: const Text("Cancel")),
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //               provider.deletepreviouspolicy("Previous Policy");
//                                                             //             },
//                                                             //             child: const Text("Delete")),
//                                                             //       ],
//                                                             //     ),
//                                                             //   );
//                                                             // } else {
//                                                             //   showDialog(
//                                                             //     context:
//                                                             //         context,
//                                                             //     builder:
//                                                             //         (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //       content:
//                                                             //           const Wrap(
//                                                             //         children: [
//                                                             //           Center(
//                                                             //               child: Text(
//                                                             //             "No file available to delete",
//                                                             //             style: TextStyle(color: redcolor),
//                                                             //           )),
//                                                             //         ],
//                                                             //       ),
//                                                             //       actions: [
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //             },
//                                                             //             child: const Text("Ok")),
//                                                             //       ],
//                                                             //     ),
//                                                             //   );
//                                                             // }
//                                                           },
//                                                           icon: const Icon(
//                                                               Icons.delete),
//                                                           color: Colors.red,
//                                                         ),
//                                                         Visibility(
//                                                           visible:
//                                                               true /*  provider
//                                                                                 .ispreviouspolicyupload */
//                                                           ,
//                                                           child: IconButton(
//                                                             onPressed: () {},
//                                                             icon: const Icon(
//                                                                 Icons.verified),
//                                                             color: Colors.blue,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         IgnorePointer(
//                                           ignoring:
//                                               false /*  widget.ishitapi ||
//                                                                 provider.issubmitted */
//                                           ,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 10,
//                                                 right: 10,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                   color: greycolor.shade400,
//                                                   width: 1,
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10, right: 10),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     const Text(
//                                                       "Invoice Copy",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           fontSize: 16),
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         IconButton(
//                                                           onPressed: /* provider
//                                                                                     .isinvoicecopyupload
//                                                                                 ? null
//                                                                                 :  */
//                                                               () {
//                                                             // provider
//                                                             //         .isinvoicecopyupload
//                                                             //     ? showDialog(
//                                                             //         context:
//                                                             //             context,
//                                                             //         builder: (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //           content:
//                                                             //               const Wrap(
//                                                             //             children: [
//                                                             //               Center(
//                                                             //                   child: Text(
//                                                             //                 "Only 1 document is allowed. Please delete the existing file to upload a new one",
//                                                             //                 style: TextStyle(color: redcolor),
//                                                             //               )),
//                                                             //             ],
//                                                             //           ),
//                                                             //           actions: [
//                                                             //             TextButton(
//                                                             //                 onPressed: () {
//                                                             //                   Navigator.pop(context);
//                                                             //                 },
//                                                             //                 child: const Text("Cancel")),
//                                                             //             TextButton(
//                                                             //                 onPressed: () {
//                                                             //                   Navigator.pop(context);
//                                                             //                   provider.deleteinvoicecopy("Invoice Copy");
//                                                             //                 },
//                                                             //                 child: const Text("Delete")),
//                                                             //           ],
//                                                             //         ),
//                                                             //       )
//                                                             //     : provider.showbottomsheet(
//                                                             //         "Invoice Copy",
//                                                             //         context);
//                                                           },
//                                                           icon: const Icon(
//                                                               Icons.upload),
//                                                           color: /*  provider
//                                                                                     .isinvoicecopyupload
//                                                                                 ? greycolor
//                                                                                 : */
//                                                               Colors.green,
//                                                         ),
//                                                         IconButton(
//                                                           onPressed: () {
//                                                             // if (provider
//                                                             //     .isinvoicecopyupload) {
//                                                             //   showDialog(
//                                                             //     context:
//                                                             //         context,
//                                                             //     builder:
//                                                             //         (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //       content:
//                                                             //           const Wrap(
//                                                             //         children: [
//                                                             //           Center(
//                                                             //               child: Text(
//                                                             //             "Do you want to delete the file",
//                                                             //             style: TextStyle(color: redcolor),
//                                                             //           )),
//                                                             //         ],
//                                                             //       ),
//                                                             //       actions: [
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //             },
//                                                             //             child: const Text("Cancel")),
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //               provider.deleteinvoicecopy("Invoice Copy");
//                                                             //             },
//                                                             //             child: const Text("Delete")),
//                                                             //       ],
//                                                             //     ),
//                                                             //   );
//                                                             // } else {
//                                                             //   showDialog(
//                                                             //     context:
//                                                             //         context,
//                                                             //     builder:
//                                                             //         (alertDialogContext) =>
//                                                             //             AlertDialog(
//                                                             //       content:
//                                                             //           const Wrap(
//                                                             //         children: [
//                                                             //           Center(
//                                                             //               child: Text(
//                                                             //             "No file available to delete",
//                                                             //             style: TextStyle(color: redcolor),
//                                                             //           )),
//                                                             //         ],
//                                                             //       ),
//                                                             //       actions: [
//                                                             //         TextButton(
//                                                             //             onPressed: () {
//                                                             //               Navigator.pop(context);
//                                                             //             },
//                                                             //             child: const Text("Ok")),
//                                                             //       ],
//                                                             //     ),
//                                                             //   );
//                                                             // }
//                                                           },
//                                                           icon: const Icon(
//                                                               Icons.delete),
//                                                           color: Colors.red,
//                                                         ),
//                                                         Visibility(
//                                                           visible:
//                                                               true /*  provider
//                                                                                 .isinvoicecopyupload */
//                                                           ,
//                                                           child: IconButton(
//                                                             onPressed: () {},
//                                                             icon: const Icon(
//                                                                 Icons.verified),
//                                                             color: Colors.blue,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: !otherflow,
//                                           readOnly: true,
//                                           labelText: "PI Fee Collected",
//                                           suffixIcon: Switch(
//                                             onChanged:
//                                                 (value) {} /*  provider
//                                                                         .pifeecollectedtoggleSwitch */
//                                             ,
//                                             value:
//                                                 true /* provider
//                                                                         .ispifeescollected */
//                                             ,
//                                             activeColor: const Color(kAppTheme),
//                                             activeTrackColor: greycolor,
//                                             inactiveThumbColor:
//                                                 Colors.redAccent,
//                                             inactiveTrackColor: greycolor,
//                                           ),
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "PI Fee Amount",
//                                           keyboardType: TextInputType.number,
//                                           inputformat: "number",
//                                         ),
//                                         const TextFieldPiWidget(
//                                           ignoring: false,
//                                           visible: true,
//                                           labelText: "Conveyance Amount",
//                                           keyboardType: TextInputType.number,
//                                           inputformat: "number",
//                                         ),
//                                         DropDownPiWidget(
//                                           labelText: "Mode Of Payment",
//                                           onTap: () {},
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: otherflow,
//                                           maxLength: 10,
//                                           labelText: "Contact no for SMS",
//                                           keyboardType: TextInputType.number,
//                                           inputformat: "number",
//                                           onChanged: (value) {
//                                             if (int.parse(value) < 6) {}
//                                           },
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: otherflow,
//                                           labelText: "Intimation Remarks",
//                                         ),
//                                         TextFieldPiWidget(
//                                           visible: otherflow,
//                                           maxLength: 10,
//                                           labelText:
//                                               "Contact no to send link for self PI",
//                                           keyboardType: TextInputType.number,
//                                           inputformat: "number",
//                                           onChanged: (value) {
//                                             if (int.parse(value) < 6) {}
//                                           },
//                                         ),

//                                         /*   !(provider.intimationstatus ==
//                                                                           "Survey On Hold" ||
//                                                                       provider.intimationstatus ==
//                                                                           "Request Assign to Surveyor") &&
//                                                                   (widget.ishitapi ||
//                                                                       provider.issubmitted)
//                                                               ? const SizedBox()
//                                                               : */
//                                         Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: SizedBox(
//                                             height: 50,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             child: ElevatedButton(
//                                                 onPressed: () {
//                                                   // provider.ifelsecondigtionforsubmit(
//                                                   //     widget.ownpi,
//                                                   //     widget
//                                                   //         .otherpi,
//                                                   //     widget
//                                                   //         .ishitapi,
//                                                   //     context);
//                                                 },
//                                                 child: const Text("Submit")),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 50,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             ),

//             //  Padding(
//             //   padding: const EdgeInsets.all(16.0),
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Text('Latitude: ${position.latitude}'),
//             //       Text('Longitude: ${position.longitude}'),
//             //       const SizedBox(height: 10),
//             //       Text(
//             //         'Location: ${place.street}, ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}',
//             //         style: const TextStyle(fontSize: 16),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ),
//         );
//       }),
//     );
//   }
// }
