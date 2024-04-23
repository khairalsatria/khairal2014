// import "package:flutter/material.dart";
// import "package:khairal2014/lat_model/model_user.dart";
// import "package:khairal2014/lat_screen.page/lat_page_list_berita.dart";
// import "package:khairal2014/lat_screen.page/lat_page_pegawai.dart";
// import "package:khairal2014/lat_screen.page/lat_page_profile.dart";
// import "package:khairal2014/lat_screen.page/lat_page_register_api.dart";
// import "package:khairal2014/model/model_users.dart";
// import "package:khairal2014/screen.page/page_list_users.dart";
//
// class LatPageNavBottom extends StatefulWidget {
//   const LatPageNavBottom({super.key});
//
//   @override
//   State<LatPageNavBottom> createState() => _LatPageNavBottom();
// }
//
// class _LatPageNavBottom extends State<LatPageNavBottom> with SingleTickerProviderStateMixin{
//   TabController? tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: tabController,
//         children: const [
//           LatPageListBerita(),
//           PageListPegawai(),
//           PageProfileUser()
//         ],
//       ),
//
//       bottomNavigationBar: BottomAppBar(
//         child: TabBar(
//           isScrollable: true,
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           controller: tabController,
//           tabs: const [
//             Tab(
//               text: "List Berita",
//               icon: Icon(Icons.image),
//             ),
//             Tab(
//               text: "List Pegawai",
//               icon: Icon(Icons.group),
//             ),
//             Tab(
//               text: "Profile User",
//               icon: Icon(Icons.person),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }