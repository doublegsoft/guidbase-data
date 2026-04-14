import 'package:flutter/material.dart';

<#list pages as page>
  <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
import '${page.uri?substring(page.uri?index_of('/') + 1)}.dart';
</#list>

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, required this.title});

  final String title;

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
<#list pages as page>
  <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
          ListTile(
            title: Text('${page.title}'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ${dart.nameType(page.name)}Page(),
                ),
              );
            },
          ),
</#list>
        ],
      ),
    );
  }
}