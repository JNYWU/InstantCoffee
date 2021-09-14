import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readr_app/blocs/slugBloc.dart';
import 'package:readr_app/blocs/story/bloc.dart';
import 'package:readr_app/helpers/dataConstants.dart';
import 'package:readr_app/services/storyService.dart';
import 'package:readr_app/widgets/listeningWidget.dart';
import 'package:readr_app/widgets/storyWidget.dart';
import 'package:share/share.dart';

class StoryPage extends StatelessWidget {
  final String slug;
  final bool isListeningWidget;
  const StoryPage(
      {Key key, @required this.slug, this.isListeningWidget = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SlugBloc _slugBloc = SlugBloc(slug);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            tooltip: 'share',
            onPressed: () {
              String url = _slugBloc.getShareUrlFromSlug(isListeningWidget);
              Share.share(url);
            },
          )
        ],
      ),
      body: isListeningWidget
          ? ListeningWidget(slugBloc: _slugBloc)
          : BlocProvider(
              create: (context) => StoryBloc(storyRepos: StoryService()),
              child: StoryWidget(slugBloc: _slugBloc),
            )
    );
  }
}
