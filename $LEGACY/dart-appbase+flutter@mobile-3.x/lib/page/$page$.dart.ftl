<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_picker/picker.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

<#list pages![] as page>
  <#if !page.options.isComponent?? || page.options.isComponent == 'T'><#continue></#if>
import '/page/${page.uri?substring(page.uri?index_of('/') + 1)}.dart';
</#list>
import '/page/common/image_viewer.dart';
import '/sdk/${app.name}.dart';

<#list page.widgets![] as widget>
  <#if widget.widgetType == '滚动导航'>
import 'package:carousel_slider/carousel_slider.dart';
  <#elseif widget.widgetType == '传统列表'>
  </#if>
</#list>
<#list page.widgets![] as widget>
  <#if widget.widgetType == '页签导航'>
    <#list widget.items![] as item>
      <#if !item.url??><#continue></#if>
import '${modelbase.url_to_page_name(item.url)?replace("_", "/")}.dart';
    </#list>
  </#if>
</#list>
<#assign pageName = modelbase.url_to_page_name(page.uri)>

class ${dart.nameType(page.name)}Page extends StatefulWidget {

  @override
  ${dart.nameType(page.name)}PageState createState() => ${dart.nameType(page.name)}PageState();

}

class ${dart.nameType(page.name)}PageState extends State<${dart.nameType(page.name)}Page> {
<#list page.widgets![] as widget>
  <#if widget.widgetType == '滚动导航' || widget.widgetType == '滑动导航'>

  /**
   * 【${widget.variable?upper_case}】导航图片变量。
   */
  List<Map>? items${dart.nameType(widget.variable)};
  <#elseif widget.widgetType == '栏位导航'>

  /**
   * 【${widget.variable?upper_case}】栏位导航变量。
   */
  Map? items${dart.nameType(widget.variable)};
  <#elseif widget.widgetType == '页签导航'>

  /**
   * 页签导航，选择的页签序号
   */
  int selectedPageIndex = 0;

  /**
   * 【${widget.variable?upper_case}】用到的子页面。
   */
  final subpages = [
    <#list widget.items![] as item>
      <#if !item.url??><#continue></#if>
    ${dart.nameType(modelbase.url_to_page_name(item.url))}Page(),
    </#list>
  ];
  <#elseif widget.widgetType == '编辑表单'>

  /**
   * 【${widget.variable?upper_case}】表单数据载体。
   */
  Map? values${dart.nameType(widget.variable)};

  /**
   * 【${widget.variable?upper_case}】表单字段控制器。
   */
  final Map controllers${dart.nameType(widget.variable)} = HashMap();
  <#elseif widget.widgetType == '只读表单'>

  /**
   * 【${widget.variable?upper_case}】表单数据载体。
   */
  Map? values${dart.nameType(widget.variable)};
  <#elseif widget.widgetType == '花式表单'>

  /**
   * 【${widget.variable?upper_case}】表单数据载体。
   */
  Map? values${dart.nameType(widget.variable)};

  /**
   * 【${widget.variable?upper_case}】表单字段控制器。
   */
  final Map controllers${dart.nameType(widget.variable)} = HashMap();
  <#elseif widget.widgetType == '日历导航'>

  /**
   * 【${widget.variable?upper_case}】表单字段控制器。
   */
   final controllerCalendar${dart.nameType(widget.variable)} = AdvancedCalendarController.today();
  <#elseif widget.widgetType == '传统列表' || widget.widgetType == '栅格列表'>

  /**
   * 【${widget.variable?upper_case}】列表数据变量。
   */
  List<Map>? items${dart.nameType(widget.variable)};
  <#elseif widget.widgetType == '统计图表'>

  /**
   * 【${widget.variable?upper_case}】列表数据变量。
   */
  List<Map>? stats${dart.nameType(widget.variable)};
  </#if>
</#list>

  @override
  void initState() {
    super.initState();
<#list page.widgets as widget>
  <#if widget.widgetType == '编辑表单' || widget.widgetType == '花式表单'>
    createControllers${dart.nameType(widget.variable)}();
  <#elseif widget.widgetType == '日历导航'>
    controllerCalendar${dart.nameType(widget.variable)}.addListener(() {
      print(controllerCalendar${dart.nameType(widget.variable)}.value.toString());
    });
  </#if>
</#list>
  }

  @override
  void dispose() {
<#list page.widgets as widget>
  <#if widget.widgetType == '编辑表单'>
    destroyControllers${dart.nameType(widget.variable)}();
  </#if>
</#list>
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
<#if !page.options.isComponent?? || page.options.isComponent != 'T'>
      appBar: AppBar(
        title: Text("${page.title}"),
      ),
</#if>
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
<#list page.widgets![] as widget>
  <#if widget.widgetType == '按钮导航'>
<@appbase.print_dart_declare_gridnavigator widget=widget indent=12 />
  <#elseif widget.widgetType == '滚动导航'>
            buildCycle${dart.nameType(widget.variable)}Widget(),
  <#elseif widget.widgetType == '滑动导航'>
            buildScroll${dart.nameType(widget.variable)}Widget(),
  <#elseif widget.widgetType == '栏位导航'>
            buildColumn${dart.nameType(widget.variable)}Widget(),
  <#elseif widget.widgetType == '页签导航'>
<@appbase.print_dart_declare_tabsnavigator widget=widget indent=12 />
  <#elseif widget.widgetType == '列表导航'>
<@appbase.print_dart_declare_listnavigator widget=widget indent=12 />
  <#elseif widget.widgetType == '日历导航'>
            AdvancedCalendar(
              controller: controllerCalendar${dart.nameType(widget.variable)},
              events: <DateTime>[DateTime.now()],
              weekLineHeight: 48.0,
              startWeekDay: 1,
              innerDot: true,
              keepLineSize: true,
              calendarTextStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.3125,
                letterSpacing: 0,
              ),
            ),
  <#elseif widget.widgetType == '传统列表'>
${''?left_pad(12)}SizedBox(
${''?left_pad(12)}  height: MediaQuery.of(context).size.height / 3,
${''?left_pad(12)}  child: buildList${dart.nameType(widget.variable)}Widget(),
${''?left_pad(12)}),
  <#elseif widget.widgetType == '栅格列表'>
${''?left_pad(12)}SizedBox(
${''?left_pad(12)}  height: MediaQuery.of(context).size.height,
${''?left_pad(12)}  child: buildGrid${dart.nameType(widget.variable)}Widget(),
${''?left_pad(12)}),
  <#elseif widget.widgetType == '主题标题'>
<@appbase.print_dart_declare_themetitle widget=widget indent=12 />
  <#elseif widget.widgetType == '编辑表单'>
            FutureBuilder<Map>(
              future: get${dart.nameType(widget.variable)}Values(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildForm${dart.nameType(widget.variable)}();
                } else if (snapshot.hasError) {
                  return Text("${r'${'}snapshot.error${r'}'}");
                }
                return const CircularProgressIndicator();
              },
            ),
  <#elseif widget.widgetType == '只读表单'>
            FutureBuilder<Map>(
              future: get${dart.nameType(widget.variable)}Values(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildReadonly${dart.nameType(widget.variable)}();
                } else if (snapshot.hasError) {
                  return Text("${r'${'}snapshot.error${r'}'}");
                }
                return const CircularProgressIndicator();
              },
            ),
  <#elseif widget.widgetType == '花式表单'>
            FutureBuilder<Map>(
              future: get${dart.nameType(widget.variable)}Values(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildStyled${dart.nameType(widget.variable)}();
                } else if (snapshot.hasError) {
                  return Text("${r'${'}snapshot.error${r'}'}");
                }
                return const CircularProgressIndicator();
              },
            ),
  <#elseif widget.widgetType == '统计图表'>
            FutureBuilder<List<Map>>(
              future: get${dart.nameType(widget.variable)}Stats(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildChart${dart.nameType(widget.variable)}();
                } else if (snapshot.hasError) {
                  return Text("${r'${'}snapshot.error${r'}'}");
                }
                return const CircularProgressIndicator();
              },
            ),
  </#if>
</#list>
          ],
        ),
      ),
    );
  }

<#list page.widgets![] as widget>
  <#if widget.widgetType == '滚动导航'>
<@appbase.print_dart_methods_cyclenavigator widget=widget indent=2 />
  <#elseif widget.widgetType == '滑动导航'>
<@appbase.print_dart_methods_scrollnavigator widget=widget indent=2 />
  <#elseif widget.widgetType == '栏位导航'>
<@appbase.print_dart_methods_columnnavigator widget=widget indent=2 />
  <#elseif widget.widgetType == '传统列表'>
<@appbase.print_dart_methods_listview widget=widget indent=2 />
  <#elseif widget.widgetType == '栅格列表'>
<@appbase.print_dart_methods_gridview widget=widget indent=2 />
  <#elseif widget.widgetType == '编辑表单'>
<@appbase.print_dart_methods_formlayout widget=widget indent=2 />
  <#elseif widget.widgetType == '只读表单'>
<@appbase.print_dart_methods_readonlyform widget=widget indent=2 />
  <#elseif widget.widgetType == '花式表单'>
<@appbase.print_dart_methods_styledform widget=widget indent=2 />
  <#elseif widget.widgetType == '统计图表'>
<@appbase.print_dart_methods_chart widget=widget indent=2 />
  </#if>
</#list>
}