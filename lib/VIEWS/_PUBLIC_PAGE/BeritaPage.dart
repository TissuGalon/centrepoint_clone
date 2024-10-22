import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:policy_centrepoint/COMPONENT/shimmer_custom.dart';
import 'package:policy_centrepoint/CONFIGURATION/configuration.dart';
import 'package:flutter/material.dart';

class BeritaPage extends StatefulWidget {
  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BG,
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Icon(TablerIcons.news),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'BERITA',
                    style: TextStyle(
                        color: Warna.TextBold,
                        fontFamily: 'URW',
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            /* -- */
            Expanded(
              child: ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: 8, right: 8, top: 5, bottom: 5),
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn3d.iconscout.com/3d/premium/thumb/newspaper-3d-icon-download-in-png-blend-fbx-gltf-file-formats--newsletter-news-press-media-entertainment-pack-multimedia-icons-4756479.png', // Replace with your image URL
                                  placeholder: (context, url) =>
                                      buildShimmerWidget(50,50), // Optional placeholder while loading
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error), // Optional error widget
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Berita',
                                    style: TextStyle(
                                        color: Warna.TextBold,
                                        fontFamily: 'URW',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nulla consectetur, error sint voluptates odit cupiditate perspiciatis suscipit odio maxime, quia et nam quos deleniti excepturi, consequuntur veniam nemo ex voluptatibus?',
                                    style: TextStyle(
                                        color: Warna.TextBold,
                                        fontFamily: 'URW',
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Icon(
                              TablerIcons.chevron_right,
                              color: Warna.Primary,
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            /* -- */
          ],
        ),
      ),
    );
  }
}
