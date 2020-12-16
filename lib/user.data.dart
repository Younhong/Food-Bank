import 'package:flutter/material.dart';
import 'package:food_bank/food.bank.code.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData extends StatefulWidget {
  _UserState createState() => _UserState();
}

class _UserState extends State<UserData> {
  String url = "http://apis.data.go.kr/B460014/foodBankInfoService2/getUserInfo?dataType=json";
  String API_KEY = "use your api key";

  // url + "serviceKey=" + API_KEY
  int numOfRows = 10;
  int pageNo = 1;
  // 201601 - 201912
  String stdrYm = "201702";

  List<int> yearOption = [2016, 2017, 2018, 2019];
  List<String> monthOption = [
    "01", "02", "03", "04", "05", "06",
    "07", "08", "09", "10", "11", "12"
  ];

  int selectedYear = 2016;
  String selectedMonth = "01";

  List userDataList = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("이용자 데이터 조회")
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text("조회할 연도를 선택해주세요"),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: DropdownButton(
              value: selectedYear,
              icon: Icon(Icons.arrow_drop_down),
              items: yearOption.map((int category) {
                return DropdownMenuItem<int>(
                  value: category,
                  child: Text(category.toString()),
                );
              }).toList(),
              onChanged: (int newValue) {
                setState(() {
                  selectedYear = newValue;
                });},
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text("조회할 달을 선택해주세요"),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: DropdownButton(
              value: selectedMonth,
              icon: Icon(Icons.arrow_drop_down),
              items: monthOption.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category.toString()),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  selectedMonth = newValue;
                });},
            ),
          ),
          FlatButton(
            child: Text("조회하기", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange
            ),),
            onPressed: () async {
              await userJson();
            },
          ),
          SizedBox(height: 20,),
          userDataList.isEmpty
              ? Container()
              : Expanded(
              child: ListView.builder(
                  itemCount: userDataList.length,
                  itemBuilder: (context, index) {
                    var item = userDataList[index];
                    print(item);
                    int areaIdx = areaId.indexOf(item['areaCd']);
                    int unityIdx = unitySignguCdId.indexOf(
                      item['unitySignguCd']
                    );
                    int seccdIdx = seccdId.indexOf(item['userSeccd']);
                    int clscdIdx = clscdId.indexOf(item['userClscd']);
                    int centerIdx = centerId.indexOf(item['spctrCd']);
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("푸드뱅크 센터명", style: TextStyle(
                                color: Colors.green
                            ),),
                            SizedBox(width: 7),
                            Text(spctrCd[centerIdx])
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("지역 코드", style: TextStyle(
                              color: Colors.blue
                            ),),
                            SizedBox(width: 7),
                            Text(areaCd[areaIdx])
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("통합시군구코드", style: TextStyle(
                                color: Colors.cyan
                            ),),
                            SizedBox(width: 7),
                            Text(unitySignguCd[unityIdx])
                          ],
                        ),
                        item['happyTrgterYn'] == 'Y'
                            ? Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("행복e음대상자", style: TextStyle(
                                color: Colors.orange
                            ),),
                          ],
                        ) : Container(),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("이용자구분", style: TextStyle(
                                color: Colors.deepOrange
                            ),),
                            SizedBox(width: 7),
                            Text(userSeccd[seccdIdx])
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("이용자분류", style: TextStyle(
                                color: Colors.grey
                            ),),
                            SizedBox(width: 7),
                            Text(userClscd[clscdIdx])
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("이용금액", style: TextStyle(
                                color: Colors.brown
                            ),),
                            SizedBox(width: 7),
                            Text(item['useAmt'] + "원")
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("이용건수", style: TextStyle(
                                color: Colors.purple
                            ),),
                            SizedBox(width: 7),
                            Text(item['useCo'])
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 7,),
                            Text("이용자수", style: TextStyle(
                                color: Colors.pink
                            ),),
                            SizedBox(width: 7),
                            Text(item['userCo'])
                          ],
                        ),
                        SizedBox(height: 20,),
                      ],
                    );
                  })
          )
        ],
      )
    );
  }

  Future<String> userJson() async {
    String newUrl = url
        + "&serviceKey=" + API_KEY
        + "&stdrYm=" + selectedYear.toString() + selectedMonth
        + "&pageNo=" + pageNo.toString()
        + "&numOfRows=" + numOfRows.toString();

    final response = await http.get(newUrl);

    var res = jsonDecode(response.body);

    setState(() {
      userDataList = res['response']['body']['items'];
    });

    return 'Success';
  }
}