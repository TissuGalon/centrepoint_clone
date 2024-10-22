import 'package:flutter/material.dart';
import 'package:policy_centrepoint/VIEWS/_PUBLIC_PAGE/CHATPAGES/ChatRoom.dart';
import 'package:policy_centrepoint/configuration/configuration.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: const [
          Text(
            'CHAT',
            style: TextStyle(
                color: Color(0xFF222222),
                fontFamily: 'URW',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 10,
          )
        ],
        iconTheme: IconThemeData(
          color: Warna.TextBold, // Change the drawer icon color here
        ),
      ),
      backgroundColor: Warna.BG,
      body: /* UMUM */
          SingleChildScrollView(
        child: Column(
          children: [
            /* SEARCH */
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        backgroundColor: WidgetStateProperty.all(
                            Colors.grey.shade50), // Background color
                      ),
                      icon: const Icon(
                        TablerIcons.search,
                        color: Colors.black54,
                      ),
                      label: const Text('Cari Percakapan',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
            /* SEARCH */
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 3, bottom: 3, left: 8, right: 8),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => ChatRoom())),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/avatar1.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Kontak',
                                    style: TextStyle(
                                      fontFamily: 'URW',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Warna.TextBold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Selamat Siang Pak...',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Warna.TextNormal),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '12:50',
                                style: TextStyle(
                                    fontFamily: 'URW',
                                    fontWeight: FontWeight.bold,
                                    color: Warna.TextBold,
                                    fontSize: 12),
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
            Center(
              child: Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  'assets/icon/coming-soon2.png',
                  scale: 3,
                ),
              ),
            ),
          ],
        ),
      ),
      //UMUM
    );
  }
}

/* ________________________________________________________________ */
