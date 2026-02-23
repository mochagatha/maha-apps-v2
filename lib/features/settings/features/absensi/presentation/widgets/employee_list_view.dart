import 'package:flutter/material.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({
    super.key,
    required this.searchController,
    required this.onItemTap,
  });

  final TextEditingController searchController;
  final VoidCallback onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: TextField(
            controller: searchController,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: "Cari karyawan disini...",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
            return InkWell(
            onTap: onItemTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama Karyawan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Software Engineer",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
