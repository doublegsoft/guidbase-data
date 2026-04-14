<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#if license??>
${dart.license(license)}
</#if>
<#assign page = pagedef>
<#assign pagename = guidbase.page_id_to_page_name(page.id)>
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:gux/widget/gx_tab_item.dart';
import 'package:gux/widget/gx_two_column_form.dart';
import 'package:gux/widget/gx_list_view.dart';
import 'package:gux/widget/gx_grid_view.dart';
import 'package:gux/widget/gx_widget_size.dart';

import '/${app.name}/model/bloc.dart';
import '/${app.name}/sdk/sdk.dart' as sdk;
import '/styles.dart' as styles;

class ${dart.nameType(pagename)}Page extends StatefulWidget {

<#list page.pageWidgets as widget>
  <#if widget.type == "editable_form" || widget.type == "readonly_form">
    <#assign url = widget.options["url"]>
    <#assign objname = guidbase.get_object_from_url(url)>
    <#assign params = guidbase.get_params_from_url(url)>
  ///
  /// 【${page.title!""} ${widget.title!""}】标识
  ///
    <#list params as param>
  String? ${param.name};  
    </#list>
  </#if>
</#list>

  ${dart.nameType(pagename)}Page({
    super.key,
<#list page.pageWidgets as widget>  
  <#if widget.type == "editable_form" || widget.type == "readonly_form">
    <#assign url = widget.options["url"]>
    <#assign objname = guidbase.get_object_from_url(url)>
    <#assign params = guidbase.get_params_from_url(url)>  
    <#list params as param>
    this.${param.name},
    </#list>
  </#if>  
</#list>  
  });

  @override
  ${dart.nameType(pagename)}PageState createState() => ${dart.nameType(pagename)}PageState();
}

class ${dart.nameType(pagename)}PageState extends State<${dart.nameType(pagename)}Page> {

<#list page.pageWidgets as widget>
  <#if !widget.type??><#continue></#if>
<@gux.print_dart_fields_widget widget=widget indent=2 />
</#list>  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> params = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('${page.options["title"]!"页面标题"}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
<#list page.widgets as widget>
  <#if !widget.type??><#continue></#if>
<@gux.print_dart_declare_widget widget=widget indent=12 />
</#list>          
          ],
        ),
      ),
    );
  }
<#list page.pageWidgets as widget>
  <#if !widget.type??><#continue></#if>
<@gux.print_dart_methods_widget widget=widget indent=2 />
</#list>  
}