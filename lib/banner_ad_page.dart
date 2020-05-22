import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerAdPage extends StatefulWidget {
  @override
  _BannerAdPageState createState() => _BannerAdPageState();
}

class _BannerAdPageState extends State<BannerAdPage> {

  BannerAd mBanner;

  BannerAd buildBannerAd(){
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event){
        if(event == MobileAdEvent.loaded){
          mBanner..show();
        }
      }
    );
  }
  BannerAd buildLargeBannerAd(){
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.largeBanner,
      listener: (MobileAdEvent event){
        if(event == MobileAdEvent.loaded){
          mBanner..show(
            anchorType: AnchorType.top,
              anchorOffset: MediaQuery.of(context).size.height * 0.15
          );
        }
      }
    );
  }
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    mBanner = buildLargeBannerAd()..load();
    super.initState();
  }
  @override
  void dispose() {
    mBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Banner Ad Page"),),
    );
  }
}
