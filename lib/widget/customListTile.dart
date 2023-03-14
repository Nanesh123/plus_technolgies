import 'package:flutter/material.dart';
import 'package:plus_technolgies/model/clientList.dart';
import 'package:plus_technolgies/provider/client_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.client});
  final ClientList client;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Container(
      height: 56,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              color: Colors.grey.shade300,
            ),
            child: const Icon(Icons.person, color: Colors.grey, size: 22),
          ),
          const SizedBox(width: 7.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  client.name.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),

                ///
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.orange, size: 11),
                    Expanded(
                      child: Text(
                        client.address.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 7.0),
          Expanded(
            child: buildActionButton(context, client),
          ),
          const SizedBox(width: 5.0),
        ],
      ),
    );
  }

  buildActionButton(context, item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.delete, color: Colors.red, size: 20),
        const SizedBox(width: 7.0),
        const Icon(Icons.edit, color: Colors.grey, size: 20),
        const SizedBox(width: 7.0),
        if (item.id == null)
          InkWell(
              onTap: () async {
                final result =
                    await Provider.of<ClientProvider>(context, listen: false)
                        .addClient(
                            item.name, item.phone, item.address, item.ownerId);

                // Toast.show('$result',
                //     duration: Toast.lengthLong, gravity: Toast.bottom);
              },
              child: const Icon(Icons.sync, color: Colors.grey, size: 20)),
      ],
    );
  }
}

class CustomListTileInheritedWdget extends InheritedWidget {
  final int index;
  final int length;

  const CustomListTileInheritedWdget({
    Key? key,
    required this.index,
    required this.length,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CustomListTileInheritedWdget oldWidget) {
    return oldWidget.index != index || oldWidget.index != index;
  }
}
