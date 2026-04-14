<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
import 'package:flutter/material.dart';

import 'page/index.dart';
<#list pages as page>
    <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
  import 'page/${page.uri?substring(page.uri?index_of('/') + 1)}.dart';
</#list>

void main() {
  runApp(const ${dart.nameType(app.name)}());
}

class ${dart.nameType(app.name)} extends StatelessWidget {

  const ${dart.nameType(app.name)}({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${app.title!'应用程序标题'}',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const IndexPage(title: '${app.title!'应用程序标题'}'),
      routes: {
        '/': (context) => IndexPage(title: '${app.title!'应用程序标题'}'),
<#list pages as page>
  <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
        '/${page.uri}': (context) => ${dart.nameType(modelbase.url_to_page_name(page.uri))}Page(),
</#list>
      },
    );
  }
}