import 'package:flutter/material.dart';
import 'package:plus_technolgies/model/clientList.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.client});
  final ClientList client;

  @override
  Widget build(BuildContext context) {
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
          buildActionButton(),
          const SizedBox(width: 5.0),
        ],
      ),

      //  ListTile(
      //   visualDensity: const VisualDensity(vertical: 0),
      //   leading: Container(
      //     height: 45,
      //     width: 45,
      //     color: Colors.grey.shade300,
      //     child: const Icon(Icons.person, color: Colors.grey, size: 22),
      //   ),
      //   title: const Text(
      //     'Client',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 16,
      //     ),
      //   ),
      //   subtitle: Row(
      //     children: const [
      //       Icon(
      //         Icons.location_on,
      //         color: Colors.orange,
      //         size: 12,
      //       ),
      //       Expanded(
      //         child: Text(
      //           'ABC,Safadfgssfsgfs',
      //           maxLines: 1,
      //           style: TextStyle(
      //             color: Colors.grey,
      //             fontSize: 14,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   trailing: buildActionButton(),
      // ),
    );
  }

  buildActionButton() {
    return SizedBox(
      width: 55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.delete, color: Colors.red, size: 20),
          SizedBox(width: 7.0),
          Icon(Icons.edit, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
