import 'package:flutter/material.dart';

class VendorFilterWidget extends StatefulWidget {
  const VendorFilterWidget({Key? key}) : super(key: key);

  @override
  _VendorFilterWidgetState createState() => _VendorFilterWidgetState();
}

class _VendorFilterWidgetState extends State<VendorFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            ActionChip(
                backgroundColor: const Color(0xFF272d2f),
                elevation: 3,
                label: const Text(
                  'All Vendors',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            const SizedBox(
              width: 15,
            ),
            ActionChip(
                backgroundColor: const Color(0xFF272d2f),
                elevation: 3,
                label: const Text(
                  'Active',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            const SizedBox(
              width: 15,
            ),
            ActionChip(
                backgroundColor: const Color(0xFF272d2f),
                elevation: 3,
                label: const Text(
                  'Inactive',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            const SizedBox(
              width: 15,
            ),
            ActionChip(
                backgroundColor: const Color(0xFF272d2f),
                elevation: 3,
                label: const Text(
                  'Top Picked',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            const SizedBox(
              width: 15,
            ),
            ActionChip(
                backgroundColor: const Color(0xFF272d2f),
                elevation: 3,
                label: const Text(
                  'Top Rated',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
