import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/MembersPage/members_detail.dart';

class AllMembers extends StatefulWidget {
  @override
  _AllMembersState createState() => _AllMembersState();
}

class _AllMembersState extends State<AllMembers> {
  String? selectedYear;
  List<String> years = ['2021', '2022', '2023', '2024', '2025'];

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Text(
            'ALL MEMBERS',
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold,
        ),
      ),
      backgroundColor: Warna.BG,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedYear,
                        hint: Text(
                          'Pilih Tahun',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        isExpanded: true,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: years.map((String year) {
                          return DropdownMenuItem<String>(
                            value: year,
                            child: Text(
                              year,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedYear = newValue;
                          });
                        },
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      ButtonsTabBar(
                        backgroundColor: Colors.red,
                        unselectedBackgroundColor: Colors.grey[300],
                        unselectedLabelStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            child: Image.asset(
                              'assets/icon/member.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Tab(
                            child: Image.asset(
                              'assets/icon/boy.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Tab(
                            child: Image.asset(
                              'assets/icon/girl.png',
                              height: 120,
                              width: 120,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            /* ALL */
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return buildMemberCard(
                                  name: 'Members Name',
                                  badgeIcon: TablerIcons.user,
                                  badgeText: 'Member',
                                  imagePath: 'assets/images/me.jpeg',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MembersDetail(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            /* ALL */
                            /* BOY */
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return buildMemberCard(
                                  name: 'Members Name',
                                  badgeIcon: TablerIcons.users_group,
                                  badgeText: 'Pengurus',
                                  imagePath: 'assets/images/me.jpeg',
                                  badgeColor: Colors.blue,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MembersDetail(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            /* BOY */
                            /* GIRL */
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return buildMemberCard(
                                  name: 'Members Name',
                                  badgeIcon: TablerIcons.crown,
                                  badgeText: 'Ketua Umum',
                                  imagePath: 'assets/images/me.jpeg',
                                  badgeColor: Colors.yellow,
                                  badgeTextColor: Colors.black,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MembersDetail(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            /* GIRL */
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMemberCard({
  required String name,
  required String imagePath,
  required String badgeText,
  required IconData badgeIcon,
  required VoidCallback onPressed,
  Color badgeColor = Colors.blueGrey,
  Color badgeTextColor = Colors.white,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(255, 234, 238, 240),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 25,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => buildShimmerAvatar(25),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/icon/man.png'),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontFamily: 'Graphik',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeColor, // Warna badge dinamis
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          badgeIcon,
                          color: badgeTextColor,
                        ),
                        SizedBox(width: 5),
                        Text(
                          badgeText,
                          style: TextStyle(
                            color: badgeTextColor,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 3),
            child: Icon(TablerIcons.chevron_right),
          )
        ],
      ),
    ),
  );
}
