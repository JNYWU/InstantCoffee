import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readr_app/pages/storyPage.dart';
import 'package:uni_links/uni_links.dart';

class AppLinkHelper {
  AppLinkHelper();

  Future<String> getLink() async {
    try {
      return await getInitialLink();
    } on PlatformException {
      return null;
    }
  }

  configAppLink(BuildContext context) async{
    String link = await getLink();
    if(link != null) {
      var linkList = link.split('/');
      // navigate to storyPage
      for(int i=0; i<linkList.length; i++) {
        if(linkList[i] == 'story' && i+1 < linkList.length) {
          _navigateToStoryPage(context, linkList[i+1]);
          break;
        } else if(linkList[i] == 'video' && i+1 < linkList.length) {
          _navigateToStoryPage(context, linkList[i+1], isListeningPage: true);
          break;
        }
      }
    }
  }

  _navigateToStoryPage(BuildContext context, String slug ,{isListeningPage = false}) async{
    if(slug != null && slug != '') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StoryPage(
            slug: slug,
            isListeningWidget: isListeningPage,
          )
        )
      );
    }
  }

  dispose() {}
}