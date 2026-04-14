<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#if license??>
${dart.license(license)}
</#if>
<#assign page = pagedef>
<#assign pagename = guidbase.page_id_to_page_name(page.id)>
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:gux/widget/gx_tab_item.dart';
import 'package:gux/widget/gx_two_column_form.dart';
import 'package:gux/widget/gx_list_view.dart';
import 'package:gux/widget/gx_grid_view.dart';
import 'package:gux/widget/gx_widget_size.dart';

import '/${app.name}/sdk/sdk.dart' as sdk;
import '/styles.dart' as styles;

class ${dart.nameType(pagename)}Screen extends StatefulWidget {
  @override
  ${dart.nameType(pagename)}ScreenState createState() => ${dart.nameType(pagename)}ScreenState();
}

class ${dart.nameType(pagename)}ScreenState extends State<${dart.nameType(pagename)}Screen> {

<#list page.pageWidgets as widget>
  <#if !widget.type??><#continue></#if>
<@gux.print_dart_fields_widget widget=widget indent=2 />
</#list>  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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