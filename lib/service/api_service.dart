import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  final crateUrl =
      'https://mtest.certifired.certifired.com.au/api2/clients/create';

  final getClientUrl =
      'https://mtest.certifired.certifired.com.au/api2/clients';

  Map<String, String> headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbXRlc3QuY2VydGlmaXJlZC5jZXJ0aWZpcmVkLmNvbS5hdVwvYXBpMlwvbG9naW4iLCJpYXQiOjE2Nzg2ODM1ODksImV4cCI6MTY4Mzg2NzU4OSwibmJmIjoxNjc4NjgzNTg5LCJqdGkiOiI4QVFIb24wNW12Z0FHeW1QIiwic3ViIjoxOTIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.brBLWz3QqG4LzEBnKYqN2w1SlFMsVUssZAuocIpDV70'
  };

  Future getData() async {
    try {
      final response =
          await http.get(Uri.parse(getClientUrl), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<dynamic> postData(body) async {
    try {
      final response =
          await http.post(Uri.parse(crateUrl), headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
