import 'package:flutter/material.dart';
import 'package:maha_apps_v2/widgets/appbar.dart';
import 'package:maha_apps_v2/widgets/colors.dart';
import 'package:provider/provider.dart';

import '../../widgets/font.dart';
import '../../widgets/text_field.dart';
import '../view_models/view_model_sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late ViewModelSignUp viewModel;

  initState() {
    super.initState();
    viewModel = Provider.of<ViewModelSignUp>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AwesomeAppBarWithButton(title: 'Buat Akun'),
      body: viewModel.isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child: customTextFieldApprovalTitleCustom(
                        //     formatMoney: true,
                        //     isEnabled: false,
                        //     top: 0,
                        //     title: "",
                        //     context: context,
                        //     controller: controller.status,
                        //     labelText: 'Masukkan Keterangan..',
                        //     textValueKosong: 'Masukkan Keterangan..',
                        //     onChanged: (value) {
                        //       setState(() {});
                        //     },
                        //     titleText: RichText(
                        //       text: TextSpan(
                        //         text: "Status",
                        //         style: AppTextStyles.subtitleStyle(
                        //           context,
                        //         ).copyWith(color: const Color(0xff404040)),
                        //         children: [
                        //           TextSpan(
                        //             text: ' ',
                        //             style: AppTextStyles.subtitleTwoSemiBold()
                        //                 .copyWith(color: Colors.red),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     keyboardType: num == true
                        //         ? TextInputType.number
                        //         : TextInputType.text,
                        //     // prefixIcon: Padding(
                        //     //   padding: const EdgeInsets.only(
                        //     //     left: 12,
                        //     //     right: 8,
                        //     //     top: 12,
                        //     //   ),
                        //     //   child: Text(
                        //     //     'Rp',
                        //     //     style: TextStyle(
                        //     //       fontWeight: FontWeight.bold,
                        //     //       color: Colors.grey[800],
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //   ),
                        // ),
                        // const CustomLabel(text: 'Nama'),
                        // CustomTextFormField(
                        //   paddingTop: 10,
                        //   controller: _nama,
                        //   // focusNode: _namaFocusNode,
                        //   labelText: 'Masukkan nama anda..',
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Masukkan nama anda..';
                        //     }
                        //     return null;
                        //   },
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                        //   ],
                        //   onSaved: (value) {
                        //     _nama.text = value!;

                        //     setState(() {
                        //       checkFormCompletion();
                        //     });
                        //   },
                        //   onChanged: (String? newValue) {
                        //     setState(() {
                        //       checkFormCompletion();
                        //     });
                        //   },
                        // ),
                        // const CustomLabel(text: 'Email'),
                        // CustomTextFormField(
                        //   paddingTop: 10,
                        //   controller: _email,
                        //   // focusNode: _emailFocusNode,
                        //   labelText: '-',
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Email tidak boleh kosong!';
                        //     } else if (!value.endsWith('@mahasejahtera.com') &&
                        //         !value.endsWith('@staffmahasejahtera.com')) {
                        //       return '@mahasejahtera.com atau @staffmahasejahtera.com';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (value) {
                        //     _email.text = value!;
                        //     setState(() {
                        //       checkFormCompletion();
                        //     });
                        //   },
                        //   onChanged: (String? newValue) {
                        //     setState(() {
                        //       checkFormCompletion();
                        //     });
                        //   },
                        // ),
                        // const CustomLabel(text: 'Kata Sandi'),
                        // CustomTextFormField(
                        //   paddingTop: 10,
                        //   // focusNode: _passwordFocusNode,
                        //   controller: _pass,
                        //   obscureText: _isObscure,
                        //   labelText: 'Masukkan kata sandi anda..',
                        //   suffixIcon: IconButton(
                        //     icon: Icon(
                        //       _isObscure
                        //           ? Icons.visibility_off
                        //           : Icons.visibility,
                        //     ),
                        //     color: _isObscure
                        //         ? AppColors.secondaryColor
                        //         : AppColors.primaryColor,
                        //     onPressed: () {
                        //       setState(() {
                        //         _isObscure = !_isObscure;
                        //         checkFormCompletion();
                        //       });
                        //     },
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Password tidak boleh kosong !';
                        //     } else if (value.length < 6) {
                        //       return 'Password minimal 6 karakter';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (value) {
                        //     _pass.text = value!;
                        //   },
                        //   onChanged: (String? newValue) {
                        //     setState(() {
                        //       checkFormCompletion();
                        //     });
                        //   },
                        // ),
                        // const CustomLabel(text: 'Departemen/Divisi'),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0),
                        //   child: Consumer<GetAllDepartementProvider>(
                        //     builder: (context, getAllDepartementProvider, child) {
                        //       return DropdownButtonFormField<String>(
                        //         value: _deptOption,
                        //         // focusNode: _devisiFocusNode,
                        //         items: getAllDepartementProvider.departements
                        //             .map<DropdownMenuItem<String>>((
                        //               DataDepartement departement,
                        //             ) {
                        //               return DropdownMenuItem<String>(
                        //                 value: departement.id.toString(),
                        //                 child: Text(departement.departmentName),
                        //               );
                        //             })
                        //             .toList(),
                        //         validator: (value) {
                        //           if (value == null || value.isEmpty) {
                        //             return 'Departemen tidak boleh kosong !';
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (String? newValue) {
                        //           setState(() {
                        //             _deptOption = newValue;
                        //             _jobOption = null;
                        //             _isJobDropdownEnabled = false;
                        //           });
                        //           // if (newValue != null) {
                        //           //   Provider.of<GetAllJobTitleProvider>(context,
                        //           //           listen: false)
                        //           //       .fetchPositionsPV(newValue)
                        //           //       .then((_) {
                        //           //     setState(() {
                        //           //       _isLoadingJob = false;
                        //           //     });
                        //           //   });
                        //           // }
                        //           setState(() {
                        //             checkFormCompletion();
                        //           });
                        //           if (newValue != null) {
                        //             final selectedDept =
                        //                 getAllDepartementProvider.departements
                        //                     .firstWhere(
                        //                       (dept) =>
                        //                           dept.id.toString() ==
                        //                           newValue,
                        //                     );

                        //             // Perbarui _filteredJobTitles dengan JobTitle dari departemen yang dipilih
                        //             setState(() {
                        //               getAllDepartementProvider.jobTitlesList =
                        //                   selectedDept.jobTitle;
                        //               _isJobDropdownEnabled = true;
                        //             });
                        //           }
                        //         },
                        //         decoration: dropdownInputDecoration.copyWith(
                        //           labelText: 'Pilih departemen anda .. ',
                        //         ),
                        //         menuMaxHeight: 200.0,
                        //       );
                        //     },
                        //   ),
                        // ),
                        // const CustomLabel(text: 'Jabatan'),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0),
                        //   child: Consumer<GetAllDepartementProvider>(
                        //     builder:
                        //         (context, getAllDepartementProvider, child) {
                        //           return DropdownButtonFormField<String>(
                        //             value: _jobOption,
                        //             // focusNode: _jabatanFocusNode,
                        //             items: getAllDepartementProvider
                        //                 .jobTitlesList
                        //                 .map<DropdownMenuItem<String>>((
                        //                   JobTitleByDepertemen jobTitle,
                        //                 ) {
                        //                   return DropdownMenuItem<String>(
                        //                     value: jobTitle.id.toString(),
                        //                     child: Text(jobTitle.name),
                        //                   );
                        //                 })
                        //                 .toList(),
                        //             validator: (value) {
                        //               if (value == null || value.isEmpty) {
                        //                 return 'Jabatan tidak boleh kosong !';
                        //               }
                        //               return null;
                        //             },
                        //             onChanged: _isJobDropdownEnabled
                        //                 ? (String? newValue) {
                        //                     setState(() {
                        //                       _jobOption = newValue;

                        //                       checkFormCompletion();
                        //                     });
                        //                   }
                        //                 : null,
                        //             decoration: dropdownInputDecoration
                        //                 .copyWith(
                        //                   labelText: 'Pilih jabatan anda .. ',
                        //                 ),
                        //             menuMaxHeight: 200.0,
                        //           );
                        //         },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0),
                        //   child: _isLoadingJob
                        //       ? const Center(
                        //           child: CircularProgressIndicator(
                        //             color: AppColors.primaryColor,
                        //           ),
                        //         )
                        //       : Consumer<GetAllJobTitleProvider>(
                        //           builder: (context, getAllJobTitleProvider, child) {
                        //             return DropdownButtonFormField<String>(
                        //               value: _jobOption,
                        //               focusNode: _jabatanFocusNode,
                        //               items: getAllJobTitleProvider.positions
                        //                   .map<DropdownMenuItem<String>>(
                        //                       (DataJob job) {
                        //                 return DropdownMenuItem<String>(
                        //                   value: job.id.toString(),
                        //                   child: Text(screenWidth >= 360
                        //                       ? truncateString(job.name)
                        //                       : job.name),
                        //                 );
                        //               }).toList(),
                        //               validator: (value) {
                        //                 if (value == null || value.isEmpty) {
                        //                   return 'Jabatan tidak boleh kosong !';
                        //                 }
                        //                 return null;
                        //               },
                        //               onChanged: (String? newValue) {
                        //                 setState(() {
                        //                   _jobOption = newValue;
                        //                 });
                        //                 setState(() {
                        //                   checkFormCompletion();
                        //                 });
                        //               },
                        //               decoration: dropdownInputDecoration.copyWith(
                        //                 labelText: 'Pilih jabatan anda .. ',
                        //               ),
                        //               menuMaxHeight: 200.0,
                        //             );
                        //           },
                        //         ),
                        // ),
                        // const CustomLabel(text: 'Lokasi Kerja'),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0),
                        //   child: Consumer<GetAllBranchProvider>(
                        //     builder: (context, getAllBranchProvider, child) {
                        //       // Hapus duplikat berdasarkan branchCode
                        //       final uniqueBranches = getAllBranchProvider
                        //           .branchs
                        //           .fold<Map<String, DataBranchGlobal>>({}, (
                        //             map,
                        //             branch,
                        //           ) {
                        //             map[branch.branchCode] =
                        //                 branch; // Gunakan branchCode sebagai kunci
                        //             return map;
                        //           })
                        //           .values
                        //           .toList();

                        //       return DropdownButtonFormField<String>(
                        //         isExpanded: true,
                        //         value: _lokOption,
                        //         items: uniqueBranches
                        //             .map<DropdownMenuItem<String>>((
                        //               DataBranchGlobal branch,
                        //             ) {
                        //               return DropdownMenuItem<String>(
                        //                 value: branch.branchCode,
                        //                 child: Text(
                        //                   branch.branchName,
                        //                   overflow: TextOverflow
                        //                       .ellipsis, // Potong teks panjang
                        //                   maxLines: 1,
                        //                 ),
                        //               );
                        //             })
                        //             .toList(),
                        //         validator: (value) {
                        //           if (value == null || value.isEmpty) {
                        //             return 'Lokasi tidak boleh kosong !';
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (String? newValue) {
                        //           setState(() {
                        //             _lokOption = newValue;
                        //           });
                        //           checkFormCompletion();
                        //         },
                        //         decoration: dropdownInputDecoration.copyWith(
                        //           labelText: 'Pilih lokasi kerja anda .. ',
                        //         ),
                        //         menuMaxHeight: 200.0,
                        //       );
                        //     },
                        //   ),
                        // ),
                        // const SizedBox(height: 40),
                        // ValueListenableBuilder(
                        //   valueListenable: isButtonEnabled,
                        //   builder: (context, bool isEnabled, _) {
                        //     return SizedBox(
                        //       width: double.infinity,
                        //       height: 50,
                        //       child: ElevatedButton(
                        //         onPressed: isEnabled
                        //             ? () async {
                        //                 showLoadingLoginDialog(
                        //                   context,
                        //                   'Sedang memuat, Harap Tunggu...',
                        //                 );
                        //                 _submitForm();
                        //               }
                        //             : null,
                        //         // onPressed: _submitForm,
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: isEnabled
                        //               ? AppColors.primaryColor
                        //               : Colors.grey[400],
                        //           foregroundColor: Colors.white,
                        //           padding: const EdgeInsets.symmetric(
                        //             vertical: 5.0,
                        //           ),
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: AppBorderRadius.roundedBorder,
                        //             side: BorderSide(
                        //               color: isEnabled
                        //                   ? AppColors.primaryColor
                        //                   : Colors.grey,
                        //               width: 1.0,
                        //             ),
                        //           ),
                        //         ),
                        //         child: Text(
                        //           'Buat Akun',
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 16,
                        //             color: isEnabled
                        //                 ? Colors.white
                        //                 : Colors.grey[600],
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                        // const SizedBox(height: 20),
                        // Center(
                        //   child: RichText(
                        //     text: TextSpan(
                        //       style: const TextStyle(
                        //         fontSize: 14,
                        //         color: Colors.grey,
                        //       ),
                        //       children: <TextSpan>[
                        //         const TextSpan(text: 'Sudah punya akun? '),
                        //         TextSpan(
                        //           text: 'Masuk',
                        //           style: const TextStyle(
                        //             color: AppColors.primaryColor,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //           recognizer: TapGestureRecognizer()
                        //             ..onTap = () {
                        //               Navigator.pushReplacementNamed(
                        //                 context,
                        //                 Routes.login,
                        //               );
                        //             },
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
