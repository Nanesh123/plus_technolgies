import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plus_technolgies/model/clientList.dart';
import 'package:plus_technolgies/service/api_service.dart';

class ClientProvider extends ChangeNotifier {
  List<ClientList> _clientList = [];
  List<ClientList> get clientList => _clientList;

  bool _isSubmit = false;
  bool get isSubmit => _isSubmit;

  set isSubmit(val) {
    _isSubmit = val;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  //add Client
  addClient(name, phone, address) async {
    isSubmit = true;
    var data = {
      'name': name,
      'phone': phone,
      'address': address,
      'owner_id': '192',
    };

    try {
      var respose = await ApiService().postData(data);
      isSubmit = false;
      return respose['message'];
    } catch (e) {
      isSubmit = false;
      throw Exception(e.toString());
    }
  }

  //get Client
  getCient() async {
    isLoading = true;
    try {
      var respose = await ApiService().getData();
      if (respose['message'] == 'Success') {
        respose['data']
            .map((e) => _clientList.add(ClientList.fromJson(e)))
            .toList();
        notifyListeners();
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      log(e.toString());
    }
  }
}
