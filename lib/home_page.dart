import 'dart:math';

import 'package:blogapp/banner_ad_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{

  InterstitialAd mInterstitial;

  InterstitialAd buildInterstialAd(){
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event){
        if(event == MobileAdEvent.failedToLoad){
          mInterstitial..load();
        }else if(event == MobileAdEvent.closed){
          mInterstitial = buildInterstialAd()..load();
        }
        print(event); 
      }
    );
  }
  void showInterstitialAd(){
    mInterstitial.show();
  }

  void showRandomInterstitialAd() {
    Random r = new Random();
    bool value = r.nextBool();

    if (value == true) {
      mInterstitial..show();
    }
  }
  @override
  void initState() {
    super.initState();
    mInterstitial = buildInterstialAd()..load();
  }

  @override
  void dispose() {
    mInterstitial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Test Ad App",)),
      body: Center(
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Banner Ad"),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BannerAdPage()));
              },
            ),
            RaisedButton(
              child: Text("Interstitial ad"),
              onPressed: (){
                showInterstitialAd();
              },
            )
          ],
        ),
      ),

    );
  }
}