<#macro html_item_widget indent type model>
  <#if type == 'single_line'>
<@html_item_single_line indent=indent model=model />
  <#elseif type == 'two_line'>
<@html_item_two_line indent=indent model=model />
  <#elseif type == 'two_line_float'>
<@html_item_two_line_float indent=indent model=model />
  <#elseif type == 'image_two_line'>
<@html_item_image_two_line indent=indent model=model />
  <#elseif type == 'image_three_line'>
<@html_item_image_three_line indent=indent model=model />
  <#elseif type == 'image_two_line_float'>
<@html_item_image_two_line_float indent=indent model=model />
  <#elseif type == 'duration_progress'>
<@html_item_duration_progress indent=indent model=model />
  <#elseif type == 'comparison_progress'>
<@html_item_comparison_progress indent=indent model=model />
  <#elseif type == 'circular_progress'>
<@html_item_circular_progress indent=indent model=model />
  <#elseif type == 'tag_head'>
<@html_item_tag_head indent=indent model=model />
  <#elseif type == 'tag_tail'>
<@html_item_tag_tail indent=indent model=model />
  <#elseif type == 'switch'>
<@html_item_switch indent=indent model=model />
  <#elseif type == 'tristate'>
<@html_item_tristate indent=indent model=model />
  <#elseif type == 'person'>
<@html_item_person indent=indent model=model />
  </#if>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### ITEM
 ###
 ------------------------------------------------------------------------------>

<#--
 ### ------------------
 ### | primary        |
 ### ------------------
 -->
<#macro html_item_single_line indent model>
${''?left_pad(indent)}<div class="item list-view-item">
${''?left_pad(indent)}  <div class="header">{{{primary}}}</div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### ------------------
 ### | primary        |
 ### | secondary      |
 ### ------------------
 -->
<#macro html_item_two_line indent model>
${''?left_pad(indent)}<div class="item list-view-item">
${''?left_pad(indent)}  <div class="header">{{{primary}}}</div>
${''?left_pad(indent)}  <div class="description">{{{secondary}}}</div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### -------------------------
 ### |  /\  | primary        |
 ### |  \/  | secondary      |
 ### -------------------------
 -->
<#macro html_item_image_two_line indent model>
${''?left_pad(indent)}<div class="d-flex align-items-center">
${''?left_pad(indent)}  <div class="bg-gradient-primary">
${''?left_pad(indent)}    <img src="{{{image}}}" style="width:56px; height: 56px">
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div>
${''?left_pad(indent)}    <div class="text-value text-primary font-16">{{{primary}}}</div>
${''?left_pad(indent)}    <div class="text-muted font-weight-bold small">{{{secondary}}}</div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#-- Tertiary. Then quaternary (4), quinary (5), senary (6), septenary (7), octonary (8), nonary (9), and denary (10) -->
<#--
 ### -------------------------
 ### |  /\  | primary        |
 ### |  []  | secondary      |
 ### |  \/  | tertiary       |
 ### -------------------------
 -->
<#macro html_item_image_three_line indent model>
${''?left_pad(indent)}<div class="item list-view-item" style="height: 105px;">
${''?left_pad(indent)}  <div class="image circular">
${''?left_pad(indent)}    <img src="{{{image}}}" style="height: 80px;">
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div class="content" style="padding-top: 6px!important;">
${''?left_pad(indent)}    <a class="header">{{{primary}}}</a>
${''?left_pad(indent)}    <div class="meta">
${''?left_pad(indent)}      <span>{{{secondary}}}</span>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}    <div class="description">
${''?left_pad(indent)}      <i class="fas fa-file-medical text-red" style="padding-right: 5px;"></i>{{{tertiary}}}
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------------------------
 ### |  /\  | primary      | /\ |
 ### |  \/  | secondary    | \/ |
 ### ----------------------------
 -->
<#macro html_item_image_two_line_float indent model>

</#macro>

<#--
 ### ---------------------
 ### | primary      | /\ |
 ### |              | \/ |
 ### ---------------------
 -->
<#macro html_item_single_line_float indent model>
${''?left_pad(indent)}<div class="item list-view-item">
${''?left_pad(indent)}  <div class="content" style="padding-top: 6px!important;">
${''?left_pad(indent)}    <a class="header">{{{primary}}}</a>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div class="image">
${''?left_pad(indent)}    <img src="{{{image}}}" style="width: 48px; height: 48px;">
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### -------------------------------
 ### | primary        | tertiary   |
 ### | secondary      | quaternary |
 ### -------------------------------
 -->
<#macro html_item_two_line_float model>
${''?left_pad(indent)}<div class="item list-view-item" data-model-hospital-id="1" data-model-clinic-id="undefined" data-model-medical-service-schedule-id="1000413131202102221330">
${''?left_pad(indent)}  <div class="content">
${''?left_pad(indent)}    <div class="header">{{{primary}}}</div>
${''?left_pad(indent)}    <div class="ui two column grid mt-02">
${''?left_pad(indent)}      <div class="column left aligned">
${''?left_pad(indent)}        <div class="ui basic green tiny">
${''?left_pad(indent)}          <i class="fas fa-map-marked" style="margin-right: 10px;"></i>{{{secondary}}}
${''?left_pad(indent)}        </div>
${''?left_pad(indent)}      </div>
${''?left_pad(indent)}      <div class="column left aligned">
${''?left_pad(indent)}        <div class="ui basic green tiny">
${''?left_pad(indent)}          <i class="fas fa-user-friends" style="margin-right: 10px;"></i>{{{secondary}}}
${''?left_pad(indent)}        </div>
${''?left_pad(indent)}      </div>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div class="image price" style="margin-left: 0!important;">
${''?left_pad(indent)}    <div class="ui basic font-20 right floated zigzag-green">
${''?left_pad(indent)}      <div style="position: absolute;top: 50%;left: 45%; transform: translateY(-50%) translateX(-50%); text-align: center;">
${''?left_pad(indent)}        <span>{{{tertiary}}}</span>
${''?left_pad(indent)}        <p class="font-12 mt-5">{{{quaternary}}}</p>
${''?left_pad(indent)}      </div>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | /\ | /\ | /\ | /\ | /\ |
 ### | \/ | \/ | \/ | \/ | \/ |
 ### --------------------------
 -->
<#macro html_item_images indent model>
${''?left_pad(indent)}<div class="row m-auto" style="justify-content: center;">
${''?left_pad(indent)}  {{{#each images}}}
${''?left_pad(indent)}  <div class="avatar avatar-36 tooltip-avatar">
${''?left_pad(indent)}    <img src="${r'${row.'}${model.image!'image'}${r'}'}">
${''?left_pad(indent)}    <span class="tooltip-text">{{{this}}}</span>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  {{{/each}}}
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | 80%        start - end |
 ### | ==================     |
 ### --------------------------
 -->
<#macro html_item_duration_progress indent model>
${''?left_pad(indent)}<div>
${''?left_pad(indent)}  <div class="clearfix">
${''?left_pad(indent)}    <div class="float-left">
${''?left_pad(indent)}      <strong>${r'${row.'}${model.percentage!'percentage'}${r'}'}%</strong>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}    <div class="float-right">
${''?left_pad(indent)}      <small class="text-muted">${r'${row.'}${model.startTime!'startTime'}${r'}'} - ${r'${row.'}${model.endTime!'endTime'}${r'}'}</small>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div class="progress progress-xs">
${''?left_pad(indent)}    <div class="progress-bar bg-${r'${row.'}${model.status!'status'}${r'}'}" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div> 
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | primary            80% |
 ### | ==================     |
 ### --------------------------
 -->
<#macro html_item_theme_progress indent model>
${''?left_pad(indent)}<div class="progress-group">
${''?left_pad(indent)}  <div class="progress-group-header">
${''?left_pad(indent)}    <svg class="c-icon progress-group-icon">
${''?left_pad(indent)}      <use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-user"></use>
${''?left_pad(indent)}    </svg>
${''?left_pad(indent)}    <div>${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${''?left_pad(indent)}    <div class="mfs-auto font-weight-bold">${r'${row.'}${model.percentage!'percentage'}${r'}'}%</div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div class="progress-group-bars">
${''?left_pad(indent)}    <div class="progress progress-xs">
${''?left_pad(indent)}      <div class="progress-bar bg-warning" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | primary ============== |
 ### |         =========      |
 ### --------------------------
 -->
<#macro html_item_comparison_progress indent model>
${''?left_pad(indent)}<div class="progress-group mb-4">
${''?left_pad(indent)}  <div class="progress-group-prepend">
${''?left_pad(indent)}    <span class="progress-group-text">${r'${row.'}${model.primary!'primary'}${r'}'}</span>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  <div class="progress-group-bars">
${''?left_pad(indent)}    <div class="progress progress-xs">
${''?left_pad(indent)}      <div class="progress-bar bg-info" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}    <div class="progress progress-xs">
${''?left_pad(indent)}      <div class="progress-bar bg-danger" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#macro html_item_circular_progress>
${''?left_pad(indent)}<div class="progress-circle over50 p${r'${row.'}${model.percentage!'percentage'}${r'}'}">
${''?left_pad(indent)}  <span>${r'${row.'}${model.percentage!'percentage'}${r'}'}%</span>
${''?left_pad(indent)}  <div class="left-half-clipper">
${''?left_pad(indent)}    <div class="first50-bar"></div>
${''?left_pad(indent)}    <div class="value-bar"></div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------------------------
 ### | [] | primary | secondary |
 ### ----------------------------
 -->
<#macro html_item_person indent model>
${''?left_pad(indent)}<div class="ui yellow image label bg-info text-white">
${''?left_pad(indent)}  <img src="{{{image}}}" height="32">
${''?left_pad(indent)}  <span>{{{primary}}}</span>
${''?left_pad(indent)}  <p class="detail">{{{secondary}}}</p>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------
 ### | |----\ |
 ### | |----/ |
 ### ----------
 -->
<#macro html_item_tag_tail indent model>
${''?left_pad(indent)}<div class="font-13 m-auto tag-success">
${''?left_pad(indent)}  <span>${r'${row.'}${model.primary!'primary'}${r'}'}</span>
${''?left_pad(indent)}  <div class="tag-success-after"></div>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------
 ### | /----| |
 ### | \----| |
 ### ----------
 -->
<#macro html_item_tag_head indent model>
${''?left_pad(indent)}<a class="ui tag label bg-danger text-white ml-5">${r'${row.'}${model.primary!'primary'}${r'}'}</a>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### FIELD
 ###
 ------------------------------------------------------------------------------>

<#--
 ### ---------------------------
 ### |  primary  |  secondary  |
 ### ---------------------------
 -->
<#macro html_field_switch indent model>
${''?left_pad(indent)}<div class="text-switch">
${''?left_pad(indent)}  <label class="mb-0" data-switch=".checked">
${''?left_pad(indent)}    <input name="text-switch" type="radio" style="display: none">${r'${row.'}${model.primary!'primary'}${r'}'}
${''?left_pad(indent)}  </label>
${''?left_pad(indent)}  <label class="mb-0 checked" data-switch=".checked">
${''?left_pad(indent)}    <input name="text-switch" type="radio" style="display: none">${r'${row.'}${model.secondary!'secondary'}${r'}'}
${''?left_pad(indent)}  </label>
${''?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------------------------------------
 ### |  primary  |  secondary  |  tertiary  |
 ### ----------------------------------------
 -->
<#macro html_field_tristate indent model>
${''?left_pad(indent)}<div class="text-multi-switch">
${''?left_pad(indent)}  <label class="mb-0 checked" style="width: 33.3%" data-switch=".checked">
${''?left_pad(indent)}    <input type="radio" style="display: none;">${r'${row.'}${model.primary!'primary'}${r'}'}
${''?left_pad(indent)}  </label>
${''?left_pad(indent)}  <label class="mb-0" style="width: 33.3%" data-switch=".checked">
${''?left_pad(indent)}    <input type="radio" style="display: none;">${r'${row.'}${model.secondary!'secondary'}${r'}'}
${''?left_pad(indent)}  </label>
${''?left_pad(indent)}  <label class="mb-0" style="width: 33.4%" data-switch=".checked">
${''?left_pad(indent)}    <input type="radio" style="display: none;">${r'${row.'}${model.tertiary!'tertiary'}${r'}'}
${''?left_pad(indent)}  </label>
${''?left_pad(indent)}</div>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### BLOCK
 ###
 ------------------------------------------------------------------------------>

<#macro html_block_properties indent model>
${''?left_pad(indent)}<div>
${''?left_pad(indent)}  <div class="title-bordered mb-2">
${''?left_pad(indent)}    <strong>{{{title}}}</strong>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  {{#each properties}}
${''?left_pad(indent)}  <div class="form form-horizontal">
${''?left_pad(indent)}    <div class="form-group row m-auto">
${''?left_pad(indent)}      <label class="col-md-2 col-form-label">
${''?left_pad(indent)}        <i class="fas fa-phone"></i>
${''?left_pad(indent)}      </label>
${''?left_pad(indent)}      <label class="col-md-10">
${''?left_pad(indent)}        {{#if scheme}}
${''?left_pad(indent)}        <a class="btn btn-link" href="tel:18987654321">{{{value}}}</a>
${''?left_pad(indent)}        {{else}}
${''?left_pad(indent)}        <strong>{{{value}}}</strong>
${''?left_pad(indent)}        {{/if}}
${''?left_pad(indent)}      </label>
${''?left_pad(indent)}    </div>
${''?left_pad(indent)}  </div>
${''?left_pad(indent)}  {{/each}}
${''?left_pad(indent)}</div>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### FORM_LAYOUT
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_formlayout widget indent>
  <#if !widget.model??><#return></#if>
  <#local managedObject = widget.managedObject!{}>
  <#local fields = widget.model.fields![]>
  <#local request = widget.model.request!{}>
  <#local rootWrapper = widget.rootWrapper>
  <#local rootObj = rootWrapper.object>
  <#local rootObjId = modelbase.get_id_attributes(rootWrapper.object)[0]>
  <#local existingFields = {}>
  <#local fieldIndex = 0>
${''?left_pad(indent)}
${''?left_pad(indent)}this.params = params || {};
${''?left_pad(indent)}
${''?left_pad(indent)}this.form${js.nameType(widget["variable"])} = new FormLayout({
${''?left_pad(indent)}  columnCount: 1,
  <#if widget.savable!false><#-- 可保存 -->
${''?left_pad(indent)}  confirm: () => {
${''?left_pad(indent)}    dialog.confirm('确定保存数据？', () => {
${''?left_pad(indent)}      this.save${js.nameType(widget["variable"])}();
${''?left_pad(indent)}    });
${''?left_pad(indent)}  },
  <#else>
${''?left_pad(indent)}  actionable: false, // 不绑定侧边栏的按钮
  </#if>
${''?left_pad(indent)}  fields: [{
${''?left_pad(indent)}    title: '对象标识',
${''?left_pad(indent)}    name: '${modelbase.get_attribute_sql_name(rootObjId)}',
${''?left_pad(indent)}    input: 'hidden',
  <#list fields as field>
    <#local input = field["input"]!'text'>
    <#-- 标识不需要显示 -->
    <#if field["identifiable"]!false><#continue></#if>
    <#if input == 'none'><#continue></#if>
    <#local fieldName = field["fieldName"]!field["title"]>
    <#if !fieldName?contains(".")>
      <#local fieldName = js.nameVariable(fieldName)>
    </#if>
    <#-- 自定义的不需要过滤 -->
    <#if existingFields[fieldName]?? && fieldName != 'TODO'><#continue></#if>
    <#local existingFields = existingFields + {fieldName: field}>
${''?left_pad(indent)}  },{
${''?left_pad(indent)}    title: '${field["title"]!''}',
${''?left_pad(indent)}    name: '${fieldName}',
    <#if field.input == "readonly">
${''?left_pad(indent)}    readonly: true,
    </#if>
${''?left_pad(indent)}    required: <#if field["required"]!false == true>true<#else>false</#if>,
    <#if input == "select">
${''?left_pad(indent)}    input: 'select',
${''?left_pad(indent)}    options: {
${''?left_pad(indent)}      placeholder: '请选择...',
      <#if field.domainType?? && field.domainType?starts_with("&")>
        <#local domainTypeObjectName = field.domainType?substring(1, field.domainType?index_of("("))>
${''?left_pad(indent)}      searchable: true,
${''?left_pad(indent)}      url: '/api/v3/common/script/${(field.refSchemaName!"todo")?lower_case}/${(field.refModuleName!"todo")?lower_case}/${domainTypeObjectName}/find',
        <#if field.refTableName?? && field.refTableName?starts_with("tc_")>
${''?left_pad(indent)}      fields: {value: '${js.nameVariable(domainTypeObjectName)}Code', text: '${js.nameVariable(domainTypeObjectName)}Name'},
        <#else>
${''?left_pad(indent)}      fields: {value: '${js.nameVariable(domainTypeObjectName)}Id', text: '${js.nameVariable(domainTypeObjectName)}Name'},
        </#if>
      <#else>
${''?left_pad(indent)}      searchable: false,
${''?left_pad(indent)}      values: [{value: 'TODO', text: 'TODO'}],
${''?left_pad(indent)}      fields: {value: 'value', text: 'text'},
      </#if>
${''?left_pad(indent)}    },
    <#elseif input == "attachment">
${''?left_pad(indent)}    input: 'file',
${''?left_pad(indent)}    params: {
${''?left_pad(indent)}      directoryKey: '${widget.variable}',
${''?left_pad(indent)}    },
    <#elseif input == "attachments">
${''?left_pad(indent)}    input: 'fileupload',
${""?left_pad(indent)}    options: {
${""?left_pad(indent)}      url: {
${""?left_pad(indent)}        fetch: '/api/v3/common/script/stdbiz/_aux/stored_file/find',
${""?left_pad(indent)}      },
${""?left_pad(indent)}      params: {
${""?left_pad(indent)}        directoryKey: 'TODO',
${""?left_pad(indent)}      },
${""?left_pad(indent)}    },
    <#elseif input == "images" || input == "image" || input == "video" || input == "videos">
${''?left_pad(indent)}    input: '${input}',
${''?left_pad(indent)}    options: {
${''?left_pad(indent)}      mediaType: '${input?replace("s","")}',
${''?left_pad(indent)}      multiple: ${input?ends_with("s")?string},
${''?left_pad(indent)}      params: {
${''?left_pad(indent)}        directoryKey: 'TODO',
${''?left_pad(indent)}      },
${''?left_pad(indent)}      width: 90,
${''?left_pad(indent)}    },
    <#elseif input == "custom">
${""?left_pad(indent)}    input: 'custom',
${""?left_pad(indent)}    create: (button, custom, field) => {
${""?left_pad(indent)}      this.widgetCustom${js.nameType(fieldName)} = custom;
${""?left_pad(indent)}      dom.bind(button, 'click', ev => {
${""?left_pad(indent)}        ajax.dialog({
${""?left_pad(indent)}          title: 'TODO: 你要调用的页面的标题',
${""?left_pad(indent)}          allowClose: true,
${""?left_pad(indent)}          shadeClose: false,
${""?left_pad(indent)}          width: '50%',
${""?left_pad(indent)}          height: '500px',
${""?left_pad(indent)}          url: 'TODO: 你要调用的页面的路径',
${""?left_pad(indent)}          success: () => {
${""?left_pad(indent)}            // TODO: 添加调用对话框后的显示逻辑
${""?left_pad(indent)}            let input = dom.find('input[name=${js.nameType(fieldName)}]');
${""?left_pad(indent)}            pageChangeToYourPageName.show({
${""?left_pad(indent)}              onSaved: (data) => {
${""?left_pad(indent)}                this.appendCustom${js.nameType(fieldName)}(data, '${js.nameType(fieldName)}');
${""?left_pad(indent)}              },
${""?left_pad(indent)}            });
${""?left_pad(indent)}          },
${""?left_pad(indent)}        });
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
    <#else>
${''?left_pad(indent)}    input: '${field.input!'text'}',
    </#if>
    <#if field.unit?? && field.unit?trim != ''>
${''?left_pad(indent)}    unit: '${field.unit}',
    </#if>
    <#local fieldIndex = fieldIndex + 1>
  </#list>
${''?left_pad(indent)}  }],
${''?left_pad(indent)}});
${''?left_pad(indent)}if (!this.params.${modelbase.get_attribute_sql_name(rootObjId)}) {
${''?left_pad(indent)}  this.form${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])});
${''?left_pad(indent)}} else if (this.read${js.nameType(widget["variable"])}) {
${''?left_pad(indent)}  this.read${js.nameType(widget["variable"])}();
${''?left_pad(indent)}}
</#macro>

<#macro print_js_methods_formlayout page widget indent>
  <#local rootWrapper = widget.rootWrapper>
  <#local fields = widget.model.fields>
  <#local rootObj = rootWrapper.object>
  <#local rootObjIds = modelbase.get_id_attributes(rootObj)>
  <#local rootObjId = rootObjIds[0]>
  <#if widget.savable!false><#-- 可保存 -->
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 执行【${page.title}】数据的保存操作。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.save${js.nameType(widget.variable)} = async function () {
${""?left_pad(indent)}  let errors = Validation.validate(this.widget${js.nameType(widget.variable)});
${""?left_pad(indent)}  if (errors.length > 0) {
${""?left_pad(indent)}    dialog.error(utils.message(errors));
${""?left_pad(indent)}    return;
${""?left_pad(indent)}  }
${""?left_pad(indent)}  let ${js.nameVariable(widget.variable)} = this.form${js.nameType(widget.variable)}.getData();
  <#-- ⭐️ 页面中其他部件所构成的参数（比如表单、表格等） -->
  <#list page.widgets as pageWidget>
    <#if pageWidget.variable == widget.variable><#-- 和当前处理的部件是同一个，忽略 --><#continue></#if>
    <#if pageWidget.widgetType == "FormLayout" && (!pageWidget.savable?? || pageWidget.savable == false)>
${""?left_pad(indent)}  let ${js.nameVariable(pageWidget.variable)} = this.form${js.nameType(pageWidget.variable)}.getData();
    <#elseif pageWidget.widgetType == "PaginationTable" && (pageWidget.assemblable?? && pageWidget.assemblable == true)>
      <#local otherRootObj = pageWidget.rootWrapper.object>
${""?left_pad(indent)}  let ${js.nameVariable(otherRootObj.name)}s = this.assembleParams4${js.nameType(otherRootObj.name)}();
    </#if>
  </#list>
${""?left_pad(indent)}  let params =  {
  <#-- ⭐️ 此表单中模型（对象层级结构）所定义的参数 -->
<@print_js_params_for_save parents=[] wrapper=rootWrapper fields=fields page=page widget=widget indent=indent+4 />
${""?left_pad(indent)}  };
  <#-- ⭐️ 页面中其他部件所构成的参数（比如表单、表格等） -->
  <#list page.widgets as pageWidget>
    <#if pageWidget.variable == widget.variable><#-- 和当前处理的部件是同一个，忽略 --><#continue></#if>
    <#if !pageWidget.rootWrapper??><#continue></#if>
    <#local otherRootObj = pageWidget.rootWrapper.object>
    <#local names = otherRootObj.getLabelledOptions("name")>
    <#if pageWidget.widgetType == "FormLayout" && (!pageWidget.savable?? || pageWidget.savable == false)>
${""?left_pad(indent)}  if (!utils.isEmpty(${js.nameVariable(pageWidget.variable)})) {
${""?left_pad(indent)}    params['||${names["schema"]}/${names["module"]}/${otherRootObj.name}/merge'] = {
<@print_js_params_for_save parents=[] wrapper=pageWidget.rootWrapper fields=fields page=page widget=pageWidget indent=indent+6 />
${""?left_pad(indent)}    };
${""?left_pad(indent)}  }
    <#elseif pageWidget.widgetType == "PaginationTable" && (pageWidget.assemblable?? && pageWidget.assemblable == true)>
${""?left_pad(indent)}  if (${js.nameVariable(otherRootObj.name)}s && ${js.nameVariable(otherRootObj.name)}s.length > 0) {
${""?left_pad(indent)}    params['||${names["schema"]}/${names["module"]}/${otherRootObj.name}/batch'] =  {
${""?left_pad(indent)}      ${js.nameVariable(otherRootObj.name)}s: ${js.nameVariable(otherRootObj.name)}s,
${""?left_pad(indent)}    };
${""?left_pad(indent)}  }
    </#if>
  </#list>
${""?left_pad(indent)}  let data = await xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/merge',
${""?left_pad(indent)}    params: params,
${""?left_pad(indent)}  });
${""?left_pad(indent)}  if (data.${modelbase.get_attribute_sql_name(rootObjId)}) {
${""?left_pad(indent)}    // 回写标识
${''?left_pad(indent)}    this.params.${modelbase.get_attribute_sql_name(rootObjId)} = data.${modelbase.get_attribute_sql_name(rootObjId)};
${""?left_pad(indent)}    // 发布消息
${""?left_pad(indent)}    PubSub.publish('${page.applicationName}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/saved', data);
${""?left_pad(indent)}    // 成功提示
${""?left_pad(indent)}    toast.success(document.body, '数据成功保存！', 500);
${""?left_pad(indent)}    // 关闭滑窗
${""?left_pad(indent)}    dom.closeRightBar();
${""?left_pad(indent)}  }
${""?left_pad(indent)}};
${""?left_pad(indent)}
  </#if><#-- /可保存 -->
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 执行【${page.title}】已有数据的读取操作。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.read${js.nameType(widget.variable)} = async function () {
  <#local rootWrapper = widget.rootWrapper>
  <#local rootObj = rootWrapper.object>
  <#local rootObjId = modelbase.get_id_attributes(rootObj)[0]>
${""?left_pad(indent)}  let data = await xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/find',
${""?left_pad(indent)}    params: {
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(rootObjId)}: this.params.${modelbase.get_attribute_sql_name(rootObjId)},
${""?left_pad(indent)}      '_other_select': `
<@modelbase.print_sql_select rootWrapper=rootWrapper columns=fields indent=indent+8 />
${""?left_pad(indent)}      `,
${""?left_pad(indent)}      '_left_join': `
<@modelbase.print_sql_left_join rootWrapper=rootWrapper indent=indent+8 />
${""?left_pad(indent)}      `,
  <#list rootWrapper.children as childWrapper>
    <#local childObj = childWrapper.object>
    <#if childObj.getLabelledOptions("persistence")["array"] != "true"><#continue></#if>
${""?left_pad(indent)}      '<<${childObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(childObj)}/${childObj.name}/find': {
${""?left_pad(indent)}        _source_field: '${modelbase.get_attribute_sql_name(rootObjId)}',
${""?left_pad(indent)}        _target_field: '',
${""?left_pad(indent)}        _prefix_name: '',
${""?left_pad(indent)}      },
  </#list>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  });
${""?left_pad(indent)}  if (data.length > 0) {
  <#list rootObj.attributes as attr>
    <#if attr.constraint.domainType.toString() == "json">
${""?left_pad(indent)}    data[0].${modelbase.get_attribute_sql_name(attr)} = JSON.parse(data[0].${modelbase.get_attribute_sql_name(attr)} || '{}');
    </#if>
  </#list>
${""?left_pad(indent)}    this.form${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])}, data[0]);
${""?left_pad(indent)}  }
${""?left_pad(indent)}};
${""?left_pad(indent)}
  <#list fields as field>
    <#if field.input == "attachments">
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 收集【${field.title}】附件数据。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.getAttachmentsParams${js.nameType(field.fieldName)} = function () {
${""?left_pad(indent)}  extra = extra || {};
${""?left_pad(indent)}  let ret = [];
${""?left_pad(indent)}  let ul = dom.find('[data-fileupload-name="${field.fieldName}"] ul', this.widget${js.nameType(widget.variable)});
${""?left_pad(indent)}  for (let i = 0; i < ul.children.length; i++) {
${""?left_pad(indent)}    let li = ul.children[i];
${""?left_pad(indent)}    let model = dom.model(li);
${""?left_pad(indent)}    ret.push({
${""?left_pad(indent)}      ...model,
      <#list model.objects as obj>
        <#if obj.name == field.objectName>
          <#list obj.attributes as attr>
            <#if modelbase.is_attribute_system(attr)><#continue></#if>
            <#if modelbase.is_attribute_reference_id(attr, obj)>
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${modelbase.get_attribute_sql_name(rootObjId)}${r"}"}',
            <#elseif modelbase.is_attribute_reference_type(attr, obj)>
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(attr)}: '${rootObj.getLabelledOptions("name")["schema"]?upper_case}.${modelbase.get_object_module(rootObj)?upper_case}.${rootObj.name?upper_case}',
            <#elseif attr.type.name == rootObj.name>
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${modelbase.get_attribute_sql_name(rootObjId)}${r"}"}',
            </#if>
          </#list>
        </#if>
      </#list>
${""?left_pad(indent)}    });
${""?left_pad(indent)}  }
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}};
${""?left_pad(indent)}
    <#elseif field.input == "custom">
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 收集【${field.title}】自定义数据。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.getCustomParams${js.nameType(field.fieldName)} = function () {
${""?left_pad(indent)}  extra = extra || {};
${""?left_pad(indent)}  let ret = [];
${""?left_pad(indent)}  let ul = dom.find('[widget-id=widgetCustom_${field.fieldName}] ul', this.widget${js.nameType(widget.variable)});
${""?left_pad(indent)}  for (let i = 0; i < ul.children.length; i++) {
${""?left_pad(indent)}    let li = ul.children[i];
${""?left_pad(indent)}    let model = dom.model(li);
${""?left_pad(indent)}    ret.push({
${""?left_pad(indent)}      ...model,
      <#list model.objects as obj>
        <#if obj.name == field.objectName>
          <#list obj.attributes as attr>
            <#if modelbase.is_attribute_system(attr)><#continue></#if>
            <#if modelbase.is_attribute_reference_id(attr, obj)>
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${modelbase.get_attribute_sql_name(rootObjId)}${r"}"}',
            <#elseif modelbase.is_attribute_reference_type(attr, obj)>
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(attr)}: '${rootObj.getLabelledOptions("name")["schema"]?upper_case}.${modelbase.get_object_module(rootObj)?upper_case}.${rootObj.name?upper_case}',
            <#elseif attr.type.name == rootObj.name>
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${modelbase.get_attribute_sql_name(rootObjId)}${r"}"}',
            </#if>
          </#list>
        </#if>
      </#list>
${""?left_pad(indent)}    });
${""?left_pad(indent)}  }
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 添加新增的数据到【${field.title}】自定义显示的表单字段。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.appendCustom${js.nameType(field.fieldName)} = function(data) {
${""?left_pad(indent)}  let customWidget = dom.find('[widget-id=widgetCustom_${field.fieldName}]', this.widget${js.nameType(field.fieldName)});
${""?left_pad(indent)}  let ul = dom.find('ul', customWidget);
${""?left_pad(indent)}  if (ul == null) {
${""?left_pad(indent)}    ul = dom.element(`<ul class="list-group"></ul>`);
${""?left_pad(indent)}    customWidget.appendChild(ul);
${""?left_pad(indent)}  }
${""?left_pad(indent)}  // TODO: 自定义你的数据显示元素
${""?left_pad(indent)}  let li = dom.templatize(`
${""?left_pad(indent)}    <li class="list-group-item list-group-item-action full-width d-flex">
${""?left_pad(indent)}      <div>
${""?left_pad(indent)}        <strong>{{primary}}</strong>
${""?left_pad(indent)}        <div class="small text-muted">{{secondary}}</div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <a class="btn-link position-relative ml-auto">
${""?left_pad(indent)}        <i class="fas fa-trash-alt text-danger"></i>
${""?left_pad(indent)}      </a>
${""?left_pad(indent)}    </li>
${""?left_pad(indent)}  `, data);
${""?left_pad(indent)}  dom.model(li, data);
${""?left_pad(indent)}  let a = dom.find('a', li);
${""?left_pad(indent)}  dom.bind(a, 'click', ev => {
${""?left_pad(indent)}    dialog.confirm('确定要删除此项${field.title}数据？', () => {
${""?left_pad(indent)}      li.remove();
${""?left_pad(indent)}    });
${""?left_pad(indent)}  });
${""?left_pad(indent)}  ul.appendChild(li);
${""?left_pad(indent)}};
${""?left_pad(indent)}
    </#if>
  </#list>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### READONLY_FORM
 ###
 ------------------------------------------------------------------------------>

<#macro print_js_declare_readonlyform widget indent>
  <#if !widget.model??><#return></#if>
  <#local fields = widget.model.fields>
  <#local request = widget.model.request>
  <#local fieldIndex = 0>
${''?left_pad(indent)}this.readonly${js.nameType(widget.variable!'todo')} = new ReadonlyForm({
${''?left_pad(indent)}  columnCount: 3,
${''?left_pad(indent)}  fields: [{
  <#list fields as field>
    <#local input = field["input"]!'text'>
    <#if input == 'none'><#continue></#if>
    <#if field["identifiable"]!false><#continue></#if>
<#--    <#local fieldName = java.nameVariable(field["name"]?substring(0, field["name"]?index_of('@')))>-->
    <#local fieldName = field["name"]!field["title"]>
    <#if fieldIndex != 0>
${''?left_pad(indent)}  },{
    </#if>
${''?left_pad(indent)}    title: '${field["title"]!''}',
${''?left_pad(indent)}    name: '${fieldName!''}',
    <#local fieldIndex = fieldIndex + 1>
  </#list>
${''?left_pad(indent)}  }],
${''?left_pad(indent)}  convert: data => {
${''?left_pad(indent)}    return data;
${''?left_pad(indent)}  },
${''?left_pad(indent)}});
${''?left_pad(indent)}this.readonly${js.nameType(widget.variable!'todo')}.render(this.widget${js.nameType(widget.variable!'todo')});
</#macro>

<#macro print_js_methods_readonlyform page widget indent>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 执行【${page.title}】已有数据的读取操作。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.read${js.nameType(widget.variable)} = async function () {
  <#local rootWrapper = widget.rootWrapper>
  <#local rootObj = rootWrapper.object>
  <#local rootObjId = modelbase.get_id_attributes(rootObj)[0]>
${""?left_pad(indent)}  let data = await xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/find',
${""?left_pad(indent)}    params: {
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(rootObjId)}: this.${modelbase.get_attribute_sql_name(rootObjId)},
${""?left_pad(indent)}      '_left_join': `
<@modelbase.print_sql_left_join rootWrapper=rootWrapper indent=indent+8 />
${""?left_pad(indent)}      `,
  <#list rootWrapper.children as childWrapper>
    <#local childObj = childWrapper.object>
    <#if childObj.getLabelledOptions("persistence")["array"] != "true"><#continue></#if>
${""?left_pad(indent)}      '<<${childObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(childObj)}/${childObj.name}/find': {
${""?left_pad(indent)}        _source_field: '${modelbase.get_attribute_sql_name(rootObjId)}',
      <#local refAttrs = modelbase.get_reference_attributes(childObj)>
      <#local directAttr = modelbase.get_direct_attribute(childObj, rootObj)>
      <#if refAttrs.refid??>
${""?left_pad(indent)}        _target_field: '${modelbase.get_attribute_sql_name(refAttrs.refid)}',
${""?left_pad(indent)}        _prefix_name: '${js.nameVariable(refAttrs.name)}',
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(refAttrs.reftype)}: '${rootObj.getLabelledOptions("name")["schema"]?upper_case}.${modelbase.get_object_module(rootObj)?upper_case}/${rootObj.name?upper_case}',
      <#elseif directAttr.attr??>
${""?left_pad(indent)}        _target_field: '${modelbase.get_attribute_sql_name(directAttr.attr)}',
${""?left_pad(indent)}        _prefix_name: '${js.nameVariable(directAttr.attr.name)}',
      </#if>
${""?left_pad(indent)}      },
  </#list>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  });
${""?left_pad(indent)}  if (data.length > 0) {
${""?left_pad(indent)}    this.form${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])}, data[0]);
${""?left_pad(indent)}  }
${""?left_pad(indent)}};
${""?left_pad(indent)}
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### PAGINATION_TABLE
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_paginationtable widget indent>
  <#if !widget.model??><#return></#if>
  <#local managedObject = widget.managedObject!{}>
  <#local columns = widget.model.columns![]>
  <#local request = widget.model.request!{}>
  <#local rootObj = widget.rootWrapper.object>
  <#local rootObjId = modelbase.get_id_attributes(widget.rootWrapper.object)[0]>
  <#-- 显示列组 -->
  <#local displayColumns = []>
  <#-- 参数列组 -->
  <#local paramColumns = []>
  <#list columns as column>
    <#if column.input == "parameter">
      <#local paramColumns = paramColumns + [column]>
    <#else>
      <#local displayColumns = displayColumns + [column]>
    </#if>
  </#list>
  <#local columnIndex = 0>
<#--
### 在【模型】设置中，定义列表传入参数，牛逼
-->
  <#list paramColumns as paramColumn>
${''?left_pad(indent)}let params${js.nameType(paramColumn["name"])} = this.params.${js.nameVariable(paramColumn["name"])} || '0';
  </#list>
${''?left_pad(indent)}this.table${js.nameType(widget["variable"])} = new PaginationTable({
  <#if widget.rootWrapper??>
${''?left_pad(indent)}  url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/paginate',
  </#if>
${''?left_pad(indent)}  params: {
  <#if widget.rootWrapper?? && widget.rootWrapper.children?size != 0>
${''?left_pad(indent)}    '_other_select': `
<@modelbase.print_sql_select rootWrapper=widget.rootWrapper columns=columns indent=indent+6 />
${''?left_pad(indent)}    `,
${''?left_pad(indent)}    '_left_join': `
<@modelbase.print_sql_left_join rootWrapper=widget.rootWrapper indent=indent+6 />
${''?left_pad(indent)}    `,
    <#-- ⭐️⭐️⭐️
     ### 根据参数列定义来构造查询
     ###
     ### 在【模型】设置中，定义列表传入参数，牛逼
     -->
${''?left_pad(indent)}    '_and_condition': `
<@modelbase.print_sql_and_condition rootWrapper=widget.rootWrapper paramColumns=paramColumns indent=indent+6 />
${''?left_pad(indent)}    `,
  </#if>
${''?left_pad(indent)}  },
  <#if widget.refreshable?? && widget.refreshable == false>
${''?left_pad(indent)}  refreshable: false,
  </#if>
  <#if widget.paginatable?? && widget.paginatable == false>
${''?left_pad(indent)}  limit: -1,
  </#if>
${''?left_pad(indent)}  columns: [{
  <#list displayColumns as column>
    <#if columnIndex != 0>
${''?left_pad(indent)}  },{
    </#if>
${''?left_pad(indent)}    title: '${(column["title"]!"")?trim}',
${''?left_pad(indent)}    display: (row, td) => {
    <#if column["input"] == "date">
${''?left_pad(indent)}      if (row.${js.nameVariable(column["name"])}) {
${''?left_pad(indent)}        row.${js.nameVariable(column["name"])} = moment(row.${js.nameVariable(column["name"])}).format('YYYY年MM月DD日');
${''?left_pad(indent)}      }
    </#if>
${''?left_pad(indent)}      let el = dom.templatize(`
${''?left_pad(indent)}        <div class="">
    <#if column["name"]??>
      <#if column["name"]?ends_with("_id")>
${''?left_pad(indent)}          <span>{{${js.nameVariable(column["name"]?replace("_id", "_name"))}}}</span>
      <#else>
${''?left_pad(indent)}          <span>{{${js.nameVariable(column["name"])}}}</span>
      </#if>
    </#if>
${''?left_pad(indent)}        </div>
${''?left_pad(indent)}      `, row);
${''?left_pad(indent)}      td.appendChild(el);
${''?left_pad(indent)}    },
    <#local columnIndex = columnIndex + 1>
  </#list>
${''?left_pad(indent)}  },{
${''?left_pad(indent)}    title: '操作',
${''?left_pad(indent)}    display: (row, td, colidx, rowidx) => {
  <#list widget.actions![] as action>
    <#local url = modelbase.get_uri_from_url(action.url)>
    <#local view = modelbase.get_view_from_url(action.url)>
${""?left_pad(indent)}      let ${action.id} = dom.element(`
${""?left_pad(indent)}        <a class="pointer btn-link mx-2 text-info">${action.title}</a>
${""?left_pad(indent)}      `);
${""?left_pad(indent)}      dom.bind(${action.id}, 'click', ev => {
    <#if view == "@">
${""?left_pad(indent)}        this.${action.url?substring(1)}(row);
    <#else>
${""?left_pad(indent)}        this.goto${js.nameType(modelbase.url_to_page_name(url))}(row);
    </#if>
${""?left_pad(indent)}      });
${""?left_pad(indent)}      td.appendChild(${action.id});
  </#list>
  <#if widget.deletable!false>
${''?left_pad(indent)}      let buttonDelete = dom.element(`
${''?left_pad(indent)}        <a class="pointer btn-link mx-2 text-danger">删除</a>
${''?left_pad(indent)}      `);
${''?left_pad(indent)}      dom.bind(buttonDelete, 'click', ev => {
${''?left_pad(indent)}        this.remove${js.nameType(widget.variable)}IfPersisted(ev);
${''?left_pad(indent)}      });
${''?left_pad(indent)}      td.appendChild(buttonDelete);
  </#if>
${''?left_pad(indent)}    },
${''?left_pad(indent)}  }],
  <#local searchableColumns = []>
  <#list columns as column>
    <#if column.searchable == false><#continue></#if>
    <#local searchableColumns = searchableColumns + [column]>
  </#list>
  <#if (searchableColumns?size > 0)>
    <#local columnIndex = 0>
${''?left_pad(indent)}  filter2: {
${''?left_pad(indent)}    fields: [{
    <#list searchableColumns as column>
      <#if columnIndex != 0>
${''?left_pad(indent)}    },{
      </#if>
${''?left_pad(indent)}      title: '${column["title"]!''}',
${''?left_pad(indent)}      name: 'todo',
${''?left_pad(indent)}      input: '${column["input"]!'text'}',
      <#local columnIndex = columnIndex + 1>
    </#list>
${''?left_pad(indent)}    }],
${''?left_pad(indent)}  },
  </#if>
${''?left_pad(indent)}});
${''?left_pad(indent)}this.table${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])});
  <#if page??>
${''?left_pad(indent)}/*!
${''?left_pad(indent)}** 接收数据改变后的消息事件，触发集合
${''?left_pad(indent)}*/
${''?left_pad(indent)}PubSub('${page.applicationName}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/saved').subscribe(data => {
${''?left_pad(indent)}  page${js.nameType(page.name)}.table${js.nameType(widget.variable)}.request();
${''?left_pad(indent)}});
  </#if>
</#macro>

<#macro print_js_methods_paginationtable page widget indent>
  <#local rootObj = widget.rootWrapper.object>
  <#local rootObjIds = modelbase.get_id_attributes(widget.rootWrapper.object)>
  <#local rootObjId = modelbase.get_id_attributes(widget.rootWrapper.object)[0]>
  <#if widget.assemblable!false>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 装配【${modelbase.get_object_label(rootObj)}】参数。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.assembleParams4${js.nameType(widget.variable)} = function () {
${""?left_pad(indent)}  let ret = [];
${""?left_pad(indent)}  let tbody = dom.find('tbody', this.widget${js.nameType(widget.variable)});
${""?left_pad(indent)}  let trs = tbody.querySelectorAll('tr');
${""?left_pad(indent)}  trs.forEach(tr => {
${""?left_pad(indent)}    let ${js.nameVariable(widget.variable)} = dom.model(tr);
${""?left_pad(indent)}    if (utils.isEmpty(${js.nameVariable(widget.variable)})) return;
${""?left_pad(indent)}    ret.push({
<#-- 表格中封装数据，不需要判断字段，直接为空，是否严谨？ -->
<@print_js_params_for_save parents=[] wrapper=widget.rootWrapper fields=[] page=page widget=widget indent=indent+6 />
${""?left_pad(indent)}    });
${""?left_pad(indent)}  });
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 附加【${modelbase.get_object_label(rootObj)}】一行数据。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.appendOrReplaceRow4${js.nameType(widget.variable)} = function (row, index) {
${""?left_pad(indent)}  this.table${js.nameType(widget.variable)}.appendOrReplaceRow(row, index);
${""?left_pad(indent)}};
${""?left_pad(indent)}
  </#if>
  <#if widget.deletable?? && widget.deletable == true>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 删除【${modelbase.get_object_label(rootObj)}】一行数据，考虑到已经持久化的情况。
${""?left_pad(indent)} */
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.remove${js.nameType(widget.variable)}IfPersisted = async function (ev) {
${""?left_pad(indent)}  let tr = dom.ancestor(ev.target, 'tr');
${""?left_pad(indent)}  let row = dom.model(tr);
${""?left_pad(indent)}  dialog.confirm('确定删除此条数据？', async () => {
  <#local rootObjIdAttrs = modelbase.get_id_attributes(rootObj)>
${""?left_pad(indent)}    if (
  <#list rootObjIdAttrs as idAttr>
${""?left_pad(indent)}      row.${modelbase.get_attribute_sql_name((idAttr))} &&
  </#list>
${""?left_pad(indent)}      1 === 1
${""?left_pad(indent)}    ) {
${""?left_pad(indent)}      let res = await xhr.promise({
  <#if rootObjIdAttrs?size == 1>
${""?left_pad(indent)}        url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]?lower_case}/${rootObj.getLabelledOptions("name")["module"]?lower_case}/${rootObj.name}/disable',
  <#else>
${""?left_pad(indent)}        url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]?lower_case}/${rootObj.getLabelledOptions("name")["module"]?lower_case}/${rootObj.name}/remove',
  </#if>
${""?left_pad(indent)}        params: {
  <#list rootObjIdAttrs as idAttr>
${""?left_pad(indent)}          ${modelbase.get_attribute_sql_name(idAttr)}: row.${modelbase.get_attribute_sql_name(idAttr)},
  </#list>
${""?left_pad(indent)}        }
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
${""?left_pad(indent)}    tr.remove();
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
${""?left_pad(indent)}
  </#if>
  <#list widget.actions![] as action>
    <#local url = modelbase.get_uri_from_url(action.url)>
    <#local view = modelbase.get_view_from_url(action.url)>
${''?left_pad(indent)}
${''?left_pad(indent)}/*!
${''?left_pad(indent)}** 某个【${modelbase.get_object_label(rootObj)}】的【${action.title}】操作。
${''?left_pad(indent)}*/
    <#if view == "@">
${''?left_pad(indent)}Page${js.nameType(page.name)}.prototype.${url} = function(model) {
    <#else>
${''?left_pad(indent)}Page${js.nameType(page.name)}.prototype.goto${js.nameType(modelbase.url_to_page_name(url))} = function(model) {
    </#if>
    <#if view == "#">
${""?left_pad(indent)}  ajax.dialog({
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    title: '${action.title}',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
      <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
      </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#elseif view == "%">
${""?left_pad(indent)}  ajax.shade({
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    title: '${action.title}',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
      <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
      </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#elseif view == "" || view == "$">
${""?left_pad(indent)}  ajax.sidebar({
${""?left_pad(indent)}    containerId: this.page,
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    title: '${action.title}',
${""?left_pad(indent)}    showBottom: true,
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
      <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
      </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#else>
${""?left_pad(indent)}  // TODO: IMPLEMENT ${url}
    </#if>
${''?left_pad(indent)}};
  </#list>
  <#if widget.deletable?? && widget.deletable == true>
${''?left_pad(indent)}
${''?left_pad(indent)}/*!
${''?left_pad(indent)}** 某个【${modelbase.get_object_label(rootObj)}】的【删除】操作。
${''?left_pad(indent)}*/
${''?left_pad(indent)}Page${js.nameType(page.name)}.prototype.remove${js.nameType(rootObj.name)} = function(model) {
${""?left_pad(indent)}  dialog.confirm('确定删除此条数据？', async () => {
${""?left_pad(indent)}    let res = await xhr.promise({
${""?left_pad(indent)}      url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/<#if rootObjIds?size == 1>disable<#else>remove</#if>',
${""?left_pad(indent)}      params: {
    <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
    </#list>
${""?left_pad(indent)}      },
${""?left_pad(indent)}    });
${""?left_pad(indent)}    PubSub.publish('${page.applicationName}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/removed', data);
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
  </#if>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### PAGINATION_GRID
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_paginationgrid widget indent>
  <#if !widget.model??><#return></#if>
  <#local widgetModel = widget.model>
  <#local tile = widget.tile!{}>
  <#local rootObj = widget.rootWrapper.object>
  <#local rootObjIds = modelbase.get_id_attributes(rootObj)>
  <#local rootObjId = modelbase.get_id_attributes(rootObj)[0]>
  <#local fields = widgetModel.fields![]>
  <#local hashFields = {}>
  <#list fields as field>
    <#local hashFields = hashFields + {field.input: js.nameVariable(field.fieldName)}>
  </#list>
${''?left_pad(indent)}this.grid${js.nameType(widget.variable)} = new PaginationGrid({
  <#if widget.rootWrapper??>
${''?left_pad(indent)}  url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/paginate',
  </#if>
${''?left_pad(indent)}  params: {
${''?left_pad(indent)}    state: 'E',
  <#if widget.rootWrapper?? && widget.rootWrapper.children?size != 0>
${''?left_pad(indent)}    '_other_select': `
${''?left_pad(indent)}    `,
${''?left_pad(indent)}    '_left_join': `
<@modelbase.print_sql_left_join rootWrapper=widget.rootWrapper indent=indent+6 />
${''?left_pad(indent)}    `,
  </#if>
${''?left_pad(indent)}  },
  <#if widget.refreshable?? && widget.refreshable == false>
${''?left_pad(indent)}  refreshable: false,
  </#if>
  <#if widget.paginatable?? && widget.paginatable == false>
${''?left_pad(indent)}  limit: -1,
  </#if>
${""?left_pad(indent)}  limit: 15,
${""?left_pad(indent)}  colspan: 3,
${""?left_pad(indent)}  favourite: false,
${""?left_pad(indent)}  borderless: true,
${""?left_pad(indent)}  render: (container, row, index) => {
  <#list widgetModel.fields as field>
    <#if field.fieldName?contains(".")>
      <#assign names = field.fieldName?split(".")>
${""?left_pad(indent)}    if (typeof row.${names[0]} === 'string') row.${names[0]} = JSON.parse(row.${names[0]});
      <#if field.input == 'image'>
${""?left_pad(indent)}    row.${js.nameVariable(field.fieldName)} = utils.safeValue(row, '${field.fieldName}.imagePath');
      <#else>
${""?left_pad(indent)}    row.${js.nameVariable(field.fieldName)} = utils.safeValue(row, '${field.fieldName}');
      </#if>
    </#if>
  </#list>
${""?left_pad(indent)}    let el = dom.templatize(`
${""?left_pad(indent)}      <div class="col-md-12">
${""?left_pad(indent)}        <div class="card border" style="min-height: 150px; max-height: 150px;">
${""?left_pad(indent)}          <div class="card-body">
<@modelbase.print_html_format html=tile.html!'<div></div>' indent=indent+10 />
${""?left_pad(indent)}          </div>
${""?left_pad(indent)}          <div class="card-footer d-flex">
${""?left_pad(indent)}            <div class="ml-auto">
  <#list widget.actions![] as action>
${""?left_pad(indent)}              <a widget-id="${action.id}" class="btn-link text-info pointer mx-2">${action.title}</a>
  </#list>
  <#if widget.deletable?? && widget.deletable == true>
${""?left_pad(indent)}              <a widget-id="buttonRemove" class="btn-link text-danger pointer mx-2">删除</a>
  </#if>
${""?left_pad(indent)}            </div>
${""?left_pad(indent)}          </div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    `, row);
  <#list widget.actions![] as action>
    <#local url = modelbase.get_uri_from_url(action.url)>
    <#local view = modelbase.get_view_from_url(action.url)>
${""?left_pad(indent)}    let ${action.id} = dom.find('[widget-id=${action.id}]', el);
${""?left_pad(indent)}    dom.bind(${action.id}, 'click', ev => {
    <#if view == "@">
${""?left_pad(indent)}      this.${action.url?substring(1)}(row);
    <#else>
${""?left_pad(indent)}      this.goto${js.nameType(modelbase.url_to_page_name(url))}(row);
    </#if>
${""?left_pad(indent)}    });
  </#list>
  <#if widget.deletable?? && widget.deletable == true>
${""?left_pad(indent)}    let buttonRemove = dom.find('[widget-id=buttonRemove', el);
${""?left_pad(indent)}    dom.bind(buttonRemove, 'click', ev => {
${""?left_pad(indent)}      this.remove${js.nameType(rootObj.name)}(row);
${""?left_pad(indent)}    });
  </#if>
${""?left_pad(indent)}    container.appendChild(el);
${""?left_pad(indent)}  }
${''?left_pad(indent)}});
${''?left_pad(indent)}this.grid${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
  <#if page??>
${''?left_pad(indent)}
${''?left_pad(indent)}/*!
${''?left_pad(indent)}** 订阅【${modelbase.get_object_label(rootObj)}】的各种事件。
${''?left_pad(indent)}*/
${''?left_pad(indent)}PubSub("${page.applicationName}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/saved").subscribe(data => {
${''?left_pad(indent)}  page${js.nameType(page.name)}.grid${js.nameType(widget.variable)}.request();
${''?left_pad(indent)}});
    <#if widget.deletable?? && widget.deletable == true>
${''?left_pad(indent)}PubSub("${page.applicationName}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/removed").subscribe(data => {
${''?left_pad(indent)}  page${js.nameType(page.name)}.grid${js.nameType(widget.variable)}.request();
${''?left_pad(indent)}});
    </#if>
  </#if>
</#macro>

<#macro print_js_methods_paginationgrid page widget indent>
  <#if !widget.model??><#return></#if>
  <#local widgetModel = widget.model>
  <#local tile = widget.tile!{}>
  <#local rootObj = widget.rootWrapper.object>
  <#local rootObjIds = modelbase.get_id_attributes(rootObj)>
  <#local rootObjId = modelbase.get_id_attributes(rootObj)[0]>
  <#local fields = widgetModel.fields![]>
  <#local hashFields = {}>
  <#list fields as field>
    <#local hashFields = hashFields + {field.input: js.nameVariable(field.fieldName)}>
  </#list>
  <#list widget.actions![] as action>
    <#local url = modelbase.get_uri_from_url(action.url)>
    <#local view = modelbase.get_view_from_url(action.url)>
${''?left_pad(indent)}
${''?left_pad(indent)}/*!
${''?left_pad(indent)}** 某个【${modelbase.get_object_label(rootObj)}】的【${action.title}】操作。
${''?left_pad(indent)}*/
    <#if view == "@">
${''?left_pad(indent)}Page${js.nameType(page.name)}.prototype.${url} = function(model) {
    <#else>
${''?left_pad(indent)}Page${js.nameType(page.name)}.prototype.goto${js.nameType(modelbase.url_to_page_name(url))} = function(model) {
    </#if>
    <#if view == "#">
${""?left_pad(indent)}  ajax.dialog({
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    title: '${action.title}',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
      <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
      </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#elseif view == "%">
${""?left_pad(indent)}  ajax.shade({
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    title: '${action.title}',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
      <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
      </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#elseif view == "" || view == "$">
${""?left_pad(indent)}  ajax.sidebar({
${""?left_pad(indent)}    containerId: this.page,
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    title: '${action.title}',
${""?left_pad(indent)}    showBottom: true,
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
      <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
      </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#else>
${""?left_pad(indent)}  // TODO: IMPLEMENT ${url}
    </#if>
${''?left_pad(indent)}};
  </#list>
  <#if widget.deletable?? && widget.deletable == true>
${''?left_pad(indent)}
${''?left_pad(indent)}/*!
${''?left_pad(indent)}** 某个【${modelbase.get_object_label(rootObj)}】的【删除】操作。
${''?left_pad(indent)}*/
${''?left_pad(indent)}Page${js.nameType(page.name)}.prototype.remove${js.nameType(rootObj.name)} = function(model) {
${""?left_pad(indent)}  dialog.confirm('确定删除此条数据？', async () => {
${""?left_pad(indent)}    let res = await xhr.promise({
${""?left_pad(indent)}      url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/<#if rootObjIds?size == 1>disable<#else>remove</#if>',
${""?left_pad(indent)}      params: {
    <#list rootObjIds as attrId>
${""?left_pad(indent)}        ${modelbase.get_attribute_sql_name(attrId)}: model.${modelbase.get_attribute_sql_name(attrId)},
    </#list>
${""?left_pad(indent)}      },
${""?left_pad(indent)}    });
${""?left_pad(indent)}    PubSub.publish('${page.applicationName}/${modelbase.get_object_module(rootObj)}/${rootObj.name}/removed', res);
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
  </#if>
</#macro>


<#------------------------------------------------------------------------------
 ###
 ### LIST_VIEW
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_listview widget indent>
  <#if !widget.model??><#return></#if>
<#if widget.height??>
  <#if widget.height == "auto">
${""?left_pad(indent)}dom.autoheight(this.widget${js.nameType(widget["variable"])});
  <#else>
${""?left_pad(indent)}this.widget${js.nameType(widget["variable"])}.style.setProperty('height', '${widget.height}', 'important');
  </#if>
</#if>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 渲染【${widget.variable}】列表。
${""?left_pad(indent)}*/
${''?left_pad(indent)}this.render${js.nameType(widget.variable)}(params);

</#macro>

<#macro print_js_methods_listview page widget indent>
  <#if !widget.model??><#return></#if>
  <#local widgetModel = widget.model>
  <#local tile = widget.tile!{}>
  <#local rootObj = widget.rootWrapper.object>
  <#local rootObjId = modelbase.get_id_attributes(rootObj)[0]>
  <#local fields = widgetModel.fields![]>
  <#local hashFields = {}>
  <#list fields as field>
    <#local hashFields = hashFields + {field.input: js.nameVariable(field.fieldName)}>
  </#list>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 渲染【${widget.variable}】列表。
${""?left_pad(indent)} */
  <#if page.name == "">
${''?left_pad(indent)}this.render${js.nameType(widget.variable)} = async function (params) {
  <#else>
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.render${js.nameType(widget.variable)} = async function (params) {
  </#if>
${''?left_pad(indent)}  /*!
${''?left_pad(indent)}  **【${widget["variable"]}】列表组件的数据载体。
${''?left_pad(indent)}  */
${''?left_pad(indent)}  let items${js.nameType(widget["variable"])} = [];
  <#if widget.checkable?? && widget.checkable == true>
${''?left_pad(indent)}
${''?left_pad(indent)}  /*!
${''?left_pad(indent)}  **【${widget["variable"]}】列表组件中已选的数据载体。
${''?left_pad(indent)}  */
${''?left_pad(indent)}  this.checked${js.nameType(widget["variable"]!'todo')} = {};
  </#if>
${''?left_pad(indent)}  /*!
${''?left_pad(indent)}  ** TODO: 检查远程服务的路径和参数。
${''?left_pad(indent)}  */
${''?left_pad(indent)}  items${js.nameType(widget["variable"]!'todo')} = await xhr.promise({
  <#if rootObj.getLabelledOptions("name")["module"] != "unset">
${''?left_pad(indent)}    url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]?lower_case}/${rootObj.getLabelledOptions("name")["module"]?lower_case}/${rootObj.name}/find',
  <#else>
${''?left_pad(indent)}    url: '/api/v3/common/script/mock/common/listview',
  </#if>
${''?left_pad(indent)}    params: {
${""?left_pad(indent)}      state: 'E',
${''?left_pad(indent)}    },
${''?left_pad(indent)}  });
${''?left_pad(indent)}  this.list${js.nameType(widget["variable"]!'todo')} = new ListView({
${''?left_pad(indent)}    local: items${js.nameType(widget["variable"]!'todo')},
  <#if widget.searchable?? && widget.searchable == true>
${''?left_pad(indent)}    onFilter: (ul, text) => {
${''?left_pad(indent)}    },
  </#if>
  <#if widget.checkable?? && widget.checkable == true>
${''?left_pad(indent)}    onCheck: (checked, model, checkbox) => {
${''?left_pad(indent)}      if (checked === true) {
${''?left_pad(indent)}        this.checked${js.nameType(widget["variable"])}[model.${modelbase.get_attribute_sql_name(rootObjId)}] = model;
${''?left_pad(indent)}      } else {
${''?left_pad(indent)}        this.checked${js.nameType(widget["variable"])}[model.${modelbase.get_attribute_sql_name(rootObjId)}];
${''?left_pad(indent)}      }
${''?left_pad(indent)}    },
  </#if>
${''?left_pad(indent)}    create: (idx, row) => {
${''?left_pad(indent)}      let ret = dom.templatize(`
<@modelbase.print_html_format html=tile.html!'<div></div>' indent=indent+8 />
${''?left_pad(indent)}      `, row);
${''?left_pad(indent)}      return ret;
${''?left_pad(indent)}    },
${''?left_pad(indent)}  });
${''?left_pad(indent)}  this.list${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])});
${""?left_pad(indent)}};
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### TIMELINE
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_timeline widget indent>
  <#if !widget.model??><#return></#if>
${""?left_pad(indent)}this.render${js.nameType(widget.variable)}(params);
</#macro>

<#macro print_js_methods_timeline page widget indent>
  <#if !widget.model??><#return></#if>
  <#local widgetModel = widget.model>
  <#local tile = widget.tile!{}>
  <#local rootObj = widget.rootWrapper.object>
  <#local rootObjId = modelbase.get_id_attributes(rootObj)[0]>
  <#local fields = widgetModel.fields![]>
  <#local hashFields = {}>
  <#list fields as field>
    <#local hashFields = hashFields + {field.input: js.nameVariable(field.fieldName)}>
  </#list>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 渲染【${widget.variable}】时间线。
${""?left_pad(indent)} */
  <#if page.name == "">
${''?left_pad(indent)}this.render${js.nameType(widget.variable)} = async function (params) {
  <#else>
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.render${js.nameType(widget.variable)} = async function (params) {
  </#if>
${''?left_pad(indent)}  /*!
${''?left_pad(indent)}  **【${widget["variable"]}】列表组件的数据载体。
${''?left_pad(indent)}  */
${''?left_pad(indent)}  let items${js.nameType(widget["variable"])} = [];
  <#if widget.checkable?? && widget.checkable == true>
${''?left_pad(indent)}
${''?left_pad(indent)}  /*!
${''?left_pad(indent)}  **【${widget["variable"]}】列表组件中已选的数据载体。
${''?left_pad(indent)}  */
${''?left_pad(indent)}  this.checked${js.nameType(widget["variable"]!'todo')} = {};
  </#if>
${''?left_pad(indent)}  /*!
${''?left_pad(indent)}  ** TODO: 检查远程服务的路径和参数。
${''?left_pad(indent)}  */
${''?left_pad(indent)}  items${js.nameType(widget["variable"])} = await xhr.promise({
  <#if rootObj.getLabelledOptions("name")["module"] != "unset">
${''?left_pad(indent)}    url: '/api/v3/common/script/${rootObj.getLabelledOptions("name")["schema"]?lower_case}/${rootObj.getLabelledOptions("name")["module"]?lower_case}/${rootObj.name}/find',
  <#else>
${''?left_pad(indent)}    url: '/api/v3/common/script/mock/common/listview',
  </#if>
${''?left_pad(indent)}    params: {
${''?left_pad(indent)}    },
${''?left_pad(indent)}  });
${''?left_pad(indent)}  ${''?left_pad(indent)}this.timeline${js.nameType(widget.variable)} = new Timeline({
${''?left_pad(indent)}    data: items${js.nameType(widget["variable"])},
${''?left_pad(indent)}    title: (row) => {
${''?left_pad(indent)}      let ret = dom.templatize(`
${''?left_pad(indent)}        <strong>{{title}}</strong>
${''?left_pad(indent)}      `, row);
${''?left_pad(indent)}      return ret;
${''?left_pad(indent)}    },
${''?left_pad(indent)}    subtitle: (row) => {
${''?left_pad(indent)}      let ret = dom.templatize(`
${''?left_pad(indent)}        <span>{{subtitle}}</span>
${''?left_pad(indent)}      `, row);
${''?left_pad(indent)}      return ret;
${''?left_pad(indent)}    },
${''?left_pad(indent)}    content: (row) => {
${''?left_pad(indent)}      let ret = dom.templatize(`
${''?left_pad(indent)}        <div>{{{content}}}</div>
${''?left_pad(indent)}      `, row);
${''?left_pad(indent)}      return ret;
${''?left_pad(indent)}    },
${''?left_pad(indent)}  });
${''?left_pad(indent)}  this.timeline${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
${""?left_pad(indent)}};
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### TABS
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_tabs widget indent>
${''?left_pad(indent)}this.tabs${js.nameType(widget["variable"])} = new Tabs({
${''?left_pad(indent)}  lazy: true,
${''?left_pad(indent)}  autoClear: true,
${''?left_pad(indent)}  tabActiveClass: 'active-bg-info',
${''?left_pad(indent)}  navigatorId: '[widget-id=widgetNavigator${js.nameType(widget["variable"])}]',
${''?left_pad(indent)}  contentId: '[widget-id=widgetContent${js.nameType(widget["variable"])}]',
  <#if widget.items?? && widget.items?size == 0>
${''?left_pad(indent)}  tabs: [],
  <#else>
${''?left_pad(indent)}  tabs: [{
    <#list widget.items![] as item>
      <#if item?index != 0>
${''?left_pad(indent)}  }, {
      </#if>
${''?left_pad(indent)}    id: '${item.id!'TODO'}',
${''?left_pad(indent)}    text: '${item.title!'TODO'}',
<#--${''?left_pad(indent)}    onClicked: ev => {-->
<#--${''?left_pad(indent)}      this.click${js.nameType(item.id)}(ev);-->
<#--${''?left_pad(indent)}    },-->
${''?left_pad(indent)}    url: '${item.url!'TODO'}',
    </#list>
${''?left_pad(indent)}  }],
  </#if>
${''?left_pad(indent)}});
${''?left_pad(indent)}this.tabs${js.nameType(widget["variable"])}.render();
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### CALENDAR
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_calendar widget indent>
  <#if widget.draggableVariable?? && widget.draggableVariable != "">
${""?left_pad(indent)}new FullCalendar.Draggable(this.widget${js.nameType(widget.draggableVariable)}, {
${""?left_pad(indent)}  itemSelector: 'li',
${""?left_pad(indent)}  eventData: function(eventEl) {
${""?left_pad(indent)}    return {
${""?left_pad(indent)}      title: eventEl.innerText,
${""?left_pad(indent)}      type: eventEl.innerText,
${""?left_pad(indent)}    };
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
  </#if>
${""?left_pad(indent)}let events = [];
${""?left_pad(indent)}let now${js.nameType(widget["variable"])} = moment().format('YYYY-MM-DD');
${""?left_pad(indent)}this.calendar${js.nameType(widget["variable"])} = new FullCalendar.Calendar(this.widget${js.nameType(widget["variable"])}, {
${""?left_pad(indent)}  locale: 'zh',
${""?left_pad(indent)}  slotMinTime: '08:00',
${""?left_pad(indent)}  slotMaxTime: '20:00',
${""?left_pad(indent)}  slotDuration: '00:10:00',
${""?left_pad(indent)}  slotLabelInterval: 10,
${""?left_pad(indent)}  slotMinutes: 10,
${""?left_pad(indent)}  headerToolbar: {
${""?left_pad(indent)}    center: 'title',
${""?left_pad(indent)}    left: '',
${""?left_pad(indent)}    right: 'prev,next today',
${""?left_pad(indent)}  },
${""?left_pad(indent)}  initialView: 'timeGridWeek',
${""?left_pad(indent)}  initialDate: now${js.nameType(widget["variable"])},
${""?left_pad(indent)}  editable: true,
${""?left_pad(indent)}  allDaySlot: false,
${""?left_pad(indent)}  nowIndicator: true,
${""?left_pad(indent)}  events: events,
${""?left_pad(indent)}});
${""?left_pad(indent)}this.calendar${js.nameType(widget["variable"])}.render();
<#if widget.height??>
  <#if widget.height == "auto">
${""?left_pad(indent)}// 先渲染日历，再调整高度
${""?left_pad(indent)}dom.autoheight(this.widget${js.nameType(widget["variable"])});
  <#else>
${""?left_pad(indent)}this.widget${js.nameType(widget["variable"])}.style.setProperty('height', '${widget.height}', 'important');
  </#if>
</#if>
</#macro>

<#macro print_js_methods_calendar page widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 从日历中装配数据。
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.assembleEvents4${js.nameType(widget.variable)} = function () {
${""?left_pad(indent)}  let events = this.calendar${js.nameType(widget.variable)}.getEvents();
${""?left_pad(indent)}  let ret = [];
${""?left_pad(indent)}  for (let i = 0; i < events.length; i++) {
${""?left_pad(indent)}    let event = events[i];
${""?left_pad(indent)}    event._def.extendedProps = event.extendedProps || {};
${""?left_pad(indent)}    let row = {...event.extendedProps};
${""?left_pad(indent)}    row.start = event._instance.range.start;
${""?left_pad(indent)}    row.end = event._instance.range.end;
${""?left_pad(indent)}    ret.push(row);
${""?left_pad(indent)}  }
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载日历的数据。
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.loadEvents4${js.nameType(widget.variable)} = async function () {
${""?left_pad(indent)}  return [];
${""?left_pad(indent)}};
</#macro>

<#macro print_js_declare_richtext widget indent>
${""?left_pad(indent)}let size = Quill.import('attributors/style/size');
${""?left_pad(indent)}size.whitelist = ['14px', '16px', '18px', '20px', '22px', '24px'];
${""?left_pad(indent)}Quill.register(size, true);
${""?left_pad(indent)}this.quill = new Quill(this.widgetContentArticle, {
${""?left_pad(indent)}  modules: {
${""?left_pad(indent)}    toolbar: [
${""?left_pad(indent)}      ['bold', 'italic', 'underline', 'strike'],
${""?left_pad(indent)}      [{'header': [1, 2, 3, 4, 5, 6, false]}],
${""?left_pad(indent)}      [{'color': []}, {'background': []}],
${""?left_pad(indent)}      [{'font': []}],
${""?left_pad(indent)}      [{'size': size.whitelist}],
${""?left_pad(indent)}      ['link', 'image'],
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  },
${""?left_pad(indent)}  theme: 'snow'
${""?left_pad(indent)}});
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### TITLE_BAR
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_titlebar widget indent>
  <#list widget.actions![] as action>
    <#local url = modelbase.get_uri_from_url(action.url)>
    <#local view = modelbase.get_view_from_url(action.url)>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 响应【${action.title!'TODO'}】按钮点击。
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${action.id}, 'click', ev => {
    <#if view == "@">
${""?left_pad(indent)}  this.${url}(ev);
    <#elseif view == "#">
${""?left_pad(indent)}  ajax.dialog({
${""?left_pad(indent)}    title: '${action.title!'TODO'}',
${""?left_pad(indent)}    width: '600px',
${""?left_pad(indent)}    height: '400px',
${""?left_pad(indent)}    shadeClose: false,
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
${""?left_pad(indent)}        onSave: data => {
${""?left_pad(indent)}          if (Array.isArray(data)) {
${""?left_pad(indent)}            for (let i = 0; i < data.length; i++) {
${""?left_pad(indent)}              this.appendOrReplaceRow4${js.nameType(action.variable)}(data);
${""?left_pad(indent)}            }
${""?left_pad(indent)}          } else {
${""?left_pad(indent)}            this.appendOrReplaceRow4${js.nameType(action.variable)}(data);
${""?left_pad(indent)}          }
${""?left_pad(indent)}        },
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#else>
${""?left_pad(indent)}  ajax.sidebar({
${""?left_pad(indent)}    containerId: this.page,
${""?left_pad(indent)}    title: '${action.title!'TODO'}',
${""?left_pad(indent)}    showBottom: true,
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({});
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    </#if>
${""?left_pad(indent)}});
  </#list>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### TITLE_BAR
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_separator widget indent>
  <#list widget.actions![] as action>
    <#local url = modelbase.get_uri_from_url(action.url)>
    <#local view = modelbase.get_view_from_url(action.url)>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 响应【${action.title!'TODO'}】按钮点击。
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${action.id}, 'click', ev => {
    <#if view == "@">
${""?left_pad(indent)}  this.${url}(ev);
    <#elseif view == "#">
${""?left_pad(indent)}  ajax.dialog({
${""?left_pad(indent)}    title: '${action.title!'TODO'}',
${""?left_pad(indent)}    width: '600px',
${""?left_pad(indent)}    height: '400px',
${""?left_pad(indent)}    shadeClose: false,
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show({
${""?left_pad(indent)}        onSave: data => {
${""?left_pad(indent)}          if (Array.isArray(data)) {
${""?left_pad(indent)}            for (let i = 0; i < data.length; i++) {
${""?left_pad(indent)}              this.appendOrReplaceRow4${js.nameType(action.variable)}(data);
${""?left_pad(indent)}            }
${""?left_pad(indent)}          } else {
${""?left_pad(indent)}            this.appendOrReplaceRow4${js.nameType(action.variable)}(data);
${""?left_pad(indent)}          }
${""?left_pad(indent)}        },
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    <#else>
${""?left_pad(indent)}  ajax.sidebar({
${""?left_pad(indent)}    containerId: this.page,
${""?left_pad(indent)}    title: '${action.title!'TODO'}',
${""?left_pad(indent)}    showBottom: true,
${""?left_pad(indent)}    url: 'html/${url}.html',
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      page${js.nameType(modelbase.url_to_page_name(action.url))}.show();
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
    </#if>
${""?left_pad(indent)}});
  </#list>
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### AOW
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_AOW widget indent>
${""?left_pad(indent)}dom.init(this, this.page);
${""?left_pad(indent)}dom.autoheight(this.widgetArticle, document.body, 48 /*QUILL CONSTANT*/);
${""?left_pad(indent)}dom.autoheight(this.widgetPreview);
${""?left_pad(indent)}
${""?left_pad(indent)}this.params = params || {};
${""?left_pad(indent)}
${""?left_pad(indent)}while (this.widgetArticle.parentElement.children.length != 1)
${""?left_pad(indent)}  this.widgetArticle.parentElement.children[0].remove();
${""?left_pad(indent)}this.widgetArticle.innerHTML = '';
${""?left_pad(indent)}this.widgetPreview.innerHTML = '';
${""?left_pad(indent)}
${""?left_pad(indent)}let size = Quill.import('attributors/style/size');
${""?left_pad(indent)}size.whitelist = ['14px', '16px', '18px', '20px', '22px', '24px'];
${""?left_pad(indent)}Quill.register(size, true);
${""?left_pad(indent)}this.quill = new Quill(this.widgetArticle, {
${""?left_pad(indent)}  modules: {
${""?left_pad(indent)}    toolbar: [
${""?left_pad(indent)}      ['save'],
${""?left_pad(indent)}      ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
${""?left_pad(indent)}      [{'header': [1, 2, 3, 4, 5, 6, false]}],
${""?left_pad(indent)}      [{'color': []}, {'background': []}],          // dropdown with defaults from theme
${""?left_pad(indent)}      [{'font': []}],
${""?left_pad(indent)}      [{'size': []}],
${""?left_pad(indent)}      ['link', 'image'],
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  },
${""?left_pad(indent)}  theme: 'snow'
${""?left_pad(indent)}});
${""?left_pad(indent)}let buttonSave = this.widgetArticle.parentElement.querySelector('button.ql-save');
${""?left_pad(indent)}buttonSave.innerText = '保存';
${""?left_pad(indent)}buttonSave.style.position = 'relative';
${""?left_pad(indent)}buttonSave.style.width = '48px';
${""?left_pad(indent)}buttonSave.style.top = '-2px';
${""?left_pad(indent)}dom.bind(buttonSave, 'click', ev => {
${""?left_pad(indent)}  this.saveContent();
${""?left_pad(indent)}});
${""?left_pad(indent)}this.quill.on('text-change', (delta, oldDelta, source) => {
${""?left_pad(indent)}  this.previewContent();
${""?left_pad(indent)}});
${""?left_pad(indent)}
${""?left_pad(indent)}this.previewer = new MobileFrame({
${""?left_pad(indent)}  url: '/html/misc/preview/mobile.html',
${""?left_pad(indent)}});
${""?left_pad(indent)}this.previewer.render(this.widgetPreview);
${""?left_pad(indent)}
${""?left_pad(indent)}this.readContent();
</#macro>

<#macro print_js_methods_AOW page widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.previewContent = function () {
${""?left_pad(indent)}  clearTimeout(this.delayToRender);
${""?left_pad(indent)}  this.delayToRender = setTimeout(() => {
${""?left_pad(indent)}    this.previewer.preview(this.quill.root.innerHTML);
${""?left_pad(indent)}  }, 1000)
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.readContent = function () {
${""?left_pad(indent)}  if (!this.params.articleId) return;
${""?left_pad(indent)}  xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/stdbiz/cm/article/read',
${""?left_pad(indent)}    params: {
${""?left_pad(indent)}      articleId: this.params.articleId,
${""?left_pad(indent)}      modifierId: window.user.userId,
${""?left_pad(indent)}      modifierType: 'STDBIZ.SAM.USER',
${""?left_pad(indent)}    },
${""?left_pad(indent)}  }).then(res => {
${""?left_pad(indent)}    this.quill.root.innerHTML = res.content;
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.saveContent = function () {
${""?left_pad(indent)}  let params = {
${""?left_pad(indent)}    articleId: this.params.articleId,
${""?left_pad(indent)}    content: this.quill.root.innerHTML,
${""?left_pad(indent)}  };
${""?left_pad(indent)}  xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/stdbiz/cm/article/merge',
${""?left_pad(indent)}    params: {
${""?left_pad(indent)}      ...params,
${""?left_pad(indent)}      modifierId: window.user.userId,
${""?left_pad(indent)}      modifierType: 'STDBIZ.SAM.USER',
${""?left_pad(indent)}    },
${""?left_pad(indent)}  }).then(res => {
${""?left_pad(indent)}    if (res.error && res.error.code == '-1') {
${""?left_pad(indent)}      toast.success(this.page, res.error.message);
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      toast.success(this.page, '内容保存成功！');
${""?left_pad(indent)}    }
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### SURD
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_SURD widget indent>
${""?left_pad(indent)}dom.init(this, this.page);
${""?left_pad(indent)}dom.autoheight(this.widgetDesigner);
${""?left_pad(indent)}dom.autoheight(this.widgetPreview);
${""?left_pad(indent)}
${""?left_pad(indent)}this.params = params || {};
${""?left_pad(indent)}
${""?left_pad(indent)}this.designer = new QuestionnaireDesigner({
${""?left_pad(indent)}  mobileFramePath: '/mobile/index.html',
${""?left_pad(indent)}});
${""?left_pad(indent)}this.designer.render(this.widgetDesigner, {});
${""?left_pad(indent)}this.designer.on('html-changed', ev => {
${""?left_pad(indent)}  this.previewer.preview(ev.detail.html);
${""?left_pad(indent)}})
${""?left_pad(indent)}
${""?left_pad(indent)}this.previewer = new MobileFrame({
${""?left_pad(indent)}  url: '/html/misc/preview/mobile.html',
${""?left_pad(indent)}});
${""?left_pad(indent)}this.previewer.render(this.widgetPreview);
${""?left_pad(indent)}
${""?left_pad(indent)}let buttons = dom.element(`
${""?left_pad(indent)}  <div widget-id="widgetElement" class="position-absolute" style="width: 64px; top: 280px; left: 60px;">
${""?left_pad(indent)}    <a class="btn btn-link pointer text-info d-flex align-items-center justify-content-center"
${""?left_pad(indent)}       widget-id="buttonSave"
${""?left_pad(indent)}       style="width: 64px; height: 64px;
${""?left_pad(indent)}          border-top: 1px solid;
${""?left_pad(indent)}          border-left: 1px solid;
${""?left_pad(indent)}          border-right: 1px solid;
${""?left_pad(indent)}          border-bottom: 1px solid;
${""?left_pad(indent)}          border-radius: unset;">
${""?left_pad(indent)}      <i class="fas fa-save font-36"></i>
${""?left_pad(indent)}    </a>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}`);
${""?left_pad(indent)}let buttonSave = dom.find('[widget-id=buttonSave]', buttons);
${""?left_pad(indent)}dom.bind(buttonSave, 'click', ev => {
${""?left_pad(indent)}  this.saveContent();
${""?left_pad(indent)}});
${""?left_pad(indent)}
${""?left_pad(indent)}this.page.appendChild(buttons);
${""?left_pad(indent)}
${""?left_pad(indent)}this.readContent();
</#macro>

<#macro print_js_methods_SURD page widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.saveContent = async function () {
${""?left_pad(indent)}  let widgetQuestionnaireCanvas = dom.find('[widget-id=widgetQuestionnaireCanvas]', this.widgetDesigner);
${""?left_pad(indent)}  let questions = [];
${""?left_pad(indent)}  for (let i = 0; i < widgetQuestionnaireCanvas.children.length; i++) {
${""?left_pad(indent)}    let el = widgetQuestionnaireCanvas.children[i];
${""?left_pad(indent)}    let questionId = el.getAttribute('data-questionnaire-question-id');
${""?left_pad(indent)}    let model = JSON.parse(el.getAttribute('data-questionnaire-question-model'));
${""?left_pad(indent)}    let values = model.values;
${""?left_pad(indent)}    let scores = model.scores || [];
${""?left_pad(indent)}    let options = [];
${""?left_pad(indent)}    for (let j = 0; j < values.length; j++) {
${""?left_pad(indent)}      options.push({
${""?left_pad(indent)}        questionnaireId: '${r"${"}questionnaire.questionnaireId${r"}"}',
${""?left_pad(indent)}        questionnaireQuestionId: '${r"${"}questionnaireQuestion.questionnaireQuestionId${r"}"}',
${""?left_pad(indent)}        questionnaireQuestionOptionName: values[j],
${""?left_pad(indent)}        score: parseFloat(scores[j]) || 0,
${""?left_pad(indent)}        ordinalPosition: (j + 1),
${""?left_pad(indent)}      });
${""?left_pad(indent)}    }
${""?left_pad(indent)}    questions.push({
${""?left_pad(indent)}      questionnaireId: '${r"${"}questionnaire.questionnaireId${r"}"}',
${""?left_pad(indent)}      questionnaireQuestionId: questionId,
${""?left_pad(indent)}      questionnaireQuestionName: model.title,
${""?left_pad(indent)}      questionnaireQuestionType: model.type,
${""?left_pad(indent)}      ordinalPosition: (i + 1),
${""?left_pad(indent)}      _result_name: 'questionnaireQuestion',
${""?left_pad(indent)}      '||stdbiz/cm/questionnaire_question_option/batch': {
${""?left_pad(indent)}        _clear_value: `and questqnopt.questqnid = '${r"${"}questionId${r"}"}'`,
${""?left_pad(indent)}        questionnaireQuestionOptions: options,
${""?left_pad(indent)}      },
${""?left_pad(indent)}    });
${""?left_pad(indent)}  }
${""?left_pad(indent)}
${""?left_pad(indent)}  let params = {
${""?left_pad(indent)}    questionnaireId: this.params.questionnaireId,
${""?left_pad(indent)}    _result_name: 'questionnaire',
${""?left_pad(indent)}    '||stdbiz/cm/questionnaire_question/batch': {
${""?left_pad(indent)}      questionnaireQuestions: questions,
${""?left_pad(indent)}    },
${""?left_pad(indent)}  };
${""?left_pad(indent)}
${""?left_pad(indent)}  xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/stdbiz/cm/questionnaire/merge',
${""?left_pad(indent)}    params: {
${""?left_pad(indent)}      ...params,
${""?left_pad(indent)}      modifierId: window.user.userId,
${""?left_pad(indent)}      modifierType: 'STDBIZ.SAM.USER',
${""?left_pad(indent)}    },
${""?left_pad(indent)}  }).then(res => {
${""?left_pad(indent)}    if (res.error && res.error.code == '-1') {
${""?left_pad(indent)}      toast.success(this.page, res.error.message);
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      toast.success(this.page, '内容保存成功！');
${""?left_pad(indent)}    }
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.readContent = async function () {
${""?left_pad(indent)}  if (!this.params.questionnaireId) return;
${""?left_pad(indent)}  xhr.promise({
${""?left_pad(indent)}    url: '/api/v3/common/script/stdbiz/cm/questionnaire_question/find',
${""?left_pad(indent)}    params: {
${""?left_pad(indent)}      questionnaireId: this.params.questionnaireId,
${""?left_pad(indent)}      _order_by: 'questqn.ordpos asc',
${""?left_pad(indent)}      '//stdbiz/cm/questionnaire_question_option/find': {
${""?left_pad(indent)}        questionnaireId: this.params.questionnaireId,
${""?left_pad(indent)}        _order_by: 'questqnopt.ordpos asc',
${""?left_pad(indent)}        _source_field: 'questionnaireQuestionId',
${""?left_pad(indent)}        _target_field: 'questionnaireQuestionId',
${""?left_pad(indent)}        _hierarchy_name: 'options',
${""?left_pad(indent)}      },
${""?left_pad(indent)}    },
${""?left_pad(indent)}  }).then(res => {
${""?left_pad(indent)}    let qns = [];
${""?left_pad(indent)}    for (let i = 0; i < res.length; i++) {
${""?left_pad(indent)}      let values = [];
${""?left_pad(indent)}      for (let j = 0; j < res[i].options.length; j++) {
${""?left_pad(indent)}        values.push(res[i].options[j].questionnaireQuestionOptionName);
${""?left_pad(indent)}      }
${""?left_pad(indent)}      qns.push({
${""?left_pad(indent)}        id: res[i].questionnaireQuestionId,
${""?left_pad(indent)}        title: res[i].questionnaireQuestionName,
${""?left_pad(indent)}        type: res[i].questionnaireQuestionType,
${""?left_pad(indent)}        ordinalPosition: res[i].ordinalPosition,
${""?left_pad(indent)}        values: values,
${""?left_pad(indent)}      });
${""?left_pad(indent)}    }
${""?left_pad(indent)}    this.designer.renderQuestions(qns);
${""?left_pad(indent)}    let widgetQuestionnaireCanvas = dom.find('[widget-id=widgetQuestionnaireCanvas]', this.widgetDesigner);
${""?left_pad(indent)}    this.previewer.preview(widgetQuestionnaireCanvas.innerHTML);
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### GIM
 ###
 ------------------------------------------------------------------------------>
<#macro print_js_declare_GIM widget indent>
${""?left_pad(indent)}dom.init(this, this.page);
${""?left_pad(indent)}dom.autoheight(this.widgetContacts);
${""?left_pad(indent)}dom.autoheight(this.widgetConversation, document.body, 100);
${""?left_pad(indent)}this.userId = params.userId;
${""?left_pad(indent)}this.userType = params.userType;
${""?left_pad(indent)}gim.init('我是二号', '2', 'TEST', {
${""?left_pad(indent)}  'login': res => {
${""?left_pad(indent)}    console.log(res);
${""?left_pad(indent)}    gim.getConversations();
${""?left_pad(indent)}  },
${""?left_pad(indent)}  'getConversations': res => {
${""?left_pad(indent)}    this.renderWithConversations(res.data);
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}gim.login();
</#macro>

<#macro print_js_methods_GIM page widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.renderWithConversations = function(conversations) {
${""?left_pad(indent)}  for (let i = 0; i < conversations.length; i++) {
${""?left_pad(indent)}    let row = conversations[i];
${""?left_pad(indent)}    row.name = row.alias;
${""?left_pad(indent)}    row.group = row.conversationId;
${""?left_pad(indent)}    row.createTime = moment(row.createTime).format('YYYY-MM-DD HH:mm');
${""?left_pad(indent)}    let convo = dom.templatize(`
${""?left_pad(indent)}      <li data-model-user-id="{{senderId}}"
${""?left_pad(indent)}          data-model-user-type="{{name}}"
${""?left_pad(indent)}          data-model-conversation-id="{{conversationId}}"
${""?left_pad(indent)}          class="list-group-item list-group-item-action pointer d-flex contact border-less radius-less">
${""?left_pad(indent)}        <div>
${""?left_pad(indent)}          <div class="avatar bg-info ml-3">
${""?left_pad(indent)}            <div class="initial font-18 font-weight-bold"
${""?left_pad(indent)}                 style="left: 50%; position: absolute; top: 50%;transform: translate(-50%, -50%);"></div>
${""?left_pad(indent)}          </div>
${""?left_pad(indent)}          <div class="indicator hide" style="left: 45px; bottom: 15px;"></div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}        <div style="margin-left: 15px;">
${""?left_pad(indent)}          <div class="name"><strong style="font-size: 18px;">{{name}}</strong><small class="text-success pl-2">{{lastConversationTime}}</small></div>
${""?left_pad(indent)}          <div class="description">暂时没有消息</div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </li>
${""?left_pad(indent)}    `, row);
${""?left_pad(indent)}    let initial = dom.find('.initial', convo);
${""?left_pad(indent)}    initial.innerText = row.name.substring(0, 1);
${""?left_pad(indent)}    dom.bind(convo, 'click', ev => {
${""?left_pad(indent)}      this.makeConversation(ev);
${""?left_pad(indent)}    });
${""?left_pad(indent)}    this.widgetContacts.appendChild(convo);
${""?left_pad(indent)}  }
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.renderConversation = async function(params) {
${""?left_pad(indent)}  this.widgetConversation.innerHTML = '';
${""?left_pad(indent)}  this.textName.innerHTML = params.userType;
${""?left_pad(indent)}  this.textInitialAvatar.innerText = params.userType.substring(0,1);
${""?left_pad(indent)}  let messages = []; //await this.chat.fetchMessages(params.userId, params.userType, params.status);
${""?left_pad(indent)}  for (let i = 0; i < messages.length; i++) {
${""?left_pad(indent)}    let row = messages[i];
${""?left_pad(indent)}    let time = dom.templatize(`
${""?left_pad(indent)}    <li data-model-time="{{createTime}}" class="d-flex">
${""?left_pad(indent)}      <span class="time m-auto">{{createTime}}</span>
${""?left_pad(indent)}    </li>
${""?left_pad(indent)}  `, row);
${""?left_pad(indent)}    this.widgetConversation.appendChild(time);
${""?left_pad(indent)}    for (let j = 0; j < row.groupingMessages.length; j++) {
${""?left_pad(indent)}      let groupingMessage = row.groupingMessages[j];
${""?left_pad(indent)}      for (let k = 0; k < groupingMessage.messages.length; k++) {
${""?left_pad(indent)}        let msg = groupingMessage.messages[k];
${""?left_pad(indent)}        let direction = msg.senderId === this.selectedContact.userId ? 'incoming' : 'outgoing';
${""?left_pad(indent)}        if (msg.messageType === Chat.MESSAGE_TYPE_IMAGE ||
${""?left_pad(indent)}          msg.messageType === Chat.MESSAGE_TYPE_AUDIO ||
${""?left_pad(indent)}          msg.messageType === Chat.MESSAGE_TYPE_PATIENT) {
${""?left_pad(indent)}          msg.messageContent = JSON.parse(msg.messageContent);
${""?left_pad(indent)}        }
${""?left_pad(indent)}        this.renderMessage(direction, msg);
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  this.widgetConversation.scrollTo(0, this.widgetConversation.scrollHeight);
${""?left_pad(indent)}  this.longtextMessage.removeAttribute('disabled');
${""?left_pad(indent)}};
${""?left_pad(indent)}
${""?left_pad(indent)}Page${js.nameType(page.name)}.prototype.makeConversation = async function(ev) {
${""?left_pad(indent)}  for (let i = 0; i < this.widgetContacts.children.length; i++) {
${""?left_pad(indent)}    let child = this.widgetContacts.children[i];
${""?left_pad(indent)}    child.classList.remove('active');
${""?left_pad(indent)}  }
${""?left_pad(indent)}  let li = dom.ancestor(ev.target, 'li');
${""?left_pad(indent)}  li.classList.add('active');
${""?left_pad(indent)}  let params = dom.model(li);
${""?left_pad(indent)}  this.renderConversation(params).then(async data => {
${""?left_pad(indent)}    // await xhr.promise({
${""?left_pad(indent)}    //   url: '/api/v3/common/script/stdbiz-ex/pim/read_messages',
${""?left_pad(indent)}    //   params: {
${""?left_pad(indent)}    //     conversationId: this.selectedContact.conversationId,
${""?left_pad(indent)}    //   }
${""?left_pad(indent)}    // });
${""?left_pad(indent)}    dom.find('.indicator', li).style.display = 'none';
${""?left_pad(indent)}  });
${""?left_pad(indent)}  this.selectedContact = {
${""?left_pad(indent)}    userId: params.userId,
${""?left_pad(indent)}    userType: params.userType,
${""?left_pad(indent)}    conversationId: params.conversationId,
${""?left_pad(indent)}  };
${""?left_pad(indent)}  this.buttonSend.classList.remove('disabled');
${""?left_pad(indent)}  this.buttonImage.classList.remove('disabled');
${""?left_pad(indent)}  this.buttonRecord.classList.remove('disabled');
${""?left_pad(indent)}  this.buttonPatient.classList.remove('disabled');
${""?left_pad(indent)}};
</#macro>

<#------------------------------------------------------------------------------
 ###
 ### LOGIC RULES
 ###
 ------------------------------------------------------------------------------>
<#function is_attribute_in_fields attr fields>
  <#if fields?size == 0><#return false></#if>
  <#list fields as field>
    <#if field.objectName == attr.parent.name && modelbase.get_attribute_sql_name(attr) == js.nameVariable(field.fieldName)>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#function is_attribute_relative_to_one_of_objects attr wrappers>
  <#list wrappers as wrapper>
    <#if attr.type.name == wrapper.object.name>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#function get_object_relative_to_one_of_objects attr wrappers>
  <#list wrappers as wrapper>
    <#if attr.type.name == wrapper.object.name>
      <#return wrapper.object>
    </#if>
  </#list>
  <#-- never be here -->
</#function>

<#function get_reference_id_by_attribute ownerWrapper parents>
  <#local directs = {}>
  <#list parents as parent>
    <#list ownerWrapper.object.attributes as attr>
      <#if attr.type.name == parent.object.name>
        <#-- 存在直接引用，间接引用就不会是这个parent -->
        <#local directs = directs + {parent.object.name: parent.object}>
      </#if>
    </#list>
  </#list>
  <#list parents as parent>
    <#if !directs[parent.object.name]??>
      <#return modelbase.get_id_attributes(parent.object)[0]>
    </#if>
  </#list>
</#function>

<#function get_reference_type_by_attribute ownerWrapper parents>
  <#local directs = {}>
  <#list parents as parent>
    <#list ownerWrapper.object.attributes as attr>
      <#if attr.type.name == parent.object.name>
        <#-- 存在直接引用，间接引用就不会是这个parent -->
        <#local directs = directs + {parent.object.name: parent.object}>
      </#if>
    </#list>
  </#list>
  <#list parents as parent>
    <#if !directs[parent.object.name]??>
      <#local options = parent.object.getLabelledOptions("name")>
      <#return options["schema"]?upper_case + "." + options["module"]?upper_case + "." + parent.object.name?upper_case>
    </#if>
  </#list>
  <#return "">
</#function>

<#-- ⭐️⭐️⭐️⭐️⭐️
 ###
 ###
 ###
 -->
<#function lookup_template_variable_in_page page widget tplVarAttr wrappers >
  <#local attrSqlName = modelbase.get_attribute_sql_name(tplVarAttr)>
  <#--
   ### 在组件的环境封装对象中能够找到
   -->
  <#list wrappers as wrapper>
    <#list wrapper.object.attributes as attr>
      <#if attrSqlName == modelbase.get_attribute_sql_name(attr)>
        <#if wrapper?index == 0>
          <#return js.nameVariable(widget.variable) + "." + attrSqlName>
        <#else>
          <#return js.nameVariable(wrapper.object.name) + "." + attrSqlName>
        </#if>
      </#if>
    </#list>
  </#list>
  <#--
   ### 在组件的环境封装对象中能够找到
   -->
  <#list page.widgets as pageWidget>
    <#if pageWidget.variable == widget.variable><#continue></#if>
    <#if !widget.rootWrapper??><#continue></#if>
    <#local parents = modelbase.recurse_wrappers_from_wrapper(pageWidget.rootWrapper)>
    <#list parents as wrapper>
      <#local attrIds = modelbase.get_id_attributes(wrapper.object)>
      <#if attrIds?size != 1><#continue></#if>
      <#list attrIds as attr>
        <#if tplVarAttr.equals(attr)><#continue></#if>
        <#if attrSqlName == modelbase.get_attribute_sql_name(attr)>
          <#if wrapper?index == 0>
            <#return js.nameVariable(pageWidget.variable) + "." + attrSqlName>
          <#else>
            <#return js.nameVariable(wrapper.object.name) + "." + attrSqlName>
          </#if>
        </#if>
      </#list>
    </#list>
  </#list>
<#-- never be here -->
  <#return "">
</#function>

<#function name_id_in_params variable attrId>
  <#local attrname = modelbase.get_attribute_sql_name(attrId)>
  <#local varname = js.nameVariable(variable)>
  <#if attrname == (varname + "Id") || attrname == (varname + "Code")>
    <#return attrname>
  </#if>
  <#return varname + attrname?substring(0, 1)?upper_case + attrname?substring(1)>
</#function>

<#--
 ### ⭐️⭐️⭐️⭐️⭐️
 ###
 ### 打印出封装好的保存需要的参数。
 ###
 ### 参数：
 ###
 ### - parents: 遍历过的所有上级【封装对象】
 ###
 ### - wrapper：实际数据对象的封装对象
 ###
 ### - fields: 界面中实际需要的字段，可以为空数组
 ###
 ### - variable: 在实际代码环境中数据持有的变量名称，是个字符串
 ###
 ### - indent: 缩进空格数
 -->
<#macro print_js_params_for_save parents wrapper fields page widget indent >
  <#local variable = js.nameVariable(widget.variable)>
  <#local object = wrapper.object>
  <#if parents?size == 0>
    <#local parent = wrapper>
  <#else>
    <#local parent = parents[parents?size - 1]>
  </#if>
  <#local parentObj = parent.object>
  <#local parentObjIds = modelbase.get_id_attributes(parentObj)>
  <#local parentObjId = parentObjIds[0]>
  <#local rootObj = wrapper.object>
  <#local rootObjIds = modelbase.get_id_attributes(rootObj)>
  <#--
  ### ☀️
  -->
  <#if widget.widgetType == "PaginationTable" && fields?size == 0>
${""?left_pad(indent)}...${js.nameVariable(variable)},
  </#if>
  <#--
   ### ⭐️ 根对象的标识，必须作为保存参数
   -->
  <#if parents?size == 0 && rootObj.getLabelledOptions("persistence")["array"] != "true">
    <#list rootObjIds as attrId>
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attrId)}: this.params.${name_id_in_params(variable, attrId)},
    </#list>
  </#if>
  <#--
   ### 尽可能多并且有效的保存数据，比如A表的子扩展扩展对象B表，如果存在相同的字段
   ### 则在界面上存在这个字段输入的情况下，A表和B表的这一字段都需要保存数据，我们
   ### 称之为【一贯性原则】。
   ###
   ### 用户字段，如果用户字段为空，则说明对象的全部属性都要封装
   -->
  <#list object.attributes as attr>
    <#if modelbase.is_attribute_system(attr)><#-- 过滤掉系统字段 --><#continue></#if>
    <#if modelbase.is_attribute_reference_id(attr, object)>
    <#--
     ### ✅ REFERENCE ID：从所有的上级对象中找一个最合适的
     ###
     ### 首先，和REFERENCE_ID同一张中的其他字段，引用了某个上级对象，则这个上级对象不能作为REFERENCE_ID
     -->
      <#local refId = get_reference_id_by_attribute(wrapper, parents)>
      <#if !refId??><#continue></#if>
      <#local refIdName = modelbase.get_attribute_sql_name(refId)>
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${lookup_template_variable_in_page(page, widget, refId, parents)}${r"}"}',
    <#elseif modelbase.is_attribute_reference_type(attr, object)>
    <#--
     ### REFERENCE TYPE
     -->
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: '${get_reference_type_by_attribute(wrapper, parents)}',
    <#elseif is_attribute_relative_to_one_of_objects(attr, parents)>
    <#--
     ### ✅ &xxxx(id) 某个字段直接关联上级对象
     -->
      <#local relativeObj = get_object_relative_to_one_of_objects(attr, parents)>
      <#local relativeObjId = modelbase.get_id_attributes(relativeObj)[0]>
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${lookup_template_variable_in_page(page, widget, relativeObjId, parents)}${r"}"}',
    <#elseif is_attribute_in_fields(attr, fields)>
    <#--
     ### 用户输入的字段，和界面相关的字段
     -->
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: ${variable}.${modelbase.get_attribute_sql_name(attr)},
    <#elseif attr.constraint.identifiable && parents?size != 0>
      <#if is_attribute_relative_to_one_of_objects(attr, parents)>
      <#--
       ### 如果在此表中有一个字段引用到了上级表的主键，则说明这个表的主键是由传参决定
       -->
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: this.params.${modelbase.get_attribute_sql_name(attr)},
      <#else>
      <#--
       ### 如果在此表和上级表没有一点关联性，则上级表的主键就是这个表的主键，此规则只在Savable编辑表单起作用
       -->
        <#local templateVariable = lookup_template_variable_in_page(page, widget, attr, parents)>
        <#if templateVariable == "">
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${lookup_template_variable_in_page(page, widget, parentObjId, parents)}${r"}"}',
        <#else>
${""?left_pad(indent)}${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${templateVariable}${r"}"}',
        </#if>
      </#if>
    </#if>
  </#list>
  <#if parents?size == 0>
${""?left_pad(indent)}_result_name: '${js.nameVariable(variable)}',
  <#else>
${""?left_pad(indent)}_result_name: '${js.nameVariable(wrapper.object.name)}',
  </#if>
  <#local innerParents = parents>
  <#list wrapper.children![] as childWrapper>
    <#local childObject = childWrapper.object>
    <#local innerParents = innerParents + [wrapper]>
    <#if childObject.getLabelledOptions("persistence")["array"] == "true"><#-- 数组 -->
${""?left_pad(indent)}'||${childObject.getLabelledOptions("name")["schema"]}/${childObject.getLabelledOptions("name")["module"]}/${childObject.name}/batch': {
      <#-- 如果在模型中定义了某个子对象为数组，首先在字段定义中去寻找对应的特殊字段 -->
      <#list fields as field>
        <#if childObject.name == field.objectName><#-- 确实对象是一致的 --><#continue></#if>
        <#-- 几个特殊处理的字段，再表单中几种特殊处理的字段 -->
        <#if field.input == "attachments">
${""?left_pad(indent)}  ${js.nameVariable(childObj.name)}s: this.getParamsAsFiles${js.nameType(field.fieldName)}(),
        <#elseif field.input == "custom">
${""?left_pad(indent)}  ${js.nameVariable(childObj.name)}s: this.getParamsAsCustom${js.nameType(field.fieldName)}(),
        <#elseif field.input == "images">
${""?left_pad(indent)}  ${js.nameVariable(childObj.name)}s: this.getParamsAsImages${js.nameType(field.fieldName)}(),
        <#elseif field.input == "videos">
${""?left_pad(indent)}  ${js.nameVariable(childObj.name)}s: this.getParamsAsVideos${js.nameType(field.fieldName)}(),
        </#if>
      </#list>
    <#else><#-- 单个 -->
${""?left_pad(indent)}'||${childObject.getLabelledOptions("name")["schema"]}/${childObject.getLabelledOptions("name")["module"]}/${childObject.name}/merge': {
<@print_js_params_for_save parents=innerParents wrapper=childWrapper fields=fields page=page widget=widget indent=indent+2 />
    </#if>
${""?left_pad(indent)}},
  </#list>
  <#--
   ### 复合对象
   -->
  <#list fields as field>
    <#if field.fieldName?contains(".")>
      <#local name = field.fieldName?split(".")[0]>
${""?left_pad(indent)}${js.nameVariable(name)}: ${variable}.${js.nameVariable(name)},
    </#if>
  </#list>
</#macro>