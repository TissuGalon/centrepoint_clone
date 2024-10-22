import 'package:cached_network_image/cached_network_image.dart';
import 'package:policy_centrepoint/COMPONENT/component.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:flutter/material.dart';
import 'package:policy_centrepoint/CONTROLLER/AuthProcess.dart';
import 'package:policy_centrepoint/CONTROLLER/PointController.dart';
import 'package:policy_centrepoint/CONTROLLER/StyleController.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/KegiatanPage/KegiatanPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/PROFILPAGE/EditProfilPage.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/UANG_KHAS/UangKhas_page.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/MembersPage/all_members.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoadingProfil = false;
  bool isLoading = false;
  bool isLoadingCarousel = false;
  Map<String, String?>? userData;
  int totalPoints = 0;
  List<String> imageUrls = [];

  Future<void> _loadUserData() async {
    setState(() {
      isLoadingProfil = true;
    });
    /* GET POINT */
    /*  final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      totalPoints = await getUserPoints(userId) ?? 0;
      prefs.setString('points', totalPoints.toString());
    } */
    /* GET POINT */

    userData = await getLoginInfo();

    setState(() {
      isLoadingProfil = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCarouselImages();
    _loadUserData();
  }

  Future<void> _loadCarouselImages() async {
    try {
      // First, check if the images are stored in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? cachedImages = prefs.getStringList('carouselImages');

      if (cachedImages != null && cachedImages.isNotEmpty) {
        // Use cached images if available
        setState(() {
          imageUrls = cachedImages;
        });
        print('Loaded carousel images from cache');
      } else {
        // If not cached, fetch from the server
        List<String> images = await CarouselService.getAllCarousels();
        setState(() {
          imageUrls = images; // Save the list of image URLs to the state
        });
        // Save the fetched images to SharedPreferences
        prefs.setStringList('carouselImages', images);
        print('Carousel images fetched and saved to cache');
      }
    } catch (e) {
      print('Error loading carousel images: $e');
    }
  }

  // Clear Homepage Image Cache
  Future<void> _clearCachedCarouselImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('carouselImages');
    print('Cached carousel images cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: SingleChildScrollView(
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          backgroundColor:
                              WidgetStateProperty.all(Colors.grey.shade50),
                        ),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        label: Text(
                          'Pencarian',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      children: [],
                    ),
                  ],
                ),
              ),

              //CAROUSEL
              isLoadingCarousel
                  ? Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      child: buildShimmerWidget(double.infinity, 175),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 1.0, left: 5, right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 175, // Set the height of the carousel
                            aspectRatio:
                                16 / 9, // Set the aspect ratio of the carousel
                            autoPlay:
                                true, // Enable auto-play for automatic sliding
                            enlargeCenterPage: true, // Center item is enlarged
                          ),
                          items: imageUrls.map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                  child: CachedNetworkImage(
                                    imageUrl: url,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                            top: 5),
                                        child: buildShimmerWidget(
                                            double.infinity, 175),
                                      ),
                                    ), // Placeholder while loading
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error), // Error widget
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),

              //CAROUSEL

              //LEVEL BAR
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilPage(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    backgroundColor:
                        Colors.white, // Set the text color to orange
                  ),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            isLoadingProfil
                                ? buildShimmerAvatar(25)
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/icon/man.png'),
                                    radius: 25,
                                  ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  isLoadingProfil
                                      ? CentrepointLoading(
                                          color: Warna.TextBold,
                                          size: 25,
                                        )
                                      : Text(
                                          '@${userData!['username']}'
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: 'URW',
                                              fontSize: 18,
                                              color: Warna.TextBold,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  Row(
                                    children: [
                                      isLoadingProfil
                                          ? CentrepointLoading(
                                              color: Warna.TextBold,
                                              size: 25,
                                            )
                                          : Text(
                                              '${userData!['role_name']}'
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontFamily: 'URW',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Warna.Primary),
                                            ),
                                      Text(
                                        '•',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Text(
                                          '${isLoadingProfil ? '0' : userData!['points']}',
                                          style:
                                              TextStyle(color: Warna.Primary),
                                        ),
                                      ),
                                      Text(
                                        'Poin',
                                        style:
                                            TextStyle(color: Warna.TextNormal),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Warna.Primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //LEVEL BAR

              SizedBox(
                height: 10,
              ),

              //DISINI
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CellWidget(
                            firstLineGambar: 'assets/icon/member.png',
                            secondLineText: 'ALL MEMBERS',
                            navigateTo: AllMembers(),
                          ),
                        ),
                        /* Expanded(
                        child: CellWidget(
                          firstLineGambar: 'assets/icon/grocery.png',
                          secondLineText: 'Produk Grosir',
                        ),
                      ), */
                        Expanded(
                          child: CellWidget(
                            firstLineGambar: 'assets/icon/date.png',
                            secondLineText: 'KEGIATAN',
                            navigateTo: KegiatanPage(),
                          ),
                        ),
                        Expanded(
                          child: CellWidget(
                            firstLineGambar: 'assets/icon/khas.png',
                            secondLineText: 'UANG KHAS',
                            navigateTo: UangKhasPage(),
                          ),
                        ),
                      ],
                    ),
                    /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CellWidget(
                        firstLineGambar: 'assets/images/me.jpeg',
                        secondLineText: 'Line 2 Text',
                      ),
                    ),
                    Expanded(
                      child: CellWidget(
                        firstLineGambar: 'assets/images/me.jpeg',
                        secondLineText: 'Line 2 Text',
                      ),
                    ),
                    Expanded(
                      child: CellWidget(
                        firstLineGambar: 'assets/images/me.jpeg',
                        secondLineText: 'Line 2 Text',
                      ),
                    ),
                    Expanded(
                      child: CellWidget(
                        firstLineGambar: 'assets/images/me.jpeg',
                        secondLineText: 'Line 2 Text',
                      ),
                    ),
                  ],
                ), */
                  ],
                ),
              ),

              //DISINI

              //DISINI

              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* SHIMMER HOMEPAGE */
class CarouselShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.all(5),
        height: 175,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(11)),
      ),
    );
  }
}

class USerCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          buildShimmerAvatar(25),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                buildShimmerWidget(double.infinity, 15),
                SizedBox(
                  height: 5,
                ),
                buildShimmerWidget(double.infinity, 15)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 10, right: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Color(0xFF7E7E7E),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 14.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11)),
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

class NewsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 8),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(11)),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
/* SHIMMER HOMEPAGE */

/* CELL WIDGET */
class CellWidget extends StatelessWidget {
  final String firstLineGambar;
  final String secondLineText;
  final Widget navigateTo; // Halaman tujuan

  CellWidget({
    required this.firstLineGambar,
    required this.secondLineText,
    required this.navigateTo, // Tambahkan halaman tujuan
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigateTo),
            ); // Navigasi ke halaman tujuan
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                firstLineGambar, // Path gambar
                width: 50,
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                secondLineText,
                style: TextStyle(
                    fontSize: 14,
                    color: Warna.TextBold,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'URW'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} /* CELL WIDGET */
