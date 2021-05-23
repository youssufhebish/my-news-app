import 'package:flutter/material.dart';
import 'package:news/modules/web_view.dart';

import 'news_api_date_converter.dart';


Widget builderArticleItem(article, bool isDark, context) => InkWell(
  onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(article['url']),
          ),
        );
      },
  child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              height: 96.0,
              width: 96.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                // alignment: Alignment.topLeft,

                height: 96.0,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article['title']}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: !isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${NewsApiDateConverter.newsDateOnly(article['publishedAt'])}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    Expanded(
                      child: Text(
                        '${article['description']}',
                        style: TextStyle(
                          color: !isDark ? Colors.white : Colors.black,
                          fontSize: 12.0,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

