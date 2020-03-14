import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi/wifi.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return new MaterialApp(
title: 'Wifi',
theme: new ThemeData(
primarySwatch: Colors.blue,
),
home: new MyHomePage(),
);
}
}

class MyHomePage extends StatefulWidget {
@override
_MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
int level =0;
String _wifiName = 'click button to get wifi ssid.';
String _ip = 'click button to get ip.';
String ssid = '', password = '';
List <WifiResult> ssidList = [];
@override
void initState() {
super.initState();
loadData();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('WIFI'),
centerTitle: true,
),
body: SafeArea(
child: ListView.builder(
padding: EdgeInsets.all(15.0),
itemCount: ssidList.length + 1,
itemBuilder: (BuildContext context, int index) {
return itemSSID(index);
},
),
),
);
}

Widget itemSSID(index) {
if (index == 0) {
return Column(
children: [
Row(
children: <Widget>[
RaisedButton(
child: Text('ssid'),
onPressed: _getWifiName,
),
SizedBox(width: 10,),
Text(_wifiName),
],
),
Row(
children: <Widget>[
RaisedButton(
child: Text('ip'),
onPressed: _getIP,
),
SizedBox(width: 10,),
Text(_ip),
],
),
TextField(
decoration: InputDecoration(
filled: true,
hintText: 'SSID',
labelText: 'SSID',
prefixIcon: Icon(
  Icons.wifi
),
border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0)
),
),
keyboardType: TextInputType.text,
onChanged: (value) {
ssid = value;
},
),
SizedBox(height: 10,),
TextField(
decoration: InputDecoration(
filled: true,
labelText: 'Password',
hintText: 'Password',
prefixIcon: Icon(
  Icons.lock_outline
),
border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
),
),
keyboardType: TextInputType.text,
onChanged: (value) {
password = value;
},
),
RaisedButton(
child: Text('Connection'),
onPressed: connection,
),
],
);
} else {
return Column(children: <Widget>[
ListTile(
leading: Icon(Icons.wifi_lock,
color: Colors.black,
),
title: Text(
ssidList[index - 1].ssid,
style: TextStyle(
color: Colors.black,
fontSize: 16.0,
),
),
dense: true,
),
Divider(),
]);
}
}

void loadData() {
Wifi.list('').then((list) {
setState(() {
ssidList = list;
});
});
}

Future<Null> _getWifiName() async {
String wifiName = await Wifi.ssid;
setState(() {
_wifiName = wifiName;
});
}

Future<Null> _getIP() async {
String ip = await Wifi.ip;
setState(() {
_ip = ip;
});
}

Future<Null> connection() async {
Wifi.connection(ssid, password).then((v) {
print(v);
});
}
}