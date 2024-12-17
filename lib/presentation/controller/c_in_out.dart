import 'package:electrosphereinventory/data/model/history.dart';
import 'package:electrosphereinventory/data/source/source_inout.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CInOut extends GetxController {
        final RxList<History> _list = <History>[].obs;
        List<History> get list => _list.value;
        setList(List newList) {
          _list.value = newList.map((e)=> History.fromJson(e)).toList();
          update();
        }

        final RxList<double> _listTotal = <double>[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
        List<double> get listTotal => _listTotal.value;
        setListTotal(List newList) {
          _listTotal.value = newList.map((e)=> double.parse('$e')).toList();

          double yesterday = listTotal[5];
          double today = listTotal[6];
          double ab = (yesterday + today) == 0 ? 1 : (yesterday + today);
          _percentYesterday.value = (yesterday / ab) * 100;
          _percentToday.value = (today / ab) * 100;
         
         double currentDifferent = today - yesterday;
         _different.value = currentDifferent.abs();
         double abDifferent = (currentDifferent + yesterday) == 0 ? 1 : (currentDifferent + yesterday);

         if(currentDifferent > 0 ) {
            _textDifferent.value = 'bigger';
            _percentDifferent.value =  
            (currentDifferent / abDifferent) * 100;
         }else if(currentDifferent == 0 ) {
            _textDifferent.value = 'equal';
            _percentDifferent.value = 100.0;
         } else if(currentDifferent < 0 ) {
            _textDifferent.value = 'smaller';
            _percentDifferent.value =  (currentDifferent / abDifferent) * 100;
         }
          
          update();
        }

        getAnalysis(String type) async {
          Map<String, dynamic> analysis = await SourceInOut.analysis(type);
          setList(analysis['data']);
          setListTotal(analysis['list_total']);          
        }

List<String> get days => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        List<String> week() {
          DateTime today = DateTime.now();

          return [
            days[today.subtract(const Duration(days: 6)).weekday-1],
            days[today.subtract(const Duration(days: 5)).weekday-1],
            days[today.subtract(const Duration(days: 4)).weekday-1],
            days[today.subtract(const Duration(days: 3)).weekday-1],
            days[today.subtract(const Duration(days: 2)).weekday-1],
            days[today.subtract(const Duration(days: 1)).weekday-1],
            days[today.weekday-1],
          ];
        } 

        final RxDouble  _percentYesterday = 0.0.obs;
        final RxDouble  _percentToday = 0.0.obs;
        double get percentYesterday => _percentYesterday.value;
        double get percentToday => _percentToday.value;

        final RxDouble _percentDifferent = 0.0.obs;
        double get percentDifferent => _percentDifferent.value;
        final RxString _textDifferent = ''.obs;
        String get textDifferent => _textDifferent.value;
        final RxDouble _different = 0.0.obs;
        double get different => _different.value;

    
      
      }



