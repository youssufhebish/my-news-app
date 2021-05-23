
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/cubit.dart';
import 'package:news/layout/cubit/states.dart';
import 'package:news/modules/search/search_screen.dart';



class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => null,
      builder: (context, state) {
        var c = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(c.titles[c.currentIndex]),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(c.isDark),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4),
                onPressed: () {
                  c.changeMode();
                },
              ),
            ],
          ),
          body: c.screens[c.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: c.currentIndex,
            onTap: (index) {
              c.changeNavBar(index);
            },
            items: c.bottomItems,
          ),
        );
      },
    );
  }
}
