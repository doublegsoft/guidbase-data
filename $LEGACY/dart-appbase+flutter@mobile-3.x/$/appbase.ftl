
<#macro print_dart_declare_gridnavigator widget indent>
${''?left_pad(indent)}GridView.extent(
${''?left_pad(indent)}  primary: false,
${''?left_pad(indent)}  shrinkWrap: true,
${''?left_pad(indent)}  padding: const EdgeInsets.all(16),
${''?left_pad(indent)}  crossAxisSpacing: 10,
${''?left_pad(indent)}  mainAxisSpacing: 10,
${''?left_pad(indent)}  maxCrossAxisExtent: 120.0,
${''?left_pad(indent)}  children: <Widget>[
  <#list widget.items as item>
${''?left_pad(indent)}    GestureDetector(
${''?left_pad(indent)}      behavior: HitTestBehavior.opaque,
${''?left_pad(indent)}      child: Container(
${''?left_pad(indent)}        padding: const EdgeInsets.all(8),
${''?left_pad(indent)}        child: Center(
${''?left_pad(indent)}          child: Column(
${''?left_pad(indent)}            crossAxisAlignment: CrossAxisAlignment.center,
${''?left_pad(indent)}            children: <Widget>[
${''?left_pad(indent)}              Expanded(child: Icon(FontAwesome5.monument, size:36.0, color: Colors.grey)),
${''?left_pad(indent)}              const Text("${item.title!'功能入口'}", style: TextStyle(fontSize: 18)),
${''?left_pad(indent)}            ],
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        color: Colors.white,
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      onTap: () {
${''?left_pad(indent)}        Navigator.pushNamed(context, "/${item.url!'TODO'}", arguments: {});
${''?left_pad(indent)}      },
${''?left_pad(indent)}    ),
  </#list>
${''?left_pad(indent)}  ],
${''?left_pad(indent)}),
</#macro>

<#macro print_dart_declare_themetitle widget indent>
${''?left_pad(indent)}Row(
${''?left_pad(indent)}  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
${''?left_pad(indent)}  children: [
${''?left_pad(indent)}    Container(
${''?left_pad(indent)}      padding: const EdgeInsets.all(8.0),
${''?left_pad(indent)}      child: Text("${widget.title!'标题'}",
${''?left_pad(indent)}        style: TextStyle(
${''?left_pad(indent)}          fontSize: 20,
${''?left_pad(indent)}          fontWeight: FontWeight.bold
${''?left_pad(indent)}        )
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
  <#if widget.more?? && widget.more == true>
${''?left_pad(indent)}    Expanded(
${''?left_pad(indent)}      child: Align(
${''?left_pad(indent)}        alignment: Alignment.centerRight,
${''?left_pad(indent)}        child: Container(
${''?left_pad(indent)}          padding: EdgeInsets.only(right: 8),
${''?left_pad(indent)}            child: GestureDetector(
${''?left_pad(indent)}              child: Text("更多",
${''?left_pad(indent)}                style: TextStyle(
${''?left_pad(indent)}                  fontSize: 12,
${''?left_pad(indent)}                  fontWeight: FontWeight.bold,
${''?left_pad(indent)}                  color: Colors.lightBlue,
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
${''?left_pad(indent)}              onTap: () => {
${''?left_pad(indent)}              },
${''?left_pad(indent)}            ),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
  </#if>
${''?left_pad(indent)}  ],
${''?left_pad(indent)}),
</#macro>

<#macro print_dart_declare_listnavigator widget indent>
${''?left_pad(indent)}Column(
${''?left_pad(indent)}  children: [
  <#list widget.items as item>
${''?left_pad(indent)}    Divider(color: Colors.grey),
${''?left_pad(indent)}    GestureDetector(
${''?left_pad(indent)}      behavior: HitTestBehavior.opaque,
${''?left_pad(indent)}      child: Row(
${''?left_pad(indent)}        children: [
${''?left_pad(indent)}          Container(
${''?left_pad(indent)}            margin: EdgeInsets.fromLTRB(20, 12, 20, 12),
${''?left_pad(indent)}            child: Icon(Icons.person_rounded, color: Colors.grey,),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}          Text("${item.title!'标题'}", style: TextStyle(fontSize: 20, color: Colors.grey,)),
${''?left_pad(indent)}          Spacer(),
${''?left_pad(indent)}          Container(
${''?left_pad(indent)}            margin: EdgeInsets.fromLTRB(20, 12, 20, 12),
${''?left_pad(indent)}            child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey,),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        ],
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      onTap: () {
${''?left_pad(indent)}        Navigator.pushNamed(context, "/${item.url!'TODO'}", arguments: {});
${''?left_pad(indent)}      },
${''?left_pad(indent)}    ),
  </#list>
${''?left_pad(indent)}    Divider(color: Colors.grey),
${''?left_pad(indent)}  ],
${''?left_pad(indent)}),
</#macro>

<#macro print_dart_declare_tabsnavigator widget indent>
${''?left_pad(indent)}DefaultTabController(
${''?left_pad(indent)}  length: ${widget.items?size},
${''?left_pad(indent)}  child: Column(
${''?left_pad(indent)}    children: [
${''?left_pad(indent)}      TabBar(
${''?left_pad(indent)}        labelPadding: EdgeInsets.symmetric(vertical: 12.0),
${''?left_pad(indent)}        tabs: [
  <#list widget.items as item>
${''?left_pad(indent)}          Text("${item.title!'页签'}",
${''?left_pad(indent)}            style: TextStyle(color: Colors.black45,fontSize: 16),
${''?left_pad(indent)}          ),
  </#list>
${''?left_pad(indent)}        ],
${''?left_pad(indent)}        onTap: (int index) {
${''?left_pad(indent)}          setState(() {
${''?left_pad(indent)}            selectedPageIndex = index;
${''?left_pad(indent)}          });
${''?left_pad(indent)}        },
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      Container(
${''?left_pad(indent)}        height: MediaQuery.of(context).size.height - kToolbarHeight * 2,
${''?left_pad(indent)}        child: subpages[selectedPageIndex],
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ],
${''?left_pad(indent)}  ),
${''?left_pad(indent)}),
</#macro>

<#macro print_dart_methods_formlayout widget indent>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 创建【${widget.variable?upper_case}】编辑表单字段控制器。
${''?left_pad(indent)} */
${''?left_pad(indent)}void createControllers${dart.nameType(widget.variable)}() {
  <#list widget.customForm.fields as field>
    <#assign fieldName = field.name!field.title>
    <#if field.input == 'date' || field.input == 'time' || field.input == 'ruler' ||
         field.input == 'select' || field.input == 'district'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"] = TextEditingController();
    <#elseif field.input == 'bool'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"] = ValueNotifier(false);
    </#if>
  </#list>
${''?left_pad(indent)}}

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 销毁【${widget.variable?upper_case}】编辑表单字段控制器。
${''?left_pad(indent)} */
${''?left_pad(indent)}void destroyControllers${dart.nameType(widget.variable)}() {
${''?left_pad(indent)}  for (final controller in controllers${dart.nameType(widget.variable)}.values) {
${''?left_pad(indent)}    controller.dispose();
${''?left_pad(indent)}  }
${''?left_pad(indent)}}

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 读取数据填充【${widget.variable?upper_case}】编辑表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Future<Map> get${dart.nameType(widget.variable)}Values() async {
${''?left_pad(indent)}  if (values${dart.nameType(widget.variable)} != null) return values${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}  values${dart.nameType(widget.variable)} = await ${app.name}.read${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}("0");
  <#list widget.customForm.fields as field>
    <#assign fieldName = field.name!field.title>
    <#if field.input == 'date' || field.input == 'time' || field.input == 'ruler'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].text = values${dart.nameType(widget.variable)}!["${fieldName}"];
    <#elseif field.input == 'select'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].text = v1.convertValue2Text("${fieldName}", values${dart.nameType(widget.variable)}!["${fieldName}"]);
    <#elseif field.input == 'district'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].text = v1.convertDistrict2Text(values${dart.nameType(widget.variable)}!["${fieldName}"]);
    <#elseif field.input == 'bool'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].value = values${dart.nameType(widget.variable)}!["${fieldName}"] == 'T';
    </#if>
  </#list>
${''?left_pad(indent)}  return values${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
<#assign hasBuildRadioFor = false>
<#assign hasBuildCheckFor = false>
<#assign hasBuildSelectFor = false>
<#assign hasBuildImagesFor = false>
<#assign hasShowRulerFor = false>
<#list widget.customForm.fields as field>
  <#if field.input == 'radio' && hasBuildRadioFor == false>
    <#assign hasBuildRadioFor = true>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable?upper_case}】单选字段。
${''?left_pad(indent)} */
${''?left_pad(indent)}List<Widget> buildRadioFor(String name) {
${''?left_pad(indent)}  List<Widget> ret = [];
${''?left_pad(indent)}  for (int i = 0; i < ${app.name}.options[name]["values"].length; i++) {
${''?left_pad(indent)}    ret.add(Row(
${''?left_pad(indent)}      children: [
${''?left_pad(indent)}        Radio<String>(
${''?left_pad(indent)}          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
${''?left_pad(indent)}          value: v1.options[name]["values"][i]['value'],
${''?left_pad(indent)}          groupValue: values${dart.nameType(widget.variable)}![name],
${''?left_pad(indent)}          onChanged: (String? value) {
${''?left_pad(indent)}            setState(() {
${''?left_pad(indent)}              values${dart.nameType(widget.variable)}![name] = value;
${''?left_pad(indent)}            });
${''?left_pad(indent)}          },
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        Align(
${''?left_pad(indent)}          child: Text(v1.options[name]["values"][i]["text"]),
${''?left_pad(indent)}          alignment: Alignment(-1.2, 0),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      ],
${''?left_pad(indent)}    ));
${''?left_pad(indent)}  }
${''?left_pad(indent)}  ret.add(Divider(color: Colors.black));
${''?left_pad(indent)}  return ret;
${''?left_pad(indent)}}
  <#elseif field.input == 'check' && hasBuildCheckFor == false>
    <#assign hasBuildCheckFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable?upper_case}】复选字段。
${''?left_pad(indent)} */
${''?left_pad(indent)}List<Widget> buildCheckFor(String name) {
${''?left_pad(indent)}  List<Widget> ret = [];
${''?left_pad(indent)}  for (int i = 0; i < ${app.name}.options[name]["values"].length; i++) {
${''?left_pad(indent)}    ret.add(Row(
${''?left_pad(indent)}      children: [
${''?left_pad(indent)}        Checkbox(
${''?left_pad(indent)}          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
${''?left_pad(indent)}          value: values${dart.nameType(widget.variable)}![name].contains(v1.options[name]["values"][i]['value']),
${''?left_pad(indent)}          onChanged: (value) {
${''?left_pad(indent)}            setState(() {
${''?left_pad(indent)}              if (value == true) {
${''?left_pad(indent)}                values${dart.nameType(widget.variable)}![name].add(v1.options[name]["values"][i]['value']);
${''?left_pad(indent)}              } else {
${''?left_pad(indent)}                values${dart.nameType(widget.variable)}![name].remove(v1.options[name]["values"][i]['value']);
${''?left_pad(indent)}              }
${''?left_pad(indent)}            });
${''?left_pad(indent)}          },
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        Align(
${''?left_pad(indent)}          child: Text(v1.options[name]["values"][i]["text"]),
${''?left_pad(indent)}          alignment: Alignment(-1.2, 0),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      ],
${''?left_pad(indent)}    ));
${''?left_pad(indent)}  }
${''?left_pad(indent)}  ret.add(Divider(color: Colors.black));
${''?left_pad(indent)}  return ret;
${''?left_pad(indent)}}
  <#elseif field.input == 'select' && hasBuildSelectFor == false>
    <#assign hasBuildSelectFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable}】下拉选择。
${''?left_pad(indent)} */
${''?left_pad(indent)}Widget buildSelectFor(String name) {
${''?left_pad(indent)}  return TextFormField(
${''?left_pad(indent)}    controller: controllers${dart.nameType(widget.variable)}[name],
${''?left_pad(indent)}    decoration: InputDecoration(
${''?left_pad(indent)}      suffixIcon: Icon(Icons.chevron_right),
${''?left_pad(indent)}      hintText: "请选择"
${''?left_pad(indent)}    ),
${''?left_pad(indent)}    readOnly: true,
${''?left_pad(indent)}    onTap: () async {
${''?left_pad(indent)}      List<PickerItem<Map<String, String>>> data = [];
${''?left_pad(indent)}      for (int i = 0; i < ${app.name}.options[name]["values"].length; i++) {
${''?left_pad(indent)}        data.add(PickerItem(text: Text(${app.name}.options[name]["values"][i]["text"]), value: ${app.name}.options[name]["values"][i]));
${''?left_pad(indent)}      }
${''?left_pad(indent)}      Picker picker = new Picker(
${''?left_pad(indent)}        adapter: PickerDataAdapter<Map<String, String>>(data: data),
${''?left_pad(indent)}        changeToFirst: true,
${''?left_pad(indent)}        textAlign: TextAlign.left,
${''?left_pad(indent)}        columnPadding: const EdgeInsets.all(8.0),
${''?left_pad(indent)}        onConfirm: (Picker picker, List value) {
${''?left_pad(indent)}          values${dart.nameType(widget.variable)}![name] = picker.getSelectedValues()[0]['value'];
${''?left_pad(indent)}          setState(() {
${''?left_pad(indent)}            controllers${dart.nameType(widget.variable)}[name].text = picker.getSelectedValues()[0]["text"];
${''?left_pad(indent)}          });
${''?left_pad(indent)}        },
${''?left_pad(indent)}      );
${''?left_pad(indent)}      picker.showModal(context);
${''?left_pad(indent)}    },
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
  <#elseif field.input == 'images' && hasBuildImagesFor == false>
    <#assign hasBuildImagesFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable}】图片上传。
${''?left_pad(indent)} */
${''?left_pad(indent)}List<Widget> buildImagesFor(String name) {
${''?left_pad(indent)}  List<Widget> ret = [];
${''?left_pad(indent)}  List<Map> images = values${dart.nameType(widget.variable)}![name];
${''?left_pad(indent)}  if (images == null) images = [];
${''?left_pad(indent)}  for (int i = 0; i < images.length; i++) {
${''?left_pad(indent)}    ret.add(GestureDetector(
${''?left_pad(indent)}      child: Container(
${''?left_pad(indent)}        width: 80,
${''?left_pad(indent)}        height: 80,
${''?left_pad(indent)}        margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
${''?left_pad(indent)}        decoration: BoxDecoration(
${''?left_pad(indent)}          border: Border.all(color: Colors.grey),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        child: Align(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Image.network(images[i]["url"]),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      onTap: () async {
${''?left_pad(indent)}        showDialog(context: context, builder: (_) => ImageViewer(images[i]["url"]));
${''?left_pad(indent)}      },
${''?left_pad(indent)}    ));
${''?left_pad(indent)}  }
${''?left_pad(indent)}  ret.add(GestureDetector(
${''?left_pad(indent)}    child: Container(
${''?left_pad(indent)}      width: 80,
${''?left_pad(indent)}      height: 80,
${''?left_pad(indent)}      margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
${''?left_pad(indent)}      decoration: BoxDecoration(
${''?left_pad(indent)}        border: Border.all(color: Colors.grey),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      child: Align(
${''?left_pad(indent)}        alignment: Alignment.center,
${''?left_pad(indent)}        child: Icon(Icons.add),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
${''?left_pad(indent)}    onTap: () async {
${''?left_pad(indent)}      ImagePicker picker = ImagePicker();
${''?left_pad(indent)}      XFile? image = await picker.pickImage(source: ImageSource.gallery);
${''?left_pad(indent)}    },
${''?left_pad(indent)}  ));
${''?left_pad(indent)}  return ret;
${''?left_pad(indent)}}
<#elseif field.input == 'ruler' && hasShowRulerFor == false>
<#assign hasShowRulerFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 显示【${widget.variable}】量尺输入。
${''?left_pad(indent)} */
${''?left_pad(indent)}void showRulerFor(String name) {
${''?left_pad(indent)}  showModalBottomSheet(
${''?left_pad(indent)}    context: context,
${''?left_pad(indent)}    builder: (builder) {
${''?left_pad(indent)}      return Container(
${''?left_pad(indent)}        height: 160,
${''?left_pad(indent)}        child: Padding(
${''?left_pad(indent)}          padding: EdgeInsets.only(bottom: 24),
${''?left_pad(indent)}          child:  RulerPicker(
${''?left_pad(indent)}            beginValue: 0,
${''?left_pad(indent)}            endValue: 1000,
${''?left_pad(indent)}            initValue: int.parse(values${dart.nameType(widget.variable)}![name] ?? "60"),
${''?left_pad(indent)}            scaleLineStyleList: [
${''?left_pad(indent)}              ScaleLineStyle(color: Colors.grey, width: 1.5, height: 30, scale: 0),
${''?left_pad(indent)}              ScaleLineStyle(color: Colors.grey, width: 1, height: 25, scale: 5),
${''?left_pad(indent)}              ScaleLineStyle(color: Colors.grey, width: 1, height: 15, scale: -1)
${''?left_pad(indent)}            ],
${''?left_pad(indent)}            onValueChange: (value) {
${''?left_pad(indent)}              setState(() {
${''?left_pad(indent)}                controllers${dart.nameType(widget.variable)}![name].text = value.toString();
${''?left_pad(indent)}                values${dart.nameType(widget.variable)}![name] = value.toString();
${''?left_pad(indent)}              });
${''?left_pad(indent)}            },
${''?left_pad(indent)}            width: MediaQuery.of(context).size.width,
${''?left_pad(indent)}            height: 80,
${''?left_pad(indent)}            rulerMarginTop: 8,
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      );
${''?left_pad(indent)}    }
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
  </#if>
</#list>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable?upper_case}】编辑表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Widget buildForm${dart.nameType(widget.variable)}() {
${''?left_pad(indent)}  const labelWidth = 100.0;
${''?left_pad(indent)}  const paddingTop = 12.0;
${''?left_pad(indent)}  const fontSize = 16.0;
${''?left_pad(indent)}  return Form(
${''?left_pad(indent)}    child: Padding(
${''?left_pad(indent)}      padding: EdgeInsets.all(16.0),
${''?left_pad(indent)}      child: Column(
${''?left_pad(indent)}        crossAxisAlignment: CrossAxisAlignment.start,
${''?left_pad(indent)}        children: [
  <#list widget.customForm.fields as field>
    <#assign fieldName = field.name!field.title>
${''?left_pad(indent)}          Row(
${''?left_pad(indent)}            mainAxisAlignment: MainAxisAlignment.start,
${''?left_pad(indent)}            crossAxisAlignment: CrossAxisAlignment.start,
${''?left_pad(indent)}            children: [
${''?left_pad(indent)}              Container(
${''?left_pad(indent)}                width: labelWidth,
${''?left_pad(indent)}                child: Padding(
${''?left_pad(indent)}                  padding: EdgeInsets.only(top: paddingTop),
${''?left_pad(indent)}                  child: Text("${field.title!'标题'}：", style: TextStyle(fontSize: fontSize),),
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#if field.input == 'date'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                  decoration: InputDecoration(
${''?left_pad(indent)}                    suffixIcon: Icon(Icons.calendar_today),
${''?left_pad(indent)}                    hintText: "请选择"
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  readOnly: true,
${''?left_pad(indent)}                  onTap: () async {
${''?left_pad(indent)}                    DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2200));
${''?left_pad(indent)}                    if (pickedDate != null) {
${''?left_pad(indent)}                      String val = DateFormat("yyyy-MM-dd").format(pickedDate);
${''?left_pad(indent)}                      values${dart.nameType(widget.variable)}!["${fieldName}"] = val;
${''?left_pad(indent)}                      setState(() {
${''?left_pad(indent)}                        controllers${dart.nameType(widget.variable)}["${fieldName}"].text = val;
${''?left_pad(indent)}                      });
${''?left_pad(indent)}                    }
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'time'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                  decoration: InputDecoration(
${''?left_pad(indent)}                    suffixIcon: Icon(Icons.timer_outlined),
${''?left_pad(indent)}                    hintText: "请选择"
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  readOnly: true,
${''?left_pad(indent)}                  onTap: () async {
${''?left_pad(indent)}                    TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
${''?left_pad(indent)}                    if (pickedTime != null) {
${''?left_pad(indent)}                      DateTime date = DateFormat("hh:mm a").parse(pickedTime.format(context));
${''?left_pad(indent)}                      String val = DateFormat('HH:mm').format(date);
${''?left_pad(indent)}                      values${dart.nameType(widget.variable)}!["${fieldName}"] = val;
${''?left_pad(indent)}                      setState(() {
${''?left_pad(indent)}                        controllers${dart.nameType(widget.variable)}["${fieldName}"].text = val;
${''?left_pad(indent)}                      });
${''?left_pad(indent)}                    }
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'select'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: buildSelectFor("${fieldName}"),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'bool'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(top: paddingTop),
${''?left_pad(indent)}                      child: Align(
${''?left_pad(indent)}                        alignment: Alignment.centerLeft,
${''?left_pad(indent)}                        child: AdvancedSwitch(
${''?left_pad(indent)}                          controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                          activeChild: Text('是'),
${''?left_pad(indent)}                          inactiveChild: Text('否'),
${''?left_pad(indent)}                          borderRadius: BorderRadius.circular(5),
${''?left_pad(indent)}                          width: 60,
${''?left_pad(indent)}                        ),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'radio'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: buildRadioFor("${dart.nameVariable(fieldName)}")
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'check'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: buildCheckFor("${dart.nameVariable(fieldName)}")
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'images'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Align(
${''?left_pad(indent)}                      alignment: Alignment.topLeft,
${''?left_pad(indent)}                      child: Wrap(
${''?left_pad(indent)}                        children: buildImagesFor("${fieldName}"),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'district'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                  decoration: InputDecoration(
${''?left_pad(indent)}                    suffixIcon: Icon(Icons.location_city_outlined),
${''?left_pad(indent)}                    hintText: "请选择"
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  readOnly: true,
${''?left_pad(indent)}                  onTap: () {
${''?left_pad(indent)}
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#elseif field.input == 'longtext'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  decoration: InputDecoration(
${''?left_pad(indent)}                    hintText: '请填写'
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  maxLines: 5,
${''?left_pad(indent)}                  initialValue: values${dart.nameType(widget.variable)}!["${fieldName}"],
${''?left_pad(indent)}                  onChanged: (value) {
${''?left_pad(indent)}                    setState(() {
${''?left_pad(indent)}                      values${dart.nameType(widget.variable)}!["${fieldName}"] = value;
${''?left_pad(indent)}                    });
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#elseif field.input == 'ruler'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                  decoration: InputDecoration(
${''?left_pad(indent)}                    suffixIcon: Icon(Icons.straighten_outlined),
      <#if field.unit?? && field.unit != ''>
${''?left_pad(indent)}                    suffix: Text("${field.unit}"),
      </#if>
${''?left_pad(indent)}                    hintText: '请输入'
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  readOnly: true,
${''?left_pad(indent)}                  onTap: () {
${''?left_pad(indent)}                    showRulerFor("${fieldName}");
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#else>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  decoration: InputDecoration(
    <#if field.unit?? && field.unit != ''>
${''?left_pad(indent)}                    suffix: Text("${field.unit}"),
    </#if>
${''?left_pad(indent)}                    hintText: '请填写'
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  initialValue: values${dart.nameType(widget.variable)}!["${fieldName}"],
${''?left_pad(indent)}                  onChanged: (value) {
${''?left_pad(indent)}                    setState(() {
${''?left_pad(indent)}                      values${dart.nameType(widget.variable)}!["${fieldName}"] = value;
${''?left_pad(indent)}                    });
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    </#if>
${''?left_pad(indent)}            ],
${''?left_pad(indent)}          ),
  </#list>
${''?left_pad(indent)}        ],
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_readonlyform widget indent>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 读取数据填充【${widget.variable?upper_case}】只读表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Future<Map> get${dart.nameType(widget.variable)}Values() async {
${''?left_pad(indent)}  if (values${dart.nameType(widget.variable)} != null) return values${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}  values${dart.nameType(widget.variable)} = await ${app.name}.read${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}("0");
${''?left_pad(indent)}  return values${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable?upper_case}】只读表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Widget buildReadonly${dart.nameType(widget.variable)}() {
${''?left_pad(indent)}  const labelWidth = 100.0;
${''?left_pad(indent)}  const fontSize = 16.0;
${''?left_pad(indent)}  const paddingTop = 12.0;
${''?left_pad(indent)}  return Form(
${''?left_pad(indent)}    child: Padding(
${''?left_pad(indent)}      padding: EdgeInsets.all(16.0),
${''?left_pad(indent)}      child: Column(
${''?left_pad(indent)}        crossAxisAlignment: CrossAxisAlignment.start,
${''?left_pad(indent)}        children: [
  <#list widget.customReadonly.fields as field>
    <#assign fieldName = field.name!field.title>
${''?left_pad(indent)}          Row(
${''?left_pad(indent)}            mainAxisAlignment: MainAxisAlignment.start,
${''?left_pad(indent)}            crossAxisAlignment: CrossAxisAlignment.start,
${''?left_pad(indent)}            children: [
${''?left_pad(indent)}              Container(
${''?left_pad(indent)}                width: labelWidth,
${''?left_pad(indent)}                child: Padding(
${''?left_pad(indent)}                  padding: EdgeInsets.only(top: paddingTop),
${''?left_pad(indent)}                  child: Text("${field.title}：", style: TextStyle(fontSize: fontSize),),
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#if field.input == 'images'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Align(
${''?left_pad(indent)}                      alignment: Alignment.topLeft,
${''?left_pad(indent)}                      child: Wrap(
${''?left_pad(indent)}                        children: buildImagesFor("${fieldName}"),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#else>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
      <#if field.unit?? && field.unit != ''>
${''?left_pad(indent)}                  decoration: InputDecoration(
${''?left_pad(indent)}                    suffix: Text("${field.unit}"),
${''?left_pad(indent)}                  ),
      </#if>
      <#if field.input == 'select' || field.input == 'radio' || field.input == 'check'>
${''?left_pad(indent)}                  initialValue: ${app.name}.convertValue2Text("${fieldName}", values${dart.nameType(widget.variable)}!["${fieldName}"]),
      <#elseif field.input == 'district'>
${''?left_pad(indent)}                  initialValue: ${app.name}.convertDistrict2Text(values${dart.nameType(widget.variable)}!["${fieldName}"]),
      <#elseif field.input == 'bool'>
${''?left_pad(indent)}                  initialValue: values${dart.nameType(widget.variable)}!["${fieldName}"] == 'T' ? '是' : '否',
      <#else>
${''?left_pad(indent)}                  initialValue: values${dart.nameType(widget.variable)}!["${fieldName}"],
      </#if>
      <#if field.input == 'longtext'>
${''?left_pad(indent)}                  maxLines: 5,
      </#if>
${''?left_pad(indent)}                  readOnly: true,
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    </#if>
${''?left_pad(indent)}            ],
${''?left_pad(indent)}          ),
  </#list>
${''?left_pad(indent)}        ],
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
  <#assign hasBuildImagesFor = false>
  <#list widget.customReadonly.fields as field>
    <#if field.input == 'images' && hasBuildImagesFor == false>
      <#assign hasBuildImagesFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable}】图片浏览。
${''?left_pad(indent)} */
${''?left_pad(indent)}List<Widget> buildImagesFor(String name) {
${''?left_pad(indent)}  List<Widget> ret = [];
${''?left_pad(indent)}  List<Map> images = values${dart.nameType(widget.variable)}![name];
${''?left_pad(indent)}  if (images == null) images = [];
${''?left_pad(indent)}  for (int i = 0; i < images.length; i++) {
${''?left_pad(indent)}    ret.add(GestureDetector(
${''?left_pad(indent)}      child: Container(
${''?left_pad(indent)}        width: 80,
${''?left_pad(indent)}        height: 80,
${''?left_pad(indent)}        margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
${''?left_pad(indent)}        decoration: BoxDecoration(
${''?left_pad(indent)}          border: Border.all(color: Colors.grey),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        child: Align(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Image.network(images[i]["url"]),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      onTap: () async {
${''?left_pad(indent)}        showDialog(context: context, builder: (_) => ImageViewer(images[i]["url"]));
${''?left_pad(indent)}      },
${''?left_pad(indent)}    ));
${''?left_pad(indent)}  }
${''?left_pad(indent)}  return ret;
${''?left_pad(indent)}}
    </#if>
  </#list>
</#macro>

<#macro print_dart_methods_styledform widget indent>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 创建【${widget.variable?upper_case}】花式表单字段控制器。
${''?left_pad(indent)} */
${''?left_pad(indent)}void createControllers${dart.nameType(widget.variable)}() {
  <#list widget.customStyled.fields![] as field>
    <#assign fieldName = field.name!field.title>
    <#if field.input == 'ruler'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"] = TextEditingController();
    <#elseif field.input == 'bool'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"] = ValueNotifier(false);
    </#if>
  </#list>
${''?left_pad(indent)}}

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 销毁【${widget.variable?upper_case}】花式表单字段控制器。
${''?left_pad(indent)} */
${''?left_pad(indent)}void destroyControllers${dart.nameType(widget.variable)}() {
${''?left_pad(indent)}  for (final controller in controllers${dart.nameType(widget.variable)}.values) {
${''?left_pad(indent)}    controller.dispose();
${''?left_pad(indent)}  }
${''?left_pad(indent)}}

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 读取数据填充【${widget.variable?upper_case}】花式表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Future<Map> get${dart.nameType(widget.variable)}Values() async {
${''?left_pad(indent)}  if (values${dart.nameType(widget.variable)} != null) return values${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}  values${dart.nameType(widget.variable)} = await ${app.name}.read${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}("0");
  <#list widget.customStyled.fields![] as field>
    <#assign fieldName = field.name!field.title>
    <#if field.input == 'date' || field.input == 'time' || field.input == 'ruler'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].text = values${dart.nameType(widget.variable)}!["${fieldName}"];
    <#elseif field.input == 'select'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].text = v1.convertValue2Text("${fieldName}", values${dart.nameType(widget.variable)}!["${fieldName}"]);
    <#elseif field.input == 'district'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].text = v1.convertDistrict2Text(values${dart.nameType(widget.variable)}!["${fieldName}"]);
    <#elseif field.input == 'bool'>
${''?left_pad(indent)}  controllers${dart.nameType(widget.variable)}["${fieldName}"].value = values${dart.nameType(widget.variable)}!["${fieldName}"] == 'T';
    </#if>
  </#list>
${''?left_pad(indent)}  return values${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
<#assign hasBuildRadioFor = false>
<#assign hasBuildCheckFor = false>
<#assign hasBuildSelectFor = false>
<#assign hasBuildImagesFor = false>
<#assign hasShowRulerFor = false>
<#list widget.customStyled.fields![] as field>
  <#if field.input == 'images' && hasBuildImagesFor == false>
    <#assign hasBuildImagesFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable}】图片上传。
${''?left_pad(indent)} */
${''?left_pad(indent)}List<Widget> buildImagesFor(String name) {
${''?left_pad(indent)}  List<Widget> ret = [];
${''?left_pad(indent)}  List<Map> images = values${dart.nameType(widget.variable)}![name];
${''?left_pad(indent)}  if (images == null) images = [];
${''?left_pad(indent)}  for (int i = 0; i < images.length; i++) {
${''?left_pad(indent)}    ret.add(GestureDetector(
${''?left_pad(indent)}      child: Container(
${''?left_pad(indent)}        width: 80,
${''?left_pad(indent)}        height: 80,
${''?left_pad(indent)}        margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
${''?left_pad(indent)}        decoration: BoxDecoration(
${''?left_pad(indent)}          border: Border.all(color: Colors.grey),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        child: Align(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Image.network(images[i]["url"]),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      onTap: () async {
${''?left_pad(indent)}        showDialog(context: context, builder: (_) => ImageViewer(images[i]["url"]));
${''?left_pad(indent)}      },
${''?left_pad(indent)}    ));
${''?left_pad(indent)}  }
${''?left_pad(indent)}  ret.add(GestureDetector(
${''?left_pad(indent)}    child: Container(
${''?left_pad(indent)}      width: 80,
${''?left_pad(indent)}      height: 80,
${''?left_pad(indent)}      margin: const EdgeInsets.fromLTRB(0, 6, 6, 0),
${''?left_pad(indent)}      decoration: BoxDecoration(
${''?left_pad(indent)}        border: Border.all(color: Colors.grey),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}      child: Align(
${''?left_pad(indent)}        alignment: Alignment.center,
${''?left_pad(indent)}        child: Icon(Icons.add),
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
${''?left_pad(indent)}    onTap: () async {
${''?left_pad(indent)}      ImagePicker picker = ImagePicker();
${''?left_pad(indent)}      XFile? image = await picker.pickImage(source: ImageSource.gallery);
${''?left_pad(indent)}    },
${''?left_pad(indent)}  ));
${''?left_pad(indent)}  return ret;
${''?left_pad(indent)}}
  <#elseif field.input == 'ruler' && hasShowRulerFor == false>
    <#assign hasShowRulerFor = true>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 显示【${widget.variable}】量尺输入。
${''?left_pad(indent)} */
${''?left_pad(indent)}void showRulerFor(String name) {
${''?left_pad(indent)}  showModalBottomSheet(
${''?left_pad(indent)}    context: context,
${''?left_pad(indent)}    builder: (builder) {
${''?left_pad(indent)}      return Container(
${''?left_pad(indent)}        height: 160,
${''?left_pad(indent)}        child: Padding(
${''?left_pad(indent)}          padding: EdgeInsets.only(bottom: 24),
${''?left_pad(indent)}          child:  RulerPicker(
${''?left_pad(indent)}            beginValue: 0,
${''?left_pad(indent)}            endValue: 1000,
${''?left_pad(indent)}            initValue: int.parse(values${dart.nameType(widget.variable)}![name] ?? "60"),
${''?left_pad(indent)}            scaleLineStyleList: [
${''?left_pad(indent)}              ScaleLineStyle(color: Colors.grey, width: 1.5, height: 30, scale: 0),
${''?left_pad(indent)}              ScaleLineStyle(color: Colors.grey, width: 1, height: 25, scale: 5),
${''?left_pad(indent)}              ScaleLineStyle(color: Colors.grey, width: 1, height: 15, scale: -1)
${''?left_pad(indent)}            ],
${''?left_pad(indent)}            onValueChange: (value) {
${''?left_pad(indent)}              setState(() {
${''?left_pad(indent)}                controllers${dart.nameType(widget.variable)}![name].text = value.toString();
${''?left_pad(indent)}                values${dart.nameType(widget.variable)}![name] = value.toString();
${''?left_pad(indent)}              });
${''?left_pad(indent)}            },
${''?left_pad(indent)}            width: MediaQuery.of(context).size.width,
${''?left_pad(indent)}            height: 80,
${''?left_pad(indent)}            rulerMarginTop: 8,
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      );
${''?left_pad(indent)}    }
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
  </#if>
</#list>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable?upper_case}】花式表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Widget buildStyled${dart.nameType(widget.variable)}() {
${''?left_pad(indent)}  const labelWidth = 100.0;
${''?left_pad(indent)}  const paddingTop = 12.0;
${''?left_pad(indent)}  const fontSize = 16.0;
${''?left_pad(indent)}  return Form(
${''?left_pad(indent)}    child: Padding(
${''?left_pad(indent)}      padding: EdgeInsets.all(16.0),
${''?left_pad(indent)}      child: Column(
${''?left_pad(indent)}        crossAxisAlignment: CrossAxisAlignment.start,
${''?left_pad(indent)}        children: [
  <#list widget.customStyled.fields as field>
    <#assign fieldName = field.name!field.title>
${''?left_pad(indent)}          Row(
${''?left_pad(indent)}            mainAxisAlignment: MainAxisAlignment.start,
${''?left_pad(indent)}            crossAxisAlignment: CrossAxisAlignment.start,
${''?left_pad(indent)}            children: [
${''?left_pad(indent)}              Container(
${''?left_pad(indent)}                width: labelWidth,
${''?left_pad(indent)}                child: Padding(
${''?left_pad(indent)}                  padding: EdgeInsets.only(top: paddingTop),
${''?left_pad(indent)}                  child: Text("${field.title!'标题'}：", style: TextStyle(fontSize: fontSize),),
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#if field.input == 'bool'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(top: paddingTop),
${''?left_pad(indent)}                      child: Align(
${''?left_pad(indent)}                        alignment: Alignment.centerRight,
${''?left_pad(indent)}                        child: AdvancedSwitch(
${''?left_pad(indent)}                          controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                          activeChild: Text('是'),
${''?left_pad(indent)}                          inactiveChild: Text('否'),
${''?left_pad(indent)}                          borderRadius: BorderRadius.circular(5),
${''?left_pad(indent)}                          width: 60,
${''?left_pad(indent)}                        ),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'images'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Align(
${''?left_pad(indent)}                      alignment: Alignment.topLeft,
${''?left_pad(indent)}                      child: Wrap(
${''?left_pad(indent)}                        children: buildImagesFor("${fieldName}"),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#elseif field.input == 'ruler'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: TextFormField(
${''?left_pad(indent)}                  controller: controllers${dart.nameType(widget.variable)}["${fieldName}"],
${''?left_pad(indent)}                  decoration: InputDecoration(
      <#if field.unit?? && field.unit != ''>
${''?left_pad(indent)}                    suffix: Text("${field.unit}"),
      </#if>
${''?left_pad(indent)}                    hintText: '请输入'
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                  textAlign: TextAlign.right,
${''?left_pad(indent)}                  readOnly: true,
${''?left_pad(indent)}                  onTap: () {
${''?left_pad(indent)}                    showRulerFor("${fieldName}");
${''?left_pad(indent)}                  },
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'single'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(top: 0),
${''?left_pad(indent)}                      child: Align(
${''?left_pad(indent)}                        alignment: Alignment.centerRight,
${''?left_pad(indent)}                        child: Wrap(
${''?left_pad(indent)}                          children: [
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.sick_outlined, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionEqualsToValue("${fieldName}", 0, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 0, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.sentiment_very_dissatisfied_outlined, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionEqualsToValue("${fieldName}", 1, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 1, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.mood_bad, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionEqualsToValue("${fieldName}", 2, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 2, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.sentiment_neutral_outlined, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionEqualsToValue("${fieldName}", 3, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 3, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.mood, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionEqualsToValue("${fieldName}", 4, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 4, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.sentiment_very_satisfied_outlined, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionEqualsToValue("${fieldName}", 5, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 5, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                          ],
${''?left_pad(indent)}                        ),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'successive'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(top: 0),
${''?left_pad(indent)}                      child: Align(
${''?left_pad(indent)}                        alignment: Alignment.centerRight,
${''?left_pad(indent)}                        child: Wrap(
${''?left_pad(indent)}                          children: [
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.star_border, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionNotGreaterThanValue("${fieldName}", 0, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 0, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.star_border, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionNotGreaterThanValue("${fieldName}", 1, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 1, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.star_border, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionNotGreaterThanValue("${fieldName}", 2, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 2, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.star_border, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionNotGreaterThanValue("${fieldName}", 3, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 3, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.star_border, size: 32,
${''?left_pad(indent)}                                color: ${app.name}.isOptionNotGreaterThanValue("${fieldName}", 4, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey,
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 4, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                          ],
${''?left_pad(indent)}                        ),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
  <#elseif field.input == 'multiple'>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(top: 0),
${''?left_pad(indent)}                      child: Align(
${''?left_pad(indent)}                        alignment: Alignment.centerRight,
${''?left_pad(indent)}                        child: Wrap(
${''?left_pad(indent)}                          children: [
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.coffee_outlined, size: 32,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 0, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 0, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.vaping_rooms_outlined, size: 32,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 1, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 1, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.local_bar_outlined, size: 32,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 2, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 2, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.sports_baseball_outlined, size: 32,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 3, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 3, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.egg_alt_outlined, size: 32,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 4, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 4, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(Icons.hotel_outlined, size: 32,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 5, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 5, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                            IconButton(
${''?left_pad(indent)}                              visualDensity: VisualDensity.compact,
${''?left_pad(indent)}                              padding: const EdgeInsets.all(0.0),
${''?left_pad(indent)}                              icon: Icon(LineariconsFree.poop, size: 26,
${''?left_pad(indent)}                                color: (${app.name}.isOptionInValue("${fieldName}", 6, values${dart.nameType(widget.variable)}!) ? Colors.blue : Colors.grey),
${''?left_pad(indent)}                              ),
${''?left_pad(indent)}                              onPressed: () {
${''?left_pad(indent)}                                ${app.name}.toggleOptionInValue("${fieldName}", 6, values${dart.nameType(widget.variable)}!);
${''?left_pad(indent)}                                setState(() {});
${''?left_pad(indent)}                              },
${''?left_pad(indent)}                            ),
${''?left_pad(indent)}                          ],
${''?left_pad(indent)}                        ),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    <#else>
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children:[
${''?left_pad(indent)}                    Container(height: 36,),
${''?left_pad(indent)}                    Divider(color: Colors.black,),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
    </#if>
${''?left_pad(indent)}            ],
${''?left_pad(indent)}          ),
  </#list>
${''?left_pad(indent)}        ],
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_listview widget indent>
${''?left_pad(indent)}Widget buildList${dart.nameType(widget.variable)}Widget() {
${''?left_pad(indent)}  return FutureBuilder(
${''?left_pad(indent)}    builder: (context, snapshot) {
${''?left_pad(indent)}      if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: CircularProgressIndicator(),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      if (!snapshot.hasData || (snapshot.hasData && snapshot.data!.isEmpty)) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Center(
${''?left_pad(indent)}            child: Column(
${''?left_pad(indent)}              children: [
${''?left_pad(indent)}                Image.asset("asset/image/nodata.png"),
${''?left_pad(indent)}                const Text("没有任何数据"),
${''?left_pad(indent)}              ],
${''?left_pad(indent)}            ),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      return ListView.builder(
${''?left_pad(indent)}        itemCount: snapshot.data?.length,
${''?left_pad(indent)}        itemBuilder: (context, index) {
${''?left_pad(indent)}          return ListTile(
${''?left_pad(indent)}            leading: Image.network(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'image'}"], width: 80, height: 80,),
${''?left_pad(indent)}            title: Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'primary'}"]),
${''?left_pad(indent)}            subtitle: Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'secondary'}"]),
${''?left_pad(indent)}            trailing: Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'status'}"], style: TextStyle(
${''?left_pad(indent)}              color: Colors.green,
${''?left_pad(indent)}            ),),
${''?left_pad(indent)}          );
<#--${''?left_pad(indent)}          return Row(-->
<#--${''?left_pad(indent)}            children: <Widget>[-->
<#--${''?left_pad(indent)}              Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'primary'}"])-->
<#--${''?left_pad(indent)}            ],-->
<#--${''?left_pad(indent)}          );-->
${''?left_pad(indent)}        },
${''?left_pad(indent)}      );
${''?left_pad(indent)}    },
${''?left_pad(indent)}    future: get${dart.nameType(widget.variable)}Items(),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}

${''?left_pad(indent)}Future<List<Map>> get${dart.nameType(widget.variable)}Items() async {
${''?left_pad(indent)}  items${dart.nameType(widget.variable)} = await ${app.name}.load${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}({});
${''?left_pad(indent)}  return items${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_gridview widget indent>
${''?left_pad(indent)}Widget buildGrid${dart.nameType(widget.variable)}Widget() {
${''?left_pad(indent)}  return FutureBuilder(
${''?left_pad(indent)}    builder: (context, snapshot) {
${''?left_pad(indent)}      if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: CircularProgressIndicator(),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      if (snapshot.hasData && snapshot.data!.isEmpty) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Center(
${''?left_pad(indent)}            child: Column(
${''?left_pad(indent)}              children: [
${''?left_pad(indent)}                Image.asset("asset/image/nodata.png"),
${''?left_pad(indent)}                const Text("没有任何数据"),
${''?left_pad(indent)}              ],
${''?left_pad(indent)}            ),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      return GridView.builder(
${''?left_pad(indent)}        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
${''?left_pad(indent)}          crossAxisCount: 2,
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        itemCount: snapshot.data?.length,
${''?left_pad(indent)}        itemBuilder: (context, index) {
<#--${''?left_pad(indent)}          return ListTile(-->
<#--${''?left_pad(indent)}            leading: Image.network(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'image'}"], width: 80, height: 80,),-->
<#--${''?left_pad(indent)}            title: Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'primary'}"]),-->
<#--${''?left_pad(indent)}            subtitle: Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'secondary'}"]),-->
<#--${''?left_pad(indent)}            trailing: Text(items${dart.nameType(widget.variable)}![index]["${widget.tile.primary!'status'}"], style: TextStyle(-->
<#--${''?left_pad(indent)}              color: Colors.green,-->
<#--${''?left_pad(indent)}            ),),-->
<#--${''?left_pad(indent)}          );-->
${''?left_pad(indent)}          return Card(
${''?left_pad(indent)}            color: Colors.amber,
${''?left_pad(indent)}            child: Center(
${''?left_pad(indent)}              child: Text('$index'),
${''?left_pad(indent)}            ),
${''?left_pad(indent)}          );
${''?left_pad(indent)}        },
${''?left_pad(indent)}      );
${''?left_pad(indent)}    },
${''?left_pad(indent)}    future: get${dart.nameType(widget.variable)}Items(),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}

${''?left_pad(indent)}Future<List<Map>> get${dart.nameType(widget.variable)}Items() async {
${''?left_pad(indent)}  items${dart.nameType(widget.variable)} = await ${app.name}.load${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}({});
${''?left_pad(indent)}  return items${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_cyclenavigator widget indent>
${''?left_pad(indent)}Widget buildCycle${dart.nameType(widget.variable)}Widget() {
${''?left_pad(indent)}  return FutureBuilder(
${''?left_pad(indent)}    builder: (context, snapshot) {
${''?left_pad(indent)}      if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: CircularProgressIndicator(),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      if (!snapshot.hasData || (snapshot.hasData && snapshot.data!.isEmpty)) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Center(
${''?left_pad(indent)}            child: Column(
${''?left_pad(indent)}              children: [
${''?left_pad(indent)}                Image.asset("asset/image/nodata.png"),
${''?left_pad(indent)}                const Text("没有任何数据"),
${''?left_pad(indent)}              ],
${''?left_pad(indent)}            ),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      return CarouselSlider(
${''?left_pad(indent)}        options: CarouselOptions(
${''?left_pad(indent)}          height: 200.0,
${''?left_pad(indent)}          autoPlay: true,
${''?left_pad(indent)}          viewportFraction: 1,
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        items: items${dart.nameType(widget.variable)}?.map((item) {
${''?left_pad(indent)}          return Builder(
${''?left_pad(indent)}            builder: (BuildContext context) {
${''?left_pad(indent)}              return Container(
${''?left_pad(indent)}                width: MediaQuery.of(context).size.width,
${''?left_pad(indent)}                margin: EdgeInsets.symmetric(horizontal: 5.0),
${''?left_pad(indent)}                decoration: BoxDecoration(
${''?left_pad(indent)}                  color: Colors.white
${''?left_pad(indent)}                ),
${''?left_pad(indent)}                child: Image.network(item["image"], fit: BoxFit.fill,),
${''?left_pad(indent)}              );
${''?left_pad(indent)}            },
${''?left_pad(indent)}          );
${''?left_pad(indent)}        }).toList(),
${''?left_pad(indent)}      );
${''?left_pad(indent)}    },
${''?left_pad(indent)}    future: get${dart.nameType(widget.variable)}Items(),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}

${''?left_pad(indent)}Future<List<Map>> get${dart.nameType(widget.variable)}Items() async {
${''?left_pad(indent)}  items${dart.nameType(widget.variable)} = await ${app.name}.load${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}({});
${''?left_pad(indent)}  return items${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_scrollnavigator widget indent>
${''?left_pad(indent)}Widget buildScroll${dart.nameType(widget.variable)}Widget() {
${''?left_pad(indent)}  return FutureBuilder(
${''?left_pad(indent)}    builder: (context, snapshot) {
${''?left_pad(indent)}      if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: CircularProgressIndicator(),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      if (!snapshot.hasData || (snapshot.hasData && snapshot.data!.isEmpty)) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Center(
${''?left_pad(indent)}            child: Column(
${''?left_pad(indent)}              children: [
${''?left_pad(indent)}                Image.asset("asset/image/nodata.png"),
${''?left_pad(indent)}                const Text("没有任何数据"),
${''?left_pad(indent)}              ],
${''?left_pad(indent)}            ),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      return CarouselSlider(
${''?left_pad(indent)}        options: CarouselOptions(
${''?left_pad(indent)}          height: 80.0,
${''?left_pad(indent)}          viewportFraction: 0.33,
${''?left_pad(indent)}        ),
${''?left_pad(indent)}        items: items${dart.nameType(widget.variable)}?.map((item) {
${''?left_pad(indent)}          return Builder(
${''?left_pad(indent)}            builder: (BuildContext context) {
${''?left_pad(indent)}              return Container(
${''?left_pad(indent)}                width: MediaQuery.of(context).size.width,
${''?left_pad(indent)}                margin: EdgeInsets.symmetric(horizontal: 5.0),
${''?left_pad(indent)}                decoration: BoxDecoration(
${''?left_pad(indent)}                  color: Colors.white
${''?left_pad(indent)}                ),
${''?left_pad(indent)}                child: Image.network(item["image"], fit: BoxFit.fill,),
${''?left_pad(indent)}              );
${''?left_pad(indent)}            },
${''?left_pad(indent)}          );
${''?left_pad(indent)}        }).toList(),
${''?left_pad(indent)}      );
${''?left_pad(indent)}    },
${''?left_pad(indent)}    future: get${dart.nameType(widget.variable)}Items(),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}

${''?left_pad(indent)}Future<List<Map>> get${dart.nameType(widget.variable)}Items() async {
${''?left_pad(indent)}  items${dart.nameType(widget.variable)} = await ${app.name}.load${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}({});
${''?left_pad(indent)}  return items${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_columnnavigator widget indent>
${''?left_pad(indent)}Widget buildColumn${dart.nameType(widget.variable)}Widget() {
${''?left_pad(indent)}  return FutureBuilder(
${''?left_pad(indent)}    builder: (context, snapshot) {
${''?left_pad(indent)}      if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: CircularProgressIndicator(),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      if (!snapshot.hasData || (snapshot.hasData && snapshot.data!.isEmpty)) {
${''?left_pad(indent)}        return Container(
${''?left_pad(indent)}          alignment: Alignment.center,
${''?left_pad(indent)}          child: Center(
${''?left_pad(indent)}            child: Column(
${''?left_pad(indent)}              children: [
${''?left_pad(indent)}                Image.asset("asset/image/nodata.png"),
${''?left_pad(indent)}                const Text("没有任何数据"),
${''?left_pad(indent)}              ],
${''?left_pad(indent)}            ),
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        );
${''?left_pad(indent)}      }
${''?left_pad(indent)}      return Padding(
${''?left_pad(indent)}        padding: const EdgeInsets.all(8.0),
${''?left_pad(indent)}        child: IntrinsicHeight(
${''?left_pad(indent)}          child: Row(
${''?left_pad(indent)}            mainAxisAlignment: MainAxisAlignment.center,
${''?left_pad(indent)}            children: [
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Padding(
${''?left_pad(indent)}                  padding: EdgeInsets.only(right: 4),
${''?left_pad(indent)}                  child: Container(
${''?left_pad(indent)}                    height: 248,
${''?left_pad(indent)}                    width: MediaQuery.of(context).size.width / 2,
${''?left_pad(indent)}                    child: Image.network(items${dart.nameType(widget.variable)}!["primary"]["image"], fit: BoxFit.fill),
${''?left_pad(indent)}                  ),
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
${''?left_pad(indent)}              Expanded(
${''?left_pad(indent)}                child: Column(
${''?left_pad(indent)}                  children: [
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(left: 4, bottom: 4),
${''?left_pad(indent)}                      child: Container(
${''?left_pad(indent)}                        height: 120,
${''?left_pad(indent)}                        width: MediaQuery.of(context).size.width / 2,
${''?left_pad(indent)}                        child: Image.network(items${dart.nameType(widget.variable)}!["secondary"]["image"], fit: BoxFit.fill),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                    Padding(
${''?left_pad(indent)}                      padding: EdgeInsets.only(left: 4, top: 4),
${''?left_pad(indent)}                      child: Container(
${''?left_pad(indent)}                        height: 120,
${''?left_pad(indent)}                        width: MediaQuery.of(context).size.width / 2,
${''?left_pad(indent)}                        child: Image.network(items${dart.nameType(widget.variable)}!["tertiary"]["image"], fit: BoxFit.fill),
${''?left_pad(indent)}                      ),
${''?left_pad(indent)}                    ),
${''?left_pad(indent)}                  ],
${''?left_pad(indent)}                ),
${''?left_pad(indent)}              ),
${''?left_pad(indent)}            ],
${''?left_pad(indent)}          ),
${''?left_pad(indent)}        ),
${''?left_pad(indent)}      );
${''?left_pad(indent)}    },
${''?left_pad(indent)}    future: get${dart.nameType(widget.variable)}Items(),
${''?left_pad(indent)}  );
${''?left_pad(indent)}}

${''?left_pad(indent)}Future<Map> get${dart.nameType(widget.variable)}Items() async {
${''?left_pad(indent)}  items${dart.nameType(widget.variable)} = await ${app.name}.load${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}({});
${''?left_pad(indent)}  return items${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}
</#macro>

<#macro print_dart_methods_chart widget indent>

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 读取数据填充【${widget.variable?upper_case}】只读表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Future<List<Map>> get${dart.nameType(widget.variable)}Stats() async {
${''?left_pad(indent)}  if (stats${dart.nameType(widget.variable)} != null) return stats${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}  stats${dart.nameType(widget.variable)} = await ${app.name}.load${dart.nameType(widget.variable)}4${dart.nameType(widget.pageName)}("0");
${''?left_pad(indent)}  return stats${dart.nameType(widget.variable)}!;
${''?left_pad(indent)}}

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable?upper_case}】只读表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}Widget buildChart${dart.nameType(widget.variable)}() {
  <#if widget.chartType == 'LINE' || widget.chartType == 'BAR'>
${''?left_pad(indent)}  return SfCartesianChart(
${''?left_pad(indent)}    primaryXAxis: CategoryAxis(),
  <#elseif widget.chartType == 'PIE'>
${''?left_pad(indent)}  return SfCircularChart(
  </#if>
${''?left_pad(indent)}    legend: Legend(isVisible: true),
${''?left_pad(indent)}    tooltipBehavior: TooltipBehavior(enable: true),
  <#if widget.chartType == 'LINE'>
${''?left_pad(indent)}    series: <ChartSeries<Map, String>>[
${''?left_pad(indent)}      LineSeries<Map, String>(
  <#elseif widget.chartType == 'BAR'>
${''?left_pad(indent)}    series: <ChartSeries<Map, String>>[
${''?left_pad(indent)}      BarSeries<Map, String>(
  <#elseif widget.chartType == 'PIE'>
${''?left_pad(indent)}    series: <CircularSeries<Map, String>>[
${''?left_pad(indent)}      DoughnutSeries<Map, String>(
  </#if>
${''?left_pad(indent)}        dataSource: stats${dart.nameType(widget.variable)}!,
${''?left_pad(indent)}        xValueMapper: (Map row, _) => row["category"],
${''?left_pad(indent)}        yValueMapper: (Map row, _) => row["value"],
${''?left_pad(indent)}        name: '${dart.nameType(widget.variable)}',
${''?left_pad(indent)}        dataLabelSettings: DataLabelSettings(isVisible: true)
${''?left_pad(indent)}      ),
${''?left_pad(indent)}    ],
${''?left_pad(indent)}  );
${''?left_pad(indent)}}
</#macro>
