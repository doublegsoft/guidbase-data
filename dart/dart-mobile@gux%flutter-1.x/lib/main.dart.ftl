<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#if license??>
${dart.license(license)}
</#if>
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'welcome.dart';
<#assign navs = guidbase.get_navigable_pages(app)>
<#list navs as nav>
import '/${app.name}/screen/${nav.id}_screen.dart';
</#list>
<#list app.pages as page>
  <#if (page.options["navigable"]!"") == "true"><#continue></#if>
import '/${app.name}/page/${page.id}_page.dart';
</#list>

void main() {
  initializeDateFormatting().then((_) => runApp(${dart.nameType(app.name)}()));
}

class ${dart.nameType(app.name)} extends StatelessWidget {

  const ${dart.nameType(app.name)}({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
//        BlocProvider<FormBloc>(
//          create: (context) => FormBloc(),
//        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${app.title!'应用程序标题'}',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
        routes: {
<#list app.pages as page>
  <#if (page.options["navigable"]!"") == "true"><#continue></#if>
          '/${page.id}': (context) => ${dart.nameType(gux.url_to_page_name(page.id))}Page(),
</#list>
        },
      ),
    );
  }
}

/*!
** main page
*/
class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('${app.title!"应用程序标题"}'),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
<#list navs as nav>           
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: '${nav.options["title"]!"标题"}',
            ),
</#list>       
          ],     
        ),
        body: [
<#list navs as nav>         
          ${dart.nameType(guidbase.page_id_to_page_name(nav.id))}Screen(), 
</#list>   
        ][_currentPageIndex],
      ),
    );
  }
}