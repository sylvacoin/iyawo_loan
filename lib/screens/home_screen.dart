import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/tab/index.dart';
import 'package:iyawo/models/app_tab.dart';

class HomeScreen extends StatelessWidget {
  final tabMenu = tabMenus;
  @override
  Widget build(BuildContext context) {
    //final tabBloc = BlocProvider.of<TabBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(title: Text('Home Screen')),
          body: loadScreen(activeTab),
          bottomNavigationBar: BottomNavigationBar(
            items: AppTab.values.map((tab) => BottomNavigationBarItem(
                icon: Icon(tabMenus[tab.index].icon), 
                title: Text(tabMenus[tab.index].title),
                backgroundColor: Colors.blue
              )).toList(),
            onTap: (selectedIndex){
              return BlocProvider.of<TabBloc>(context).add(UpdateTab(AppTab.values[selectedIndex]));
            },
            currentIndex: activeTab.index,
          ),
        );
      },
    );
  }

  Widget loadScreen(AppTab activeTab)
  {
    return tabMenus[activeTab.index].tab;
  }
}
