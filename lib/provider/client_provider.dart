import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plus_technolgies/model/clientList.dart';
import 'package:plus_technolgies/model/local/clientModel.dart';
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

  bool _isCompleteSync = false;
  bool get isCompleteSync => _isCompleteSync;
  set isCompleteSync(val) {
    _isCompleteSync = val;
    notifyListeners();
  }

  //add Client
  Future addClient(name, phone, address, ownerId) async {
    if (_isCompleteSync == false) {
      isSubmit = true;
    }
    var data = {
      'name': name,
      'phone': phone,
      'address': address,
      'owner_id': '$ownerId',
    };

    try {
      var apiRespose = await ApiService().postData(data);
      isSubmit = false;
      await updateLocal(name);
      return apiRespose['message'];
    } catch (e) {
      isSubmit = false;
      throw Exception(e.toString());
    }
  }

  //get Client
  Future getCient() async {
    isLoading = true;
    _clientList.clear();
    notifyListeners();
    try {
      var respose = await ApiService().getData();
      if (respose['message'] == 'Success') {
        await getLocalData();
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

// sync all client from local

  Future<void> startSync() async {
    isCompleteSync = true;
    final clientBox = await openClientBox();
    List clientList = clientBox.values.toList();
    debugPrint(':::::Sync Started:::::');
    int count = 0;
    for (var element in clientList) {
      if (element.isSync == false) {
        await addClient(
            element.name, element.phone, element.address, element.ownerId);
        count++;
      }
    }
    isCompleteSync = false;
    debugPrint(':::::$count Sync Completed:::::');
  }

  /*|---------------- local ------------------|*/

  // add client

  Future addToLocal(name, phone, address) async {
    isSubmit = true;
    await Future.delayed(const Duration(seconds: 2));
    try {
      final clientBox = await openClientBox();

      final localClientData =
          clientBox.values.where((element) => (element.name == name)).toList();
      isSubmit = false;
      if (localClientData.isEmpty) {
        final clientData = ClientModel(
            name: name,
            phone: phone,
            address: address,
            ownerId: '192',
            isSync: false);
        final result = await clientBox.add(clientData);
        await getCient();
        debugPrint('client--ID$result');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isSubmit = false;
      throw Exception(e.toString());
    }
  }

  updateLocal(name) async {
    final clientBox = await openClientBox();
    final localClientData =
        clientBox.values.where((element) => (element.name == name)).toList();
    if (localClientData.isNotEmpty) {
      final key = localClientData.first.key;

      var clientInfoData = clientBox.getAt(key);
      var updateClientInfo = ClientModel(
        name: clientInfoData.name,
        phone: clientInfoData.phone,
        address: clientInfoData.address,
        ownerId: clientInfoData.ownerId,
        isSync: true,
      );
      clientBox.putAt(key, updateClientInfo);
    }

    getCient();
  }

  Future<void> getLocalData() async {
    final clientBox = await openClientBox();
    List clientList = clientBox.values.toList();
    for (var element in clientList) {
      if (element.isSync == false || element.isSync == null) {
        _clientList.add(ClientList(
          name: element.name,
          address: element.address,
          phone: element.phone,
          ownerId: int.tryParse(element.ownerId),
        ));
        notifyListeners();
      }
    }
  }
}

Future<Box> openClientBox() async {
  var box = await Hive.openBox<ClientModel>("client");
  return box;
}
