import 'package:flutter/material.dart';
import 'package:readr_app/models/SectionList.dart';
import 'package:readr_app/models/Section.dart';
import 'package:readr_app/models/SectionService.dart';
import 'package:readr_app/widgets/TabContent.dart';

import 'NotificationSettingsPage.dart';
import 'helpers/Constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // tab text
  SectionList _sectionItems;

  /// tab controller
  TabController _tabController;
  List<Tab> _tabs = List<Tab>();
  List<Widget> _tabWidgets = List<Widget>();

  @override
  void initState() {
    _loadingData();
    super.initState();
  }

  _loadingData() async{
    await _setSections();
    _initializeTabController();
  }

  Future<void> _setSections() async {
    SectionList resultSectionList = SectionList();
    SectionList allSections = SectionList();
    allSections = await SectionService().loadSections();
    for (Section section in allSections) {
      resultSectionList.add(section);
    }

    setState(() {
      _sectionItems = resultSectionList;
    });
  }

  void _initializeTabController() {

    _tabs.clear();
    _tabWidgets.clear();

    _sectionItems.forEach((section) {
      _tabs.add(
        Tab(
          child: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold, /*fontSize: 20.0*/
            ),
          ),
        ),
      );

      _tabWidgets.add(
        TabContent(section: section,)
      );
    });
    /*
    if(_sectionItems != null && _records != null)
    {
      _tabWidgets[0] = ListView.builder(
        itemCount: _records == null ? 0 : _records.length,
        itemBuilder: (context, index) {
          return Card(child: Text(_records[index].title));
        }
      );
    }
    */
    // set controller
    _tabController = TabController(
      vsync: this,
      length: _sectionItems.length,
      initialIndex: _tabController == null ? 0 : _tabController.index,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildBar(context),
      body: _sectionItems == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: 150.0),
                  child: Material(
                    color: Color.fromARGB(255, 229, 229, 229),
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      tabs: _tabs.toList(),
                      controller: _tabController,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _tabWidgets.toList(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationSettingsPage(),
            fullscreenDialog: true,
          ),
        ),
      ),
      backgroundColor: appColor,
      centerTitle: true,
      title: Text(appTitle),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.person),
          tooltip: 'Personal',
          onPressed: () => {},
        ),
      ],
    );
  }
}
