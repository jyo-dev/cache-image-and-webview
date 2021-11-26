import 'package:bsbt/constants.dart';
import 'package:bsbt/model/ketodetails.dart';
import 'package:bsbt/screens/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late List<Ketodetails> ketodetails;
  int length = 0;
  int remainder = 0;
  Future<String> downloadData() async {
    Uri url = Uri.parse(
        "http://cookbook.ai/loopy/loopydata.php?ajax&_id=228acc85c437777874e6cc7e7bccc8c9&data=1&diet=app&email=&appname=keto.weightloss.diet.plan&country=GB&devid=DefaultID1&simcountry=in&version=1.0.77&versioncode=77&lang=en&inputlang=en&network=wifi&catlimit=21&loadcount=2&devtype=p&osver=30&mem=192&mprice=-&yprice=-&radsprice=0&android&n2021&rstream&page=1&num=60");

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      ketodetails = ketodetailsFromJson(response.body);
      length = ketodetails.length ~/ 5;
      remainder = ketodetails.length % 5;
      return Future.value("Data download successfully"); // return your response

      //Provider.of<dataProvider>(context, listen: false).data = storiesobj;
    } else {
      return Future.error(Exception());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: const Text(
            'Articles',
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.black, fontSize: 25),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: downloadData(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // AsyncSnapshot<Your object type>
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ProgressDialogPrimary();
              } else {
                if (snapshot.hasError) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text('Sorry..Something went wrong'));
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustumContainer(
                        widgettype: 'nwider',
                        title: 'Newly Added',
                        length: length,
                        intitialPosition: 0,
                        kdetails: ketodetails,
                      ),
                      CustumContainer(
                        widgettype: 'wider',
                        title: 'Discover',
                        length: length,
                        intitialPosition: length * 1,
                        kdetails: ketodetails,
                      ),
                      CustumContainer(
                        widgettype: 'nwider',
                        title: 'Trending Now',
                        length: length,
                        intitialPosition: length * 2,
                        kdetails: ketodetails,
                      ),
                      CustumContainer(
                        widgettype: 'wider',
                        title: 'Popular Near You',
                        length: length,
                        intitialPosition: length * 3,
                        kdetails: ketodetails,
                      ),
                      CustumContainer(
                        widgettype: 'wider',
                        title: 'More',
                        length: length,
                        intitialPosition: length * 4 + remainder,
                        kdetails: ketodetails,
                      ),
                    ],
                  ); // snaps
                }
              }
            },
          ),
        )),
      ),
    );
  }
}

class CustumContainer extends StatelessWidget {
  const CustumContainer(
      {Key? key,
      required this.title,
      required this.kdetails,
      required this.length,
      required this.intitialPosition,
      required this.widgettype})
      : super(key: key);
  final String title;
  final List<Ketodetails> kdetails;
  final int length;
  final int intitialPosition;
  final String widgettype;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: widgettype == 'wider' ? 140.h : 175.h,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F7),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: 70.h,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(title,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 19),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8, right: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: widgettype == 'wider' ? 190.0.h : 220.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: length,
                          itemBuilder: (_, index) {
                            int dataIndex = intitialPosition + index;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SlideRightRoute(
                                      page: WebViewScreen(
                                        url:
                                            'https://cookbookapp.in/RIA/play/readingRoom.html?id=' +
                                                kdetails[index].id,
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: widgettype == 'wider'
                                          ? 210.0.w
                                          : 140.w,
                                      height: widgettype == 'wider'
                                          ? 120.0.h
                                          : 150.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: OptimizedCacheImageProvider(
                                                kdetails[dataIndex].img[0])),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        //color: Colors.redAccent,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 10, right: 5),
                                      child: SizedBox(
                                        width: widgettype == 'wider'
                                            ? 190.0.w
                                            : 120.w,
                                        height: 40.h,
                                        child: RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              const StrutStyle(fontSize: 12.0),
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              text: kdetails[dataIndex]
                                                  .description),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class ProgressDialogPrimary extends StatelessWidget {
  const ProgressDialogPrimary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150.h,
        ),
        Center(
          child: SizedBox(
            height: 30.h,
            width: 30.h,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),
        const Text('Please wait..')
      ],
    );
  }
}
