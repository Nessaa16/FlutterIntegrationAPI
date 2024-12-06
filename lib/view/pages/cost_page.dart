part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  home_vm HomeViewModel = home_vm();
  bool isLoading = false;

  dynamic selectedProvince;
  dynamic selectedCity;
  dynamic selectedToGoProvince;
  dynamic selectedToGoCity;
  final selectedWeight = TextEditingController();

  final List<String> courierOptions = ["jne", "pos", "tiki"];
  String selectedCourier = "jne";

  @override
  void initState() {
    HomeViewModel.getProvinceList();
    super.initState();
  }

  static Container loadingKit() {
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        color: Colors.black26,
        child: SpinKitFadingCircle(size: 45, color: const Color.fromARGB(255, 215, 176, 254)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 215, 176, 254),
             shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
            title: Text(style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.1), 
            "Ongkir Calculation"),
            centerTitle: true),
        body: ChangeNotifierProvider<home_vm>(
          create: (context) => HomeViewModel,
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 700,
                      width: double.infinity,
                      child: Column(children: [
                        Flexible(
                            flex: 1,
                            child: Card(
                                color: Colors.white,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(children: [

                                    //dropdown courier & weight
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: selectedCourier,
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                iconSize: 30,
                                                elevation: 2,
                                                hint:
                                                    Text('Select Courier'),
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: courierOptions.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String courier) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: courier,
                                                    child: Text(
                                                        courier.toUpperCase()),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedCourier =
                                                        newValue ?? "jne";
                                                  });
                                                  print(
                                                      'Courier: $selectedCourier');
                                                },
                                              )),
                                          SizedBox(width: 18),
                                          Expanded(
                                              flex: 1,
                                              child: TextField(
                                                controller: selectedWeight,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    labelText: 'Weight (gr)'),
                                                onChanged: (newValue) {
                                                  print(
                                                      'Weight: ${selectedWeight.text}');
                                                },
                                              ))
                                        ]),
                                    SizedBox(height: 24),

                                    //dropdown province
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Origin",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 155, 115, 195),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Consumer<home_vm>(
                                                  builder: (context, value, _) {
                                                switch (
                                                    value.provinceList.status) {
                                                  case Status.loading:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: const Color.fromARGB(255, 247, 200, 255)));                                       return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(value
                                                            .provinceList
                                                            .message
                                                            .toString()));
                                                  case Status.completed:
                                                    return DropdownButton(
                                                      isExpanded: true,
                                                      value:
                                                          selectedProvince,
                                                      icon: Icon(Icons
                                                          .arrow_drop_down),
                                                      iconSize: 30,
                                                      elevation: 2,
                                                      hint: Text(
                                                          'Select Province'),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(255, 155, 115, 195)),
                                                      items: value
                                                          .provinceList.data!
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      Province>>(
                                                              (Province value) {
                                                        return DropdownMenuItem(
                                                            value: value,
                                                            child: Text(value
                                                                .province
                                                                .toString()));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedProvince =
                                                              newValue;
                                                          selectedCity =
                                                              null;
                                                        });
                                                        if (newValue != null) {
                                                          value.setCityOriginList(
                                                              ApiResponse
                                                                  .loading());
                                                          HomeViewModel
                                                              .getCityOriginList(
                                                                  selectedProvince
                                                                      .provinceId);
                                                        }
                                                        print(
                                                            'Province Origin: $selectedProvince');
                                                      },
                                                    );
                                                  default:
                                                    return Container();
                                                }
                                              })),
                                          SizedBox(width: 18),
                                          Expanded(
                                              flex: 1,
                                              child: Consumer<home_vm>(
                                                  builder: (context, value, _) {
                                                switch (value
                                                    .cityOriginList.status) {
                                                  case Status.notStarted:
                                                    return DropdownButton(
                                                      isExpanded: true,
                                                      value: selectedCity,
                                                      icon: Icon(Icons
                                                          .arrow_drop_down),
                                                      iconSize: 30,
                                                      elevation: 2,
                                                      hint: Text('Select City'),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(255, 155, 115, 195)),
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: value,
                                                          child: Text(
                                                              "Select Province First"),
                                                        )
                                                      ],
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedCity =
                                                              newValue;
                                                        });
                                                      },
                                                    );
                                                  case Status.loading:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Color.fromARGB(255, 247, 200, 255),
                                                        ));
                                                  case Status.error:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(value
                                                            .cityOriginList
                                                            .message
                                                            .toString()));
                                                  case Status.completed:
                                                    if (value.cityOriginList
                                                                .data !=
                                                            null &&
                                                        value.cityOriginList
                                                            .data!.isNotEmpty) {
                                                      return DropdownButton(
                                                        isExpanded: true,
                                                        value:
                                                            selectedCity,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down),
                                                        iconSize: 30,
                                                        elevation: 2,
                                                        hint:
                                                            Text('Choose City'),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(255, 155, 115, 195)),
                                                        items: value
                                                            .cityOriginList
                                                            .data!
                                                            .map<
                                                                DropdownMenuItem<
                                                                    City>>((City
                                                                value) {
                                                          return DropdownMenuItem(
                                                            value: value,
                                                            child: Text(value
                                                                .cityName
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedCity =
                                                                newValue;
                                                          });
                                                          print(
                                                              'City Origin: $selectedCity');
                                                        },
                                                      );
                                                    } else {
                                                      return Text(
                                                          "No City Avalaible.");
                                                    }
                                                  default:
                                                    return Container();
                                                }
                                              }))
                                        ]),
                                    SizedBox(height: 24),

                                    //dropdown province
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Destination",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color.fromARGB(255, 155, 115, 195),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Consumer<home_vm>(
                                                  builder: (context, value, _) {
                                                switch (
                                                    value.provinceList.status) {
                                                  case Status.loading:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Color.fromARGB(255, 247, 200, 255)));
                                                  case Status.error:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(value
                                                            .provinceList
                                                            .message
                                                            .toString()));
                                                  case Status.completed:
                                                    return DropdownButton(
                                                      isExpanded: true,
                                                      value:
                                                          selectedToGoProvince,
                                                      icon: Icon(Icons
                                                          .arrow_drop_down),
                                                      iconSize: 30,
                                                      elevation: 2,
                                                      hint: Text(
                                                          'Choose Province'),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(255, 155, 115, 195)),
                                                      items: value
                                                          .provinceList.data!
                                                          .map<
                                                                  DropdownMenuItem<
                                                                      Province>>(
                                                              (Province value) {
                                                        return DropdownMenuItem(
                                                            value: value,
                                                            child: Text(value
                                                                .province
                                                                .toString()));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedToGoProvince =
                                                              newValue;
                                                          selectedToGoCity =
                                                              null;
                                                        });
                                                        if (newValue != null) {
                                                          value.setCityDestinationList(
                                                              ApiResponse
                                                                  .loading());
                                                          HomeViewModel
                                                              .getCityDestinationList(
                                                                  selectedToGoProvince
                                                                      .provinceId);
                                                        }
                                                        print(
                                                            'Province Destination: $selectedToGoProvince');
                                                      },
                                                    );
                                                  default:
                                                    return Container();
                                                }
                                              })),
                                          SizedBox(width: 18),
                                          
                                          Expanded(
                                              flex: 1,
                                              child: Consumer<home_vm>(
                                                  builder: (context, value, _) {
                                                switch (value
                                                    .cityDestinationList
                                                    .status) {
                                                  case Status.notStarted:
                                                    return DropdownButton(
                                                      isExpanded: true,
                                                      value:
                                                          selectedToGoCity,
                                                      icon: Icon(Icons
                                                          .arrow_drop_down),
                                                      iconSize: 30,
                                                      elevation: 2,
                                                      hint: Text('Choose City'),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(255, 155, 115, 195)),
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: value,
                                                          child: Text(
                                                              "Select Province First"),
                                                        )
                                                      ],
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedToGoCity =
                                                              newValue;
                                                        });
                                                      },
                                                    );
                                                  case Status.loading:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Color.fromARGB(255, 247, 200, 255),
                                                        ));
                                                  case Status.error:
                                                    return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(value
                                                            .cityDestinationList
                                                            .message
                                                            .toString()));
                                                  case Status.completed:
                                                    if (value.cityDestinationList
                                                                .data !=
                                                            null &&
                                                        value
                                                            .cityDestinationList
                                                            .data!
                                                            .isNotEmpty) {
                                                      return DropdownButton(
                                                        isExpanded: true,
                                                        value:
                                                            selectedToGoCity,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down),
                                                        iconSize: 30,
                                                        elevation: 2,
                                                        hint:
                                                            Text('Choose City'),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(255, 155, 115, 195)),
                                                        items: value
                                                            .cityDestinationList
                                                            .data!
                                                            .map<
                                                                DropdownMenuItem<
                                                                    City>>((City
                                                                value) {
                                                          return DropdownMenuItem(
                                                            value: value,
                                                            child: Text(value
                                                                .cityName
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedToGoCity =
                                                                newValue;
                                                          });
                                                          print(
                                                              'City Destination: $selectedToGoCity');
                                                        },
                                                      );
                                                    } else {
                                                      return Text(
                                                          "No City Avalaible");
                                                    }
                                                  default:
                                                    return Container();
                                                }
                                              }))
                                        ]),
                                    SizedBox(height: 12),

                                    //calculate button
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (selectedCity != null &&
                                              selectedToGoCity != null &&
                                              selectedWeight.text != "" &&
                                              selectedCourier != "") {
                                            HomeViewModel
                                                .checkShipmentCost(
                                                    selectedCity.cityId
                                                        .toString(),
                                                    "city",
                                                    selectedToGoCity
                                                        .cityId
                                                        .toString(),
                                                    "city",
                                                    int.parse(selectedWeight.text),
                                                    selectedCourier)
                                                .then((onValue) {
                                              print(
                                                  'City Origin: ${selectedCity.cityName.toString()}');
                                              print(
                                                  'City Destination: ${selectedToGoCity.cityName.toString()}');
                                              print(
                                                  'Weight: ${int.parse(selectedWeight.text)}');
                                              print(
                                                  'Courier: $selectedCourier');
                                              print('Cost List: $onValue');
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 155, 115, 195),
                                          elevation: 0,
                                          padding: EdgeInsets.fromLTRB(
                                              32, 16, 32, 16),
                                        ),
                                        child: Text(
                                          "Calculate Estimate Cost",
                                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ]),
                                ))),
                        Flexible(
                          flex: 1,
                          child: Card(
                            color: Color.fromARGB(255, 227, 200, 255),
                            elevation: 2,
                            child: Consumer<home_vm>(
                                builder: (context, value, _) {
                              switch (value.costList.status) {
                                case Status.loading:
                                  return Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "No Data.",
                                        style: TextStyle(
                                            fontSize: 18, color: const Color.fromARGB(255, 255, 255, 255)),
                                      ));
                                case Status.error:
                                  return Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          value.costList.message.toString()));
                                case Status.completed:
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    if (isLoading) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: ListView.builder(
                                        itemCount:
                                            value.costList.data?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return CardList(value.costList.data!
                                              .elementAt(index));
                                        },
                                      ));
                                default:
                                  return Container();
                              }
                            }),
                          ),
                        )
                      ])),
                ),
              ),
              Consumer<home_vm>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return Container(
                      color: const Color.fromARGB(66, 255, 255, 255),
                      child: Center(
                        child: loadingKit(),
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}
