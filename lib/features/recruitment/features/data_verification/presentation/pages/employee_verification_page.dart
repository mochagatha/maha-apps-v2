import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/route_names.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import '../../../../../../core/utils/localization_extension.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';

class EmployeeVerificationPage extends StatelessWidget {
  const EmployeeVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusList = [
      "Baru",
      "Diperiksa",
      "Disetujui",
      "Direvisi",
    ];

    return DefaultTabController(
      length: statusList.length + 1,
      child: Scaffold(
        appBar: CustomAppBar(title: context.l10n.employeeVerificationTitle),
        body: Column(
          children: [
            TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.grey,
              tabs: [
                _TabBarItem(title: "Semua", count: 0),
                ...statusList.map((label) {
                  return _TabBarItem(title: label, count: 0);
                }),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //-----------/ Semua /-----------//
                  ListView(
                    children: [
                      _DataItem(
                        id: 1,
                        photoUrl: "",
                        name: "Akun Demo IT",
                        nik: 12345,
                        department: "IT Programming",
                        jobTitle: "Information Technology",
                        status: 0,
                      ),
                      _DataItem(
                        id: 1,
                        photoUrl: "",
                        name: "Akun Demo IT",
                        nik: 12345,
                        department: "IT Programming",
                        jobTitle: "Information Technology",
                        status: 1,
                      ),
                      _DataItem(
                        id: 1,
                        photoUrl: "",
                        name: "Akun Demo IT",
                        nik: 12345,
                        department: "IT Programming",
                        jobTitle: "Information Technology",
                        status: 2,
                      ),
                    ],
                  ),

                  //-----------/ Status Lain /-----------//
                  ...List.generate(statusList.length, (status) {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _DataItem(
                          id: 1,
                          photoUrl: "",
                          name: "Akun Demo IT",
                          nik: 12345,
                          department: "IT Programming",
                          jobTitle: "Information Technology",
                          status: status,
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  const _DataItem({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.nik,
    required this.department,
    required this.jobTitle,
    required this.status,
  });

  final int id;
  final String photoUrl;
  final String name;
  final int nik;
  final String department;
  final String jobTitle;
  final int status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          RouteNames.employeePersonalData,
          extra: {"id": id},
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(bottom: 8),
        shadowColor: Colors.black38,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (status == 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(40),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      "Baru",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),

              Row(
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Akun Demo IT",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMeta(
                                    assetIcon:
                                        "assets/images/icon/ic_id_card.svg",
                                    label: nik.toString(),
                                  ),
                                  _buildMeta(
                                    assetIcon:
                                        "assets/images/icon/ic_outline-phone.svg",
                                    label: "Verifikasi Data",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMeta(
                                    assetIcon:
                                        "assets/images/icon/ic_building.svg",
                                    label: department,
                                  ),
                                  _buildMeta(
                                    assetIcon:
                                        "assets/images/icon/ic_building.svg",
                                    label: jobTitle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeta({required String assetIcon, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SvgPicture.asset(
            assetIcon,
            height: 20,
            width: 20,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
