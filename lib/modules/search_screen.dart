import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

import '../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.search;
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: cubit.fromKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(25.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      label: Text('search'),
                      prefixIcon: Icon(Icons.search),
                    ),
                    controller: cubit.searchController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                  ),
                ),
                if (list.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildArticleItem(list[index], context),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 3,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemCount: list.length,
                    ),
                  )
                else
                 Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
