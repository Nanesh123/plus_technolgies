import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plus_technolgies/provider/client_provider.dart';
import 'package:plus_technolgies/screen/add_client_screen.dart';
import 'package:plus_technolgies/widget/customListTile.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'CLIENTS',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          _actionButton(context),
        ],
      ),
      body: const ClientScreenBody(),
      floatingActionButton: Consumer<ClientProvider>(
        builder: (context, value, child) => FloatingActionButton(
          onPressed: () {
            value.startSync();
          },
          child: value.isCompleteSync
              ? const CircularProgressIndicator()
              : const Icon(Icons.sync, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  _actionButton(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      margin: EdgeInsets.only(right: 10.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddClientScreen(),
                ));
          },
          child: const Icon(Icons.add, color: Colors.black, size: 20)),
    );
  }
}

class ClientScreenBody extends StatefulWidget {
  const ClientScreenBody({super.key});

  @override
  State<ClientScreenBody> createState() => _ClientScreenBodyState();
}

class _ClientScreenBodyState extends State<ClientScreenBody> {
  late ClientProvider _clientProvider;
  @override
  void initState() {
    _clientProvider = Provider.of<ClientProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _clientProvider.getCient();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (context, value, child) {
        final clientList = value.clientList;

        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => await _clientProvider.getCient(),
          child: ListView.builder(
            itemCount: clientList.length,
            itemBuilder: (context, index) {
              return CustomListTileInheritedWdget(
                index: index,
                length: clientList.length,
                child: CustomListTile(client: clientList[index]),
              );
            },
          ),
        );
      },
    );
  }
}
