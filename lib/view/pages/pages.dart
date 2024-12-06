import 'dart:async';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/network/response/api_response.dart';
import 'package:flutter_mvvm/data/network/response/status.dart';
import 'package:flutter_mvvm/model/city.dart';
import 'package:flutter_mvvm/model/costs/costs.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';
import 'package:flutter_mvvm/view/pages/widgets/widgets.dart';
import 'package:flutter_mvvm/viewmodel/home_vm.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

part 'counter_page.dart';
part 'home_page.dart';
part 'main_menu.dart';
part 'cost_page.dart';
