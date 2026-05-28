<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
<#assign objects = appbase.convert_hierarchized_to_objects(wrapper)>
<#assign fields = appbase.convert_hierarchized_to_fields(wrapper)>
<#assign attrs = appbase.convert_hierarchized_to_attributes(wrapper)>
<#assign root = wrapper.object>
<#assign rootId = modelbase.get_id_attributes(root)[0]>
<#assign isHereNoTable = false>
<#list objects as obj>
  <#if obj.getLabelledOptions("persistence")["array"] == "true">
    <#assign isHereNoTable = true>
    <#break>
  </#if>
</#list>
<div widget-id="pageChangeYourNameHere" class="page side">
  <div class="card mb-0">
    <div class="card-body">
<#if isHereNoTable == false>
      <div widget-id="widgetForm${js.nameType(root.name)}"></div>
<#else>
  <#list objects as obj>
    <#if obj.getLabelledOptions("persistence")["array"] == "true">
      <div class="bordered-title d-flex">
        <strong>${modelbase.get_object_label(obj)}</strong>
        <a widget-id="buttonAdd${js.nameType(obj.name)}" class="btn-link ml-auto">新建</a>
      </div>
      <div widget-id="widgetTable${js.nameType(obj.name)}"></div>
    <#else>
      <div class="bordered-title d-flex">
        <strong>${modelbase.get_object_label(obj)}</strong>
      </div>
      <div widget-id="widgetForm${js.nameType(obj.name)}"></div>
    </#if>
  </#list>
</#if>
    </div>
  </div>
</div>
<script>
function PageChangeYourNameHere() {
  this.page = dom.find('#pageChangeYourNameHere')
}

PageChangeYourNameHere.prototype.initialize = async function (params) {
  dom.init(this, this.page);

  this.${modelbase.get_attribute_sql_name(rootId)} = params.${modelbase.get_attribute_sql_name(rootId)};

<#list objects as obj>
  <#if obj.getLabelledOptions("persistence")["array"] == "true">
  this.renderTable${js.nameType(obj.name)}(this.${modelbase.get_attribute_sql_name(rootId)});
  <#else>
  this.renderForm${js.nameType(obj.name)}(this.${modelbase.get_attribute_sql_name(rootId)});
  </#if>
</#list>
<#list objects as obj>
  <#if obj.getLabelledOptions("persistence")["array"] == "true">

  /*!
  ** 调用【${modelbase.get_object_label(obj)}】新增页面。
  */
  dom.bind(this.buttonAdd${js.nameType(obj.name)}, 'click', ev => {
    this.gotoEdit${js.nameType(obj.name)}();
  });
  </#if>
</#list>
};

/**
 * 在界面中渲染【${modelbase.get_object_label(root)}】编辑表单。
 */
PageChangeYourNameHere.prototype.renderForm${js.nameType(root.name)} = async function (${modelbase.get_attribute_sql_name(rootId)}) {
  let ${js.nameVariable(root.name)} = await this.read${js.nameType(root.name)}(${js.nameVariable(root.name)}Id);
  this.form${js.nameType(root.name)} = new FormLayout({
    columnCount: 1,
    fields: [{
<#list fields as attr>
  <#if attr?index != 0>
    },{
  </#if>
      title: '${modelbase.get_attribute_label(attr)}',
      name: '${modelbase.get_attribute_sql_name(attr)}',
  <#assign input = appbase.get_attribute_as_field_input(attr)>
      input: '${input}',
  <#if input == "select">
      options: {
        placeholder: '请选择...',
        fields: {
          value: '', text: '',
        },
      },
  <#elseif input == "file">
      params: {
        directoryKey: '这里必须填写',
      },
  </#if>
</#list>
    }],
  });
  this.form${js.nameType(root.name)}.render(this.widgetForm${js.nameType(root.name)}, ${js.nameVariable(root.name)});
};
<#list objects as obj>
  <#assign objId = modelbase.get_id_attributes(obj)[0]>
  <#if obj.getLabelledOptions("persistence")["array"] == "true">
    <#assign columns = appbase.convert_hierarchized_to_columns({"object": obj})>

/**
 * 在界面中渲染【${modelbase.get_object_label(root)}】分页表格。
 */
PageChangeYourNameHere.prototype.renderTable${js.nameType(obj.name)} = async function (${modelbase.get_attribute_sql_name(rootId)}) {
  this.table${js.nameType(root.name)} = new PaginationTable({
    url: '${appbase.get_api_url_full(root, "paginate")}',
    refreshable: false,
    limit: -1,
    columns: [{
<#list columns as attr>
      title: '${modelbase.get_attribute_label(attr)}',
      style: 'text-align: center;',
      display: (row, td) => {
        let el = dom.templatize(`
          <div>{{${modelbase.get_attribute_sql_name(attr)}}</div>
        `, row);
        // 把数据暂放入tr元素中
        dom.model(td.parentElement, row);
        td.appendChild(el);
      },
</#list>
    },{
      title: '操作',
      style: 'text-align: center;',
      display: (row, td) => {
        let el = dom.templatize(`
          <div class="full-width">
            <a widget-id="buttonEdit" class="btn-link">编辑</a>
            <a widget-id="buttonDelete" class="btn-link">删除</a>
          </div>
        `, row);
        let buttonEdit = dom.find('[widget-id=buttonEdit]', el);
        let buttonDelete = dom.find('[widget-id=buttonDelete]', el);
        dom.bind(buttonEdit, 'click', ev => {
          this.gotoEdit${js.nameType(obj.name)}(row.${modelbase.get_attribute_sql_name(objId)});
        });
        dom.bind(buttonDelete, 'click', ev => {
          let tr = dom.ancestor(buttonDelete, 'tr');
          tr.remove();
        });
        td.appendChild(el);
      },
    }],
  })
  this.table${js.nameType(obj.name)}.render(this.widgetTable${js.nameType(obj.name)});
};

PageChangeYourNameHere.prototype.gotoEdit${js.nameType(obj.name)} = function (${modelbase.get_attribute_sql_name(objId)}) {
  ajax.dialog({
    title: '${modelbase.get_object_label(obj)}',
    allowClose: true,
    shadeClose: false,
    width: '35%',
    height: '500px',
    url: 'html/${obj.getLabelledOptions("name")["schema"]}/${obj.getLabelledOptions("name")["module"]}/${root.name}/${obj.name}.html',
    success: () => {
      page${js.nameType(root.name)}${js.nameType(obj.name)}.show({
        ${modelbase.get_attribute_sql_name(objId)}: ${modelbase.get_attribute_sql_name(objId)},
        onSaved: (val) => {
          this.append2Table${js.nameType(obj.name)}(val);
        }
      });
    },
  });
};

/**
 * 添加数据到【${modelbase.get_object_label(root)}】分页表格。
 */
PageChangeYourNameHere.prototype.append2Table${js.nameType(obj.name)} = function (rows) {
  if (!Array.isArray(rows)) rows = [rows];
  for (let i = 0; i < rows.length; i++) {
    this.table${js.nameType(obj.name)}.appendRow(rows[i]);
  }
};

/**
 * 装配【${modelbase.get_object_label(root)}】分页表格的数据。
 */
PageChangeYourNameHere.prototype.assembleFromTable${js.nameType(obj.name)} = function () {
  let ret = [];
  let tbody = this.widgetTable${js.nameType(obj.name)}.querySelector('tbody');
  for (let i = 0; i < tbody.children.length; i++) {
    let tr = tbody.children[i];
    let model = dom.model(tr);
    model.${modelbase.get_attribute_sql_name(rootId)} = '${r"${"}${modelbase.get_attribute_sql_name(rootId)}${r"}"}';
    ret.push(model);
  }
  return ret;
};
  </#if>
</#list>

/**
 * 读取【${modelbase.get_object_label(root)}】数据。
 */
PageChangeYourNameHere.prototype.read${js.nameType(root.name)} = async function (${js.nameVariable(root.name)}Id) {
  let ${js.nameVariable(root.name)} = await xhr.promise({
    url: '${appbase.get_api_url_full(root, "read")}',
    params: {
      ${js.nameVariable(root.name)}Id: ${js.nameVariable(root.name)}Id,
    },
  });
  return ${js.nameVariable(root.name)};
};

/**
 * 点击按钮后的保存【${modelbase.get_object_label(root)}】操作。
 */
PageChangeYourNameHere.prototype.save${js.nameType(root.name)} = async function () {
<#if root.getLabelledOptions("persistence")["array"] == "true">
  let ${js.nameVariable(root.name)}s = this.assembleFromTable${js.nameType(root.name)}();
<#else>
  let errors = Validation.validate(this.widgetForm${js.nameType(root.name)});
  if (errors.length > 0) {
    toast.error(this.page, utils.message(errors));
    return;
  }
  let ${js.nameVariable(root.name)} = dom.formdata(this.widgetForm${js.nameType(root.name)});
</#if>
<#if root.getLabelledOptions("persistence")["array"] == "true">
  for (let i = 0; i < ${js.nameVariable(root.name)}s.length; i++) {
    ${js.nameVariable(root.name)}s[i].modifierId = window.user.userId;
    ${js.nameVariable(root.name)}s[i].modifierType = 'STDBIZ.SAM.USER';
  }
<#else>
  <#list attrs as attr>
    <#if attr.constraint.domainType?string == 'now' || appbase.is_attribute_create_time(attr)>
  ${js.nameVariable(root.name)}.${modelbase.get_attribute_sql_name(attr)} = 'now';
    <#elseif appbase.is_attribute_create_user(attr)>
  ${js.nameVariable(root.name)}.${modelbase.get_attribute_sql_name(attr)} = window.user.userId;
    <#elseif appbase.is_attribute_attachment(attr)>
  let ${modelbase.get_attribute_sql_name(attr)}File = dom.find('input[name=${modelbase.get_attribute_sql_name(attr)}]', this.widgetForm${js.nameType(root.name)});
  if (${modelbase.get_attribute_sql_name(attr)}File.getAttribute('data-file-path') != '') {
    ${js.nameVariable(root.name)}.${modelbase.get_attribute_sql_name(attr)} = {
      filename: ${modelbase.get_attribute_sql_name(attr)}File.value,
      filepath: ${modelbase.get_attribute_sql_name(attr)}File.getAttribute('data-file-path').replaceAll('/www', ''),
    };
  }
    </#if>
  </#list>
</#if>
  let res = await xhr.promise({
<#if root.getLabelledOptions("persistence")["array"] == "true">
    url: '${appbase.get_api_url_full(root, "batch")}',
    params: {
      ${js.nameVariable(root.name)}: ${js.nameVariable(root.name)}s,
<#else>
    url: '${appbase.get_api_url_full(root, "merge")}',
    params: {
      ...${js.nameVariable(root.name)},
      modifierId: window.user.userId,
      modifierType: 'STDBIZ.SAM.USER',
</#if>
<#if wrapper.children??>
  <#list wrapper.children as child>
<@appbase.print_inner_params wrapper=child indent=6 />
  </#list>
</#if>
    },
  });
<#if root.getLabelledOptions("persistence")["array"] == "true">
  PubSub.publish('${appbase.get_api_url_short(root, "saved")}', {})
<#else>
  PubSub.publish('${appbase.get_api_url_short(root, "saved")}', ${js.nameVariable(root.name)})
</#if>
};

PageChangeYourNameHere.prototype.destroy = async function (params) {
  delete pageChangeYourNameHere;
};

PageChangeYourNameHere.prototype.show = async function (params) {
  this.initialize(params);
};

pageChangeYourNameHere = new PageChangeYourNameHere();
</script>
