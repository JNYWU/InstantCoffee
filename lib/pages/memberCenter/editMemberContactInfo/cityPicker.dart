import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readr_app/blocs/memberContactInfoBloc.dart';
import 'package:readr_app/helpers/apiResponse.dart';
import 'package:readr_app/helpers/dataConstants.dart';

class CityPicker extends StatefulWidget {
  final MemberContactInfoBloc memberContactInfoBloc;
  CityPicker({
    @required this.memberContactInfoBloc,
  });

  @override
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  bool _isPickerActivated;
  String _city;
  List<Widget> _cityListWidget;

  @override
  void initState() {
    _isPickerActivated = false;
    _city = widget.memberContactInfoBloc.editMember.contactAddress.city;
    setCountryListWidget();
    super.initState();
  }

  @override
  void didUpdateWidget(CityPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _city = widget.memberContactInfoBloc.editMember.contactAddress.city;
    //setCountryListWidget();
  }

  setCountryListWidget() {
    _cityListWidget = List<Widget>();
    widget.memberContactInfoBloc.cityList.forEach(
      (city) { 
        _cityListWidget.add(Text(city.name));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var pickerHeight = MediaQuery.of(context).size.height/3;

    return Container(
      color: _isPickerActivated
      ? Color(0xFFF7FEFF)
      : Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.0),
          InkWell(
            child: Container(
              width: width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: !_isPickerActivated
                    ? Colors.grey
                    : appColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _city ?? '縣市',
                      style: TextStyle(
                        color: _city == null
                        ? Colors.grey
                        : Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    _isPickerActivated
                    ? Icon(Icons.keyboard_arrow_up)
                    : Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
            onTap: () {
              if(widget.memberContactInfoBloc.editMember.contactAddress.country != null && 
              widget.memberContactInfoBloc.editMember.contactAddress.country == '臺灣') {
                setState(() {
                  _isPickerActivated = true;
                  _showPicker(pickerHeight, widget.memberContactInfoBloc);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  _showPicker(double height, MemberContactInfoBloc memberContactInfoBloc) async{
    int targetIndex = _city == null
    ? 0
    : memberContactInfoBloc.cityList.findIndexByName(_city);

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 48+height,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      }
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Text(
                          '完成',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      onTap: (){
                        if(_city != memberContactInfoBloc.cityList[targetIndex].name) {
                          memberContactInfoBloc.editMember.contactAddress.district = null;
                        }
                        _city = memberContactInfoBloc.cityList[targetIndex].name;
                        memberContactInfoBloc.editMember.contactAddress.city = _city;
                        memberContactInfoBloc.sinkToAdd(ApiResponse.completed(memberContactInfoBloc.editMember));
                        Navigator.pop(context);
                      }
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(initialItem: targetIndex),
                  backgroundColor: const Color(0xF8F8F9),
                  onSelectedItemChanged: (value) {
                    targetIndex = value;
                  },
                  itemExtent: 32.0,
                  children: _cityListWidget,
                ),
              ),
            ],
          ),
        );
      }
    );
    setState(() {
      _isPickerActivated = false;
    });
  }
}