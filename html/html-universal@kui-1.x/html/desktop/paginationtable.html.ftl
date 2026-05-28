<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
<#assign objects = appbase.convert_hierarchized_to_objects(wrapper)>
<#assign columns = appbase.convert_hierarchized_to_columns(wrapper)>
<#assign root = wrapper.object>
<#assign rootId = modelbase.get_id_attributes(root)[0]>
<div widget-id="pageChangeYourNameHere" class="page view">
  <div class="card mb-0">
    <div class="card-header">${modelbase.get_object_label(root)}</div>
    <div widget-id="widgetTable${js.nameType(root.name)}" class="card-body"></div>
  </div>
</div>
<script>
function PageChangeYourNameHere() {
  this.page = dom.find('#pageChangeYourNameHere');
}

PageChangeYourNameHere.prototype.initialize = async function (params) {
  dom.init(this, this.page);

  this.renderTable${js.nameType(root.name)}();

  /*!
  ** 调用【${modelbase.get_object_label(root)}】新增页面。
  */
  dom.bind(this.buttonAdd${js.nameType(root.name)}, 'click', ev => {
    this.gotoEdit${js.nameType(root.name)}();
  });
};

/**
 * 在页面中渲染【${modelbase.get_object_label(root)}】分页列表。
 */
PageChangeYourNameHere.prototype.renderTable${js.nameType(root.name)} = function (params) {
  this.table${js.nameType(root.name)} = new PaginationTable({
    url: '${appbase.get_api_url_full(root, "paginate")}',
    params: {
<#list objects as obj>
  <#if obj?index == 0><#continue></#if>
  <#if obj.getLabelledOptions("persistence")["array"] == "true">
      '//${appbase.get_api_url_short(obj, "find")}': {
        _hierarchy_name: '${js.nameVariable(obj.name)}s',
        _source_field: '${modelbase.get_attribute_sql_name(rootId)}',
        _target_field: '${modelbase.get_attribute_sql_name(rootId)}',
      }
  <#else>
      '_other_select': '',
      '_and_condition': '',
  </#if>
      '_order_by': '',
</#list>
    },
    columns: [{
      <#list columns as attr>
      <#if attr?index != 0>
    },{
      </#if>
      title: '${modelbase.get_attribute_label(attr)}',
      style: 'text-align: center;',
      display: (row, td) => {

      },
      </#list>
    },{
      title: '操作',
      style: 'text-align: center;',
      display: (row, td) => {
        let el = dom.templatize(`
          <div class="full-width">
            <a widget-id="buttonEdit" class="btn-link">编辑</a>
            <a widget-id="buttonView" class="btn-link">详情</a>
          </div>
        `, row);
        let buttonEdit = dom.find('[widget-id=buttonEdit]', el);
        let buttonView = dom.find('[widget-id=buttonView]', el);
        dom.bind(buttonEdit, 'click', ev => {
          this.gotoEdit${js.nameType(root.name)}(row.${js.nameVariable(root.name)}Id);
        });
        dom.bind(buttonView, 'click', ev => {
          this.gotoDetail${js.nameType(root.name)}(row.${js.nameVariable(root.name)}Id);
        });
        td.appendChild(el);
      },
    }],
  });
  this.table${js.nameType(root.name)}.render(this.widgetTable${js.nameType(root.name)}, {
    ...params,
  });
};

/**
 * 调用【${modelbase.get_object_label(root)}】编辑页面。
 */
PageChangeYourNameHere.prototype.gotoEdit${js.nameType(root.name)} = async function (${js.nameVariable(root.name)}Id) {
  ajax.sidebar({
    containerId: this.page,
    url: 'html/${appbase.get_api_url_full(root, "edit")}.html',
    title: '${modelbase.get_object_label(root)}编辑',
    allowClose: true,
    success: function() {
      page${js.nameType(root.name)}Edit.show({});
    },
  });
};

/**
* 调用【${modelbase.get_object_label(root)}】详情页面。
*/
PageChangeYourNameHere.prototype.gotoDetail${js.nameType(root.name)} = async function (${js.nameVariable(root.name)}Id) {
  ajax.shade({
    containerId: this.page,
    title: '${modelbase.get_object_label(root)}详情',
    url: 'html/${root.getLabelledOptions("name")["schema"]}/${root.getLabelledOptions("name")["module"]}/${root.name}/detail.html',
    success: function() {
      page${js.nameType(root.name)}Detail.show({});
    },
  });
};

PageChangeYourNameHere.prototype.destroy = async function (params) {
  delete pageChangeYourNameHere;
};

PageChangeYourNameHere.prototype.show = async function (params) {
  this.initialize(params);
};

pageChangeYourNameHere = new PageChangeYourNameHere();
</script>
