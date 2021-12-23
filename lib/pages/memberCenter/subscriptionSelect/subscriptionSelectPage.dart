import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readr_app/blocs/memberCenter/subscriptionSelect/bloc.dart';
import 'package:readr_app/helpers/dataConstants.dart';
import 'package:readr_app/models/memberSubscriptionType.dart';
import 'package:readr_app/pages/memberCenter/subscriptionSelect/subscriptionSelectWidget.dart';
import 'package:readr_app/services/subscriptionSelectService.dart';

class SubscriptionSelectPage extends StatefulWidget {
  final SubscritionType subscritionType;
  final String storySlug;
  SubscriptionSelectPage(
    this.subscritionType, 
    {this.storySlug}
  );

  @override
  State<SubscriptionSelectPage> createState() => _SubscriptionSelectPageState();
}

class _SubscriptionSelectPageState extends State<SubscriptionSelectPage> {
  SubscriptionSelectBloc _subscriptionSelectBloc;

  @override
  void initState() {
    _subscriptionSelectBloc = SubscriptionSelectBloc(
      subscriptionSelectRepos: SubscriptionSelectServices(),
      storySlug: widget.storySlug,
    );
    super.initState();
  }

  @override
  void dispose() {
    _subscriptionSelectBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: BlocProvider(
        create: (context) => _subscriptionSelectBloc,
        child: SubscriptionSelectWidget(),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    String titleText;
    if(widget.subscritionType == SubscritionType.subscribe_one_time || widget.subscritionType == SubscritionType.none){
      titleText = '升級會員';
    }
    else{
      titleText = '變更方案';
    }
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Text(
        titleText,
      ),
      backgroundColor: appColor,
    );
  }
}