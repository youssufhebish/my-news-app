import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/cubit.dart';
import 'package:news/layout/cubit/states.dart';
import 'package:news/shared/components/components.dart';

class SciencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => null,
      builder: (context, state) {
        var list = NewsCubit.get(context).sciences;
        var c = NewsCubit.get(context);
        return ConditionalBuilder(
          condition: list.length > 0,
          builder: (context) =>
              ListView.separated(
                  itemBuilder: (context, index) => builderArticleItem(list[index], c.isDark, context),
                  separatorBuilder: (context, index) => Divider(color: Colors.grey),
                  itemCount: list.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
