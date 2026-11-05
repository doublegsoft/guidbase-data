<#import "/$/guidbase.ftl" as guidbase>
<#include "vue3-default.ftl">
<#include "vue3.ftl">
<#function get_var pvar widget property>
  <#local ret = guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, property))>
  <#if pvar == "">
    <#return ret>
  </#if>
  <#return pvar>
</#function>
<!----------------------------------------------------------------------------->
<!--                                    ROW                                  -->
<!----------------------------------------------------------------------------->
<#macro print_row_layout row indent=0>
  <#local spans = 0>
  <#list row.children as child>
    <#local span = child.value("span","1")?number>
    <#local spans += span>
  </#list>
  <#local cols = 24 / spans>
${""?left_pad(indent)}<div class="${namespace}-row ${namespace}-row--gap-sm">
  <#list row.children as child>
    <#local span = child.value("span","1")?number>
${""?left_pad(indent)}  <div class="${namespace}-col-${cols * span}">
<@print_widget_layout widget=child indent=indent+4 />
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_layout tabs indent=0>
${""?left_pad(indent)}<div class="${namespace}-tabs">
${""?left_pad(indent)}  <div v-for="tab in tabs${js.nameType(tabs.id)}" :key="tab.key"
${""?left_pad(indent)}       class="${namespace}-tab"
${""?left_pad(indent)}       :class="{ '${namespace}-active': activeTab${js.nameType(tabs.id)} === tab.key }"
${""?left_pad(indent)}       @click="activeTab${js.nameType(tabs.id)} = tab.key">
${""?left_pad(indent)}    <span>{{ tab.label }}</span>
${""?left_pad(indent)}    <span v-if="tab.badge" class="${namespace}-tab-badge">{{ tab.badge }}</span>
${""?left_pad(indent)}  </div>
  <#if tabs.contains("buttons")>
    <#local buttons = tabs.byType("buttons")[0]>
${""?left_pad(indent)}  <div class="${namespace}-tabs-right" v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(buttons.container.id)}'">
    <#list buttons.children as button>
<@print_widget_layout widget=button indent=indent+4 />
    </#list>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
${""?left_pad(indent)}<div class="${namespace}-tabs-content" ref="${js.nameVariable(tabs.id)}Ref">
  <#list tabs.children as tab>
${""?left_pad(indent)}  <div v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(tab.id)}'" :style="{ height: ${js.nameType(tabs.id)}Height + 'px' }">
    <#if tab.children?size == 0>
${""?left_pad(indent)}    ${tab.title}
    <#else>
      <#list tab.children as child>
<@print_widget_layout widget=child indent=indent+4 />
      </#list>
    </#if>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_layout form indent=0>
  <#local cols = form.value("cols","3")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div id="entry${js.nameType(form.id)}"<#if guidbase.has_child_widget(form.page, "buttons") && guidbase.is_last_widget(form)> style="padding-bottom:50px;"</#if>>
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
    <#if group?index != 0>
${""?left_pad(indent)}  <div class="${namespace}-divider"></div>    
    </#if>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}    <div class="${namespace}-form ${namespace}-form--${cols}">
    <#list rows as row>
      <#list row as child>
        <#local cType = (child.type!child.value("type")!child.value("widget")!"")?lower_case>
        <#local isTopAlign = ["avatar", "videos", "images", "longtext", "files"]?seq_contains(cType)>
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if><#if isTopAlign> ${namespace}-field--top</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if><#if isTopAlign> ${namespace}-field-label--top</#if>">${child.title}</label>
<@print_widget_layout widget=child indent=indent+8 />
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>    
${""?left_pad(indent)}  </div>  
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_official_form_layout form indent>
  <#local cols = form.value("cols","3")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div class="${namespace}-of">
${""?left_pad(indent)}  <div ref="${js.nameVariable(form.id)}Ref" class="${namespace}-of__container">
${""?left_pad(indent)}    <div class="${namespace}-of__header">
${""?left_pad(indent)}      <h1>${form.title}</h1>
<#--  ${""?left_pad(indent)}      <div class="${namespace}-of__meta">
${""?left_pad(indent)}        <span>机密程度：{{ confidentialLevel }}</span>
${""?left_pad(indent)}        <span>流程编号：{{ flowNo }}</span>
${""?left_pad(indent)}        <span>申请日期：{{ applyDate }}</span>
${""?left_pad(indent)}      </div>  -->
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <table class="${namespace}-of__table">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
${""?left_pad(indent)}      <tr>
      <#list row as child>
${""?left_pad(indent)}        <td class="${namespace}-of__label<#if child.value("required","") == "true"> ${namespace}-of__required</#if>">${child.title}</td>
${""?left_pad(indent)}        <td colspan="${child.value("span","1")?number * 2 - 1}">
          <#if child.type == "date">
${""?left_pad(indent)}          <${namespace}-datepicker data-test="${js.nameVariable(child.id)}" v-model="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}" plain />
          <#elseif child.type == "select">
            <#--  <#if (child.value("data")!"")?starts_with("enum[")>  -->
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />
            <#--  </#if>  -->
          <#elseif child.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
          <#elseif child.type == "cascade">
            <#local enumRef = typebase.enumref(guidbase.get_data_from_widget(child))>
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(child.id)}" :fetch-options="sdk.fetch${js.nameType(inflector.pluralize(enumRef.name))}AsOptions" v-model:labels="${guidbase.name_input_variable(child)}OptionLabels" v-model="${guidbase.name_input_variable(child)}" levels="3" plain />
          <#elseif child.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(child.id)}" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
          <#elseif child.type == "longtext">
${""?left_pad(indent)}          <textarea
${""?left_pad(indent)}            class="${namespace}-of__textarea"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly }"
${""?left_pad(indent)}            :placeholder="${child.value("placeholder", "请填写" + child.title)}"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input=""></textarea>      
          <#else>
${""?left_pad(indent)}          <input type="text"
${""?left_pad(indent)}            class="${namespace}-of__input"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly  || ${child.value("readonly","false")} }"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input="">              
          </#if>
${""?left_pad(indent)}        </td>
      </#list>
${""?left_pad(indent)}      </tr>
    </#list>
  </#list>
${""?left_pad(indent)}    </table>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               LETTER FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_letter_form_layout form indent>
  <#-- 1. 基础配置与元数据提取 -->
  <#local corpName    = form.value("corp_name", "中国建设银行股份有限公司上海分行")>
  <#local corpSub     = form.value("corp_sub", "CHINA CONSTRUCTION BANK · BUSINESS CORRESPONDENCE")>
  <#local logoText    = form.value("logo_text", "CCB")>
  <#local sealCorp    = form.value("seal_corp", "中国建设银行上海分行")>
  <#local sealType    = form.value("seal_type", "业务专用章")>
  <#local closingText = form.value("closing", "专此函达。")>
  <#local wishText    = form.value("wish", "顺祝 商祺！")>
  <#local showToolbar = form.value("toolbar", "true") == "true">
  <#local showSeal    = form.value("show_seal", "true") == "true">

  <#-- 2. 扫描子字段并按信函业务语义分流 (支持 group 或 slot 或字段特征推断) -->
  <#local metaChildren     = []> <#-- 函号、日期等信头元数据 -->
  <#local recipientChild   = ""> <#-- 致送单位/受函人 -->
  <#local bodyChild        = ""> <#-- 信函正文 -->
  <#local signoffChildren  = []> <#-- 发函部门、签发代表、签章日期 -->
  <#local annexChildren    = []> <#-- 附件清单 -->
  <#local generalChildren  = []> <#-- 其他扩展字段 -->

  <#list form.groups() as grp>
    <#list form.rows(grp, 100) as row>
      <#list row as child>
        <#local slot = child.value("slot", grp?lower_case)>
        <#local cid  = child.id?lower_case>

        <#if slot == "meta" || slot == "header" || cid?contains("no") || cid?contains("code") || cid?contains("num")>
          <#local metaChildren = metaChildren + [child]>
        <#elseif slot == "recipient" || slot == "salutation" || cid?contains("recipient") || cid?contains("receiver") || cid?contains("to")>
          <#local recipientChild = child>
        <#elseif slot == "body" || slot == "content" || child.type == "longtext">
          <#if !(bodyChild?is_hash)>
            <#local bodyChild = child>
          <#else>
            <#local generalChildren = generalChildren + [child]>
          </#if>
        <#elseif slot == "signoff" || slot == "sign" || cid?contains("sign") || cid?contains("sender") || cid?contains("issuer") || cid?contains("dept")>
          <#local signoffChildren = signoffChildren + [child]>
        <#elseif slot == "annex" || slot == "attachment" || child.type == "file" || cid?contains("annex") || cid?contains("attach")>
          <#local annexChildren = annexChildren + [child]>
        <#else>
          <#local generalChildren = generalChildren + [child]>
        </#if>
      </#list>
    </#list>
  </#list>
${""?left_pad(indent)}<div class="${namespace}-lt">
<#-- ── 顶部操作工具栏 ── -->
<#if showToolbar>
${""?left_pad(indent)}  <div class="${namespace}-lt__toolbar">
${""?left_pad(indent)}    <div class="${namespace}-lt__toolbar-left">
${""?left_pad(indent)}      <span class="${namespace}-lt__toolbar-title">${form.value("toolbar_title", "信函编辑器")}</span>
${""?left_pad(indent)}      <button type="button" class="${namespace}-btn" @click="window.print()">打印信笺</button>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="${namespace}-lt__toolbar-right">
${""?left_pad(indent)}      <button type="button" class="${namespace}-btn" @click="$emit('draft')">存为草稿</button>
${""?left_pad(indent)}      <button type="button" class="${namespace}-btn ${namespace}-btn--primary" @click="$emit('submit')">签发用印</button>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
</#if>
<#-- ── 信函纸张主体 (A4 竖版比例纸张) ── -->
${""?left_pad(indent)}  <div ref="${js.nameVariable(form.id)}Ref" class="${namespace}-lt__paper">
${""?left_pad(indent)}    <!-- 1. 信头区 (Letterhead) -->
${""?left_pad(indent)}    <div class="${namespace}-lt__lh">
${""?left_pad(indent)}      <div class="${namespace}-lt__lh-corp">
${""?left_pad(indent)}        <div class="${namespace}-lt__lh-logo">${logoText}</div>
${""?left_pad(indent)}        <div class="${namespace}-lt__lh-titles">
${""?left_pad(indent)}          <h2>${corpName}</h2>
${""?left_pad(indent)}          <p>${corpSub}</p>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <div class="${namespace}-lt__lh-meta">
<#list metaChildren as meta>
${""?left_pad(indent)}        <div class="${namespace}-lt__lh-meta-item">
${""?left_pad(indent)}          <span>${meta.title}：</span>
<@print_letter_control child=meta form=form indent=indent+10 />
${""?left_pad(indent)}        </div>
</#list>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <!-- 2. 信函内容正体 (Letter Content) -->
${""?left_pad(indent)}    <div class="${namespace}-lt__content">
${""?left_pad(indent)}      <!-- 事由/标题 -->
${""?left_pad(indent)}      <div class="${namespace}-lt__subject">
${""?left_pad(indent)}        <span class="${namespace}-lt__subject-inner">${form.title}</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <!-- 上款 (致受函单位/人) -->
<#if recipientChild?is_hash>
${""?left_pad(indent)}      <div class="${namespace}-lt__salutation">
${""?left_pad(indent)}        <span class="${namespace}-lt__salutation-prefix">致：</span>
<@print_letter_control child=recipientChild form=form indent=indent+8 isRecipient=true />
${""?left_pad(indent)}        <span class="${namespace}-lt__salutation-suffix">${form.value("salutation_suffix", "公鉴：")}</span>
${""?left_pad(indent)}      </div>
</#if>
${""?left_pad(indent)}      <!-- 正文文本域 (支持信笺横线背景) -->
<#if bodyChild?is_hash>
${""?left_pad(indent)}      <div class="${namespace}-lt__body">
${""?left_pad(indent)}        <textarea
${""?left_pad(indent)}          class="${namespace}-lt__textarea"
${""?left_pad(indent)}          :class="{ '${namespace}-lt__readonly': readonly }"
${""?left_pad(indent)}          placeholder="${bodyChild.value("placeholder", "在此书写信函具体事项...")}"
${""?left_pad(indent)}          v-model="${js.nameVariable(form.id)}Data.${js.nameVariable(bodyChild.id)}"
${""?left_pad(indent)}          :readonly="readonly || ${bodyChild.value("readonly","false")}"></textarea>
${""?left_pad(indent)}      </div>
</#if>
<#-- 附加普通扩展属性（若有） -->
<#if generalChildren?size gt 0>
${""?left_pad(indent)}      <div class="${namespace}-lt__general-fields">
  <#list generalChildren as gField>
${""?left_pad(indent)}        <div class="${namespace}-lt__general-item">
${""?left_pad(indent)}          <span class="${namespace}-lt__general-label">${gField.title}：</span>
<@print_letter_control child=gField form=form indent=indent+10 />
${""?left_pad(indent)}        </div>
  </#list>
${""?left_pad(indent)}      </div>
</#if>

${""?left_pad(indent)}      <!-- 结语/祝词 -->
${""?left_pad(indent)}      <div class="${namespace}-lt__closing">${closingText}</div>
${""?left_pad(indent)}      <div class="${namespace}-lt__wish">${wishText}</div>

${""?left_pad(indent)}      <!-- 落款与签印区 -->
${""?left_pad(indent)}      <div class="${namespace}-lt__signoff-wrap">
${""?left_pad(indent)}        <div class="${namespace}-lt__signoff">
<#list signoffChildren as signField>
${""?left_pad(indent)}          <div class="${namespace}-lt__signoff-row">
${""?left_pad(indent)}            <span class="${namespace}-lt__signoff-label">${signField.title}：</span>
<@print_letter_control child=signField form=form indent=indent+12 />
${""?left_pad(indent)}          </div>
</#list>
${""?left_pad(indent)}        </div>

<#if showSeal>
${""?left_pad(indent)}        <!-- 真实红印印章模拟 -->
${""?left_pad(indent)}        <div class="${namespace}-lt__seal">
${""?left_pad(indent)}          <div class="${namespace}-lt__seal-star">★</div>
${""?left_pad(indent)}          <div class="${namespace}-lt__seal-corp">${sealCorp}</div>
${""?left_pad(indent)}          <div class="${namespace}-lt__seal-type">${sealType}</div>
${""?left_pad(indent)}        </div>
</#if>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>

${""?left_pad(indent)}    <!-- 3. 底栏附件与备查信息 -->
${""?left_pad(indent)}    <div class="${namespace}-lt__footer">
<#if annexChildren?size gt 0>
${""?left_pad(indent)}      <div class="${namespace}-lt__annex">
${""?left_pad(indent)}        <div class="${namespace}-lt__annex-title">附件及清单：</div>
  <#list annexChildren as aField>
${""?left_pad(indent)}        <div class="${namespace}-lt__annex-item">
${""?left_pad(indent)}          <span class="${namespace}-lt__annex-index">${aField_index + 1}.</span>
<@print_letter_control child=aField form=form indent=indent+10 />
${""?left_pad(indent)}        </div>
  </#list>
${""?left_pad(indent)}      </div>
</#if>

${""?left_pad(indent)}      <div class="${namespace}-lt__bottom-bar">
${""?left_pad(indent)}        <span>${form.value("contact_info", "联系人：信函联络专员 / 电话：021-XXXXXXXX / 地址：国际金融中心大厦")}</span>
${""?left_pad(indent)}        <span>第 1 页 / 共 1 页</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#-- =========================================================================
  辅助宏：控件派发渲染 (统一采用 plain 极简无边框线装模式)
========================================================================= -->
<#macro print_letter_control child form indent isRecipient=false>
  <#local modelPath = "${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}">
  <#local readonlyExpr = "readonly || " + child.value("readonly", "false")>
  <#if child.type == "date">
${""?left_pad(indent)}<${namespace}-datepicker data-test="${js.nameVariable(child.id)}" v-model="${modelPath}" :readonly="${readonlyExpr}" plain />
  <#elseif child.type == "select">
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" :clearable="true" v-model="${modelPath}" :disabled="${readonlyExpr}" plain />
  <#elseif child.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" v-model="${modelPath}" :disabled="${readonlyExpr}" plain />
  <#elseif child.type == "cascade">
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(child.id)}" :fetch-options="sdk.fetch${js.nameType(child.value("data",child.id))}AsOptions" v-model:labels="${guidbase.name_input_variable(child)}OptionLabels" v-model="${guidbase.name_input_variable(child)}" :disabled="${readonlyExpr}" plain />
  <#elseif child.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(child.id)}" v-model="${modelPath}" :disabled="${readonlyExpr}" plain />
  <#else>
${""?left_pad(indent)}<input type="text"
${""?left_pad(indent)}  class="${namespace}-lt__line-input<#if isRecipient> ${namespace}-lt__line-input--recipient</#if>"
${""?left_pad(indent)}  :class="{ '${namespace}-lt__readonly': ${readonlyExpr} }"
${""?left_pad(indent)}  placeholder="${child.value("placeholder", "请填写" + child.title)}"
${""?left_pad(indent)}  v-model="${modelPath}"
${""?left_pad(indent)}  :readonly="${readonlyExpr}" />
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_layout form indent=0>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}" class="${namespace}-toolbar">
  <#list form.children as widget>
    <#if widget.type != "buttons">
<@print_widget_layout widget=widget indent=indent+2 />
    </#if>
  </#list>
  <#list form.children as widget>
    <#if widget.type != "buttons"><#continue></#if>
    <#list widget.children as button>
<@print_widget_layout widget=button indent=indent+2 />
    </#list>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_layout form indent=0>
  <#local optionable_widgets = {}>
  <#list app.pages as p>
    <#list p.widgets as widget>
      <#if widget.type != "select" && widget.type != "multiselect" && widget.type != "cascade"><#continue></#if>
      <#if widget.value("data") == ""><#continue></#if><#-- 没有定义数据源 -->
      <#if widget.value("data")?contains(":")>
        <#local opts = typebase.enumtype(widget.value("data"))>
        <#local optionable_widgets += {widget.id:{"value":opts,"isRef":false}}>
      <#else>
        <#local ref = typebase.enumref(widget.value("data"))>
        <#local optionable_widgets += {widget.id:{"value":ref,"isRef":true}}>
      </#if>
    </#list>
  </#list>
  <#local cols = form.value("cols", "3")>
  <#local formId = js.nameVariable(form.id)>
${""?left_pad(indent)}<div id="${formId}"<#if guidbase.has_child_widget(form.page, "buttons") && guidbase.is_last_widget(form)> style="padding-bottom:50px;"</#if>>
  <#list form.groups() as group>
    <#if group?index != 0>
${""?left_pad(indent)}  <div class="${namespace}-divider"></div>
    </#if>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
${""?left_pad(indent)}    <div class="${namespace}-fview ${namespace}-fview--${cols}">
      <#list row as input>
        <#local span = input.value("span", "")>
        <#local inputId = js.nameVariable(input.id)>
        <#local dataField = formId + "Data." + inputId>
        <#local tagTheme = input.value("theme", input.value("tagType", "primary"))>
        <#local inputType = (input.type!input.value("type")!"")?lower_case>
        <#local isTopAlign = ["avatar", "image", "images", "video", "videos", "file", "files", "attachment", "attachments", "longtext", "textarea"]?seq_contains(inputType)>
${""?left_pad(indent)}      <div class="${namespace}-fv<#if span != ""> ${namespace}-fv--span${span}</#if><#if isTopAlign> ${namespace}-fv--top</#if>">
${""?left_pad(indent)}        <div class="${namespace}-fv-label<#if isTopAlign> ${namespace}-fv-label--top</#if>">${input.title}</div>
        <#if inputType == "tags" || inputType == "tag">
${""?left_pad(indent)}        <div class="${namespace}-fv-val" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span
${""?left_pad(indent)}            v-for="(tag, tagIdx) in (Array.isArray(${dataField}) ? ${dataField} : String(${dataField} || '').split(/[,，]/).map(s => s.trim()).filter(Boolean))"
${""?left_pad(indent)}            :key="tagIdx"
${""?left_pad(indent)}            :class="['${namespace}-tag', '${namespace}-tag--' + (typeof tag === 'object' && tag.type ? tag.type : '${tagTheme}')]"
${""?left_pad(indent)}          >{{ typeof tag === 'object' && tag !== null ? (tag.label || tag.name || tag.title || tag.value) : tag }}</span>
${""?left_pad(indent)}        </div>
        <#elseif inputType == "select">
          <#if optionable_widgets[input.id]??>
            <#if optionable_widgets[input.id].isRef>
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono">
${""?left_pad(indent)}          <span class="'${namespace}-tag', '${namespace}-tag--primary">
${""?left_pad(indent)}            {{ sdk.get${js.nameType(input.id)}OptionLabel(${dataField}, ${js.nameVariable(input.id)}Options) }}
${""?left_pad(indent)}          </span>
${""?left_pad(indent)}        </div>
            <#else>
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono">
${""?left_pad(indent)}          <span class="${namespace}-tag ${namespace}-tag--primary">
${""?left_pad(indent)}            {{ sdk.get${js.nameType(input.id)}OptionLabel(${dataField}) }}
${""?left_pad(indent)}          </span>
${""?left_pad(indent)}        </div>
            </#if>
          <#else>
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono">{{ ${dataField} ?? '-' }}</div>
          </#if>
        <#elseif inputType == "multiselect">
          <#if optionable_widgets[input.id]??>
            <#if optionable_widgets[input.id].isRef>
${""?left_pad(indent)}        <div class="${namespace}-fv-val" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span
${""?left_pad(indent)}            v-for="(opt, optIdx) in (Array.isArray(${dataField}) ? ${dataField} : (${dataField} ? [${dataField}] : []))"
${""?left_pad(indent)}            :key="optIdx"
${""?left_pad(indent)}            :class="['${namespace}-tag', '${namespace}-tag--${tagTheme}']"
${""?left_pad(indent)}          >{{ sdk.get${js.nameType(input.id)}OptionLabel(opt, ${js.nameVariable(input.id)}Options) }}</span>
${""?left_pad(indent)}        </div>
            <#else>
${""?left_pad(indent)}        <div class="${namespace}-fv-val" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span
${""?left_pad(indent)}            v-for="(opt, optIdx) in (Array.isArray(${dataField}) ? ${dataField} : (${dataField} ? [${dataField}] : []))"
${""?left_pad(indent)}            :key="optIdx"
${""?left_pad(indent)}            :class="['${namespace}-tag', '${namespace}-tag--${tagTheme}']"
${""?left_pad(indent)}          >{{ sdk.get${js.nameType(input.id)}OptionLabel(opt) }}</span>
${""?left_pad(indent)}        </div>
            </#if>
          <#else>
${""?left_pad(indent)}        <div class="${namespace}-fv-val" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span
${""?left_pad(indent)}            v-for="(opt, optIdx) in (Array.isArray(${dataField}) ? ${dataField} : (${dataField} ? [${dataField}] : []))"
${""?left_pad(indent)}            :key="optIdx"
${""?left_pad(indent)}            :class="['${namespace}-tag', '${namespace}-tag--${tagTheme}']"
${""?left_pad(indent)}          >{{ typeof opt === 'object' && opt !== null ? (opt.text ?? opt.label ?? opt.value) : opt }}</span>
${""?left_pad(indent)}        </div>
          </#if>
        <#elseif inputType == "cascade">
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span class="${namespace}-tag ${namespace}-tag--${tagTheme}">
${""?left_pad(indent)}          {{ Array.isArray(${dataField}OptionLabels) ? ${dataField}OptionLabels.join(' / ') : ${dataField}OptionLabels }}
${""?left_pad(indent)}          </span>
${""?left_pad(indent)}        </div>
        <#elseif inputType == "image" || inputType == "images" || inputType == "avatar">
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--media">
${""?left_pad(indent)}          <template v-if="Array.isArray(${dataField}) ? ${dataField}.length : ${dataField}">
${""?left_pad(indent)}            <a
${""?left_pad(indent)}              v-for="(img, imgIdx) in (Array.isArray(${dataField}) ? ${dataField} : [${dataField}])"
${""?left_pad(indent)}              :key="imgIdx"
${""?left_pad(indent)}              :href="typeof img === 'object' && img !== null ? (img.url || img.thumbnailUrl || img.previewUrl) : img"
${""?left_pad(indent)}              target="_blank"
${""?left_pad(indent)}              class="${namespace}-fv-img-box"
${""?left_pad(indent)}            >
${""?left_pad(indent)}              <img
${""?left_pad(indent)}                :src="typeof img === 'object' && img !== null ? (img.url || img.thumbnailUrl || img.previewUrl) : img"
${""?left_pad(indent)}                class="${namespace}-fv-img"
${""?left_pad(indent)}                alt="图片"
${""?left_pad(indent)}              />
${""?left_pad(indent)}            </a>
${""?left_pad(indent)}          </template>
${""?left_pad(indent)}          <span v-else class="${namespace}-fv-empty">-</span>
${""?left_pad(indent)}        </div>
        <#-- 4. 视频展示 (video / videos) -->
        <#elseif inputType == "video" || inputType == "videos">
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--media">
${""?left_pad(indent)}          <template v-if="Array.isArray(${dataField}) ? ${dataField}.length : ${dataField}">
${""?left_pad(indent)}            <div
${""?left_pad(indent)}              v-for="(vid, vidIdx) in (Array.isArray(${dataField}) ? ${dataField} : [${dataField}])"
${""?left_pad(indent)}              :key="vidIdx"
${""?left_pad(indent)}              class="${namespace}-fv-vid-box"
${""?left_pad(indent)}            >
${""?left_pad(indent)}              <video
${""?left_pad(indent)}                :src="typeof vid === 'object' && vid !== null ? (vid.url || vid.blobUrl) : vid"
${""?left_pad(indent)}                class="${namespace}-fv-vid"
${""?left_pad(indent)}                controls
${""?left_pad(indent)}                preload="metadata"
${""?left_pad(indent)}              />
${""?left_pad(indent)}            </div>
${""?left_pad(indent)}          </template>
${""?left_pad(indent)}          <span v-else class="${namespace}-fv-empty">-</span>
${""?left_pad(indent)}        </div>
        <#-- 5. 文件下载列表 (file / files / attachment / attachments) -->
        <#elseif inputType == "file" || inputType == "files" || inputType == "attachment" || inputType == "attachments">
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--files">
${""?left_pad(indent)}          <template v-if="Array.isArray(${dataField}) ? ${dataField}.length : ${dataField}">
${""?left_pad(indent)}            <a
${""?left_pad(indent)}              v-for="(f, fIdx) in (Array.isArray(${dataField}) ? ${dataField} : [${dataField}])"
${""?left_pad(indent)}              :key="fIdx"
${""?left_pad(indent)}              :href="typeof f === 'object' && f !== null ? (f.url || '#') : f"
${""?left_pad(indent)}              :download="typeof f === 'object' && f !== null ? (f.name || '') : ''"
${""?left_pad(indent)}              target="_blank"
${""?left_pad(indent)}              class="${namespace}-fv-file-item"
${""?left_pad(indent)}            >
${""?left_pad(indent)}              <span class="${namespace}-fv-file-icon">📎</span>
${""?left_pad(indent)}              <span class="${namespace}-fv-file-name">{{ typeof f === 'object' && f !== null ? (f.name || f.title || f.url) : f }}</span>
${""?left_pad(indent)}              <span v-if="typeof f === 'object' && f && f.size" class="${namespace}-fv-file-size">({{ Math.round(f.size / 1024) }} KB)</span>
${""?left_pad(indent)}              <span class="${namespace}-fv-file-down" title="下载">↓</span>
${""?left_pad(indent)}            </a>
${""?left_pad(indent)}          </template>
${""?left_pad(indent)}          <span v-else class="${namespace}-fv-empty">-</span>
${""?left_pad(indent)}        </div>
        <#-- 6. 多行长文本 (longtext / textarea) -->
        <#elseif inputType == "longtext" || inputType == "textarea">
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--pre">{{ ${dataField} || '-' }}</div>
        <#-- 7. 默认纯文本展示 -->
        <#else>
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono">{{ ${dataField} ?? '-' }}</div>
        </#if>
${""?left_pad(indent)}      </div>
      </#list>
${""?left_pad(indent)}    </div>
    </#list>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_week_grid_layout grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_layout list indent=0>
${""?left_pad(indent)}<div class="${namespace}-panel ${namespace}-list-view">
${""?left_pad(indent)}  <!-- 顶部 Title 栏 -->
${""?left_pad(indent)}  <div class="${namespace}-panel-head<#if list.value('theme', '') != ''> ${namespace}-panel-head--${list.value('theme')}</#if>">
${""?left_pad(indent)}    <span class="${namespace}-panel-title">${list.title!'待办事项'}</span>
${""?left_pad(indent)}    <#if list.value("extraText", "") != "" || list.value("action", "") != "">
${""?left_pad(indent)}    <span class="${namespace}-panel-extra">
${""?left_pad(indent)}      <a class="${namespace}-link" @click="${js.nameVariable(list.id)}OnExtraClick">
${""?left_pad(indent)}        ${list.value("extraText", "全部 ›")}
${""?left_pad(indent)}      </a>
${""?left_pad(indent)}    </span>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <!-- 紧凑列表项容器 -->
${""?left_pad(indent)}  <div class="${namespace}-summary-list">
${""?left_pad(indent)}    <div
${""?left_pad(indent)}      v-for="(row, index) in ${js.nameVariable(list.id)}Rows"
${""?left_pad(indent)}      :key="row.id || index"
${""?left_pad(indent)}      class="${namespace}-summary-row"
${""?left_pad(indent)}      @click="${js.nameVariable(list.id)}OnItemClick(row, index)"
${""?left_pad(indent)}    >
<@print_tile_layout widget=list indent=indent+6 />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <!-- 空状态处理 -->
${""?left_pad(indent)}    <div v-if="!${js.nameVariable(list.id)}Rows || ${js.nameVariable(list.id)}Rows.length === 0" class="${namespace}-empty-tip">
${""?left_pad(indent)}      暂无数据
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                MAP VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_map_view_layout map indent=0>
  <#local mapId = js.nameVariable(map.id)>
  <#local height = map.value("height", "260px")>
${""?left_pad(indent)}<div id="${mapId}" class="${namespace}-panel ${namespace}-map-panel">
${""?left_pad(indent)}  <!-- 顶部标题与地图图层控制栏 -->
${""?left_pad(indent)}  <div class="${namespace}-panel-head">
${""?left_pad(indent)}    <span>${map.title!'抵押物空间分布 / 地图全景'}</span>
${""?left_pad(indent)}    <div class="${namespace}-panel-extra">
${""?left_pad(indent)}      <!-- 图层切换 -->
${""?left_pad(indent)}      <div class="${namespace}-map-layer-switch">
${""?left_pad(indent)}        <button
${""?left_pad(indent)}          type="button"
${""?left_pad(indent)}          :class="['${namespace}-btn-xs', { active: ${mapId}Layer === 'vector' }]"
${""?left_pad(indent)}          @click="${mapId}Layer = 'vector'"
${""?left_pad(indent)}        >矢量</button>
${""?left_pad(indent)}        <button
${""?left_pad(indent)}          type="button"
${""?left_pad(indent)}          :class="['${namespace}-btn-xs', { active: ${mapId}Layer === 'satellite' }]"
${""?left_pad(indent)}          @click="${mapId}Layer = 'satellite'"
${""?left_pad(indent)}        >卫星</button>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <button type="button" class="${namespace}-btn-xs" title="重置视角" @click="${mapId}ResetView">⟲</button>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}
${""?left_pad(indent)}  <!-- 地图主视口容器 -->
${""?left_pad(indent)}  <div
${""?left_pad(indent)}    class="${namespace}-mapbox"
${""?left_pad(indent)}    :class="'${namespace}-mapbox--' + ${mapId}Layer"
${""?left_pad(indent)}    style="height: ${height};"
${""?left_pad(indent)}    ref="${mapId}Ref"
${""?left_pad(indent)}  >
${""?left_pad(indent)}    <!-- 模拟地图地理元素层 (河流、干道) -->
${""?left_pad(indent)}    <div class="${namespace}-map-river"></div>
${""?left_pad(indent)}    <div class="${namespace}-map-road"></div>
${""?left_pad(indent)}    <div class="${namespace}-map-road ${namespace}-map-road--cross"></div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <!-- 地标点标记 (Markers) -->
${""?left_pad(indent)}    <div
${""?left_pad(indent)}      v-for="(marker, idx) in ${mapId}Markers"
${""?left_pad(indent)}      :key="idx"
${""?left_pad(indent)}      class="${namespace}-map-pin-wrap"
${""?left_pad(indent)}      :class="{ active: ${mapId}ActiveIndex === idx }"
${""?left_pad(indent)}      :style="{ left: marker.x + '%', top: marker.y + '%' }"
${""?left_pad(indent)}      @click="${mapId}OnPinClick(marker, idx)"
${""?left_pad(indent)}    >
${""?left_pad(indent)}      <div class="${namespace}-map-pin">
${""?left_pad(indent)}        <span class="${namespace}-map-pin-icon">📍</span>
${""?left_pad(indent)}        <div class="${namespace}-map-pin-pulse"></div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <div class="${namespace}-map-pin-label">{{ marker.title }}</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <!-- 点击标记弹出的浮层信息卡片 (Popup Card) -->
${""?left_pad(indent)}    <div
${""?left_pad(indent)}      v-if="${mapId}ActiveMarker"
${""?left_pad(indent)}      class="${namespace}-map-popup"
${""?left_pad(indent)}      :style="{ left: ${mapId}ActiveMarker.x + '%', top: ${mapId}ActiveMarker.y + '%' }"
${""?left_pad(indent)}    >
${""?left_pad(indent)}      <div class="${namespace}-map-popup-head">
${""?left_pad(indent)}        <span class="${namespace}-map-popup-title">{{ ${mapId}ActiveMarker.title }}</span>
${""?left_pad(indent)}        <button type="button" class="${namespace}-map-popup-close" @click="${mapId}ActiveMarker = null">×</button>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <div class="${namespace}-map-popup-body">
${""?left_pad(indent)}        <div class="${namespace}-map-popup-row">
${""?left_pad(indent)}          <span class="label">估值:</span>
${""?left_pad(indent)}          <b class="val bold">¥ {{ ${mapId}ActiveMarker.valuation || '--' }}万</b>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}        <div class="${namespace}-map-popup-row">
${""?left_pad(indent)}          <span class="label">状态:</span>
${""?left_pad(indent)}          <span :class="['${namespace}-status', ${mapId}ActiveMarker.statusColor || 'blue']">{{ ${mapId}ActiveMarker.statusText || '正常' }}</span>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}        <div class="${namespace}-map-popup-row">
${""?left_pad(indent)}          <span class="label">坐落:</span>
${""?left_pad(indent)}          <span class="val text-muted">{{ ${mapId}ActiveMarker.address || '--' }}</span>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <!-- 右下角缩放控制按钮 -->
${""?left_pad(indent)}    <div class="${namespace}-map-controls">
${""?left_pad(indent)}      <button type="button" class="${namespace}-map-btn" @click="${mapId}ZoomIn">+</button>
${""?left_pad(indent)}      <button type="button" class="${namespace}-map-btn" @click="${mapId}ZoomOut">-</button>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <!-- 底部状态说明条 -->
${""?left_pad(indent)}    <div class="${namespace}-map-scalebar">
${""?left_pad(indent)}      <span>坐标系: CGCS2000 | 标定物: {{ (${mapId}Markers || []).length }} 处</span>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               HERO CARD                                 -->
<!----------------------------------------------------------------------------->
<#macro print_hero_card_layout hero varname="row" indent=0>
${""?left_pad(indent)}<div class="${namespace}-obj-head">
  <#-- 1. 核心大头像/实体图标 (avatar) -->
${""?left_pad(indent)}  <div class="${namespace}-obj-icon">
  <#if guidbase.has_child_widget(hero, "avatar")>
${""?left_pad(indent)}    <img :src="${js.nameVariable(hero.id)}Data.${js.nameVariable(guidbase.get_child_from_tile(hero, "avatar").id)}" style="width:100%;height:100%;object-fit:cover;border-radius:inherit;" />
  <#elseif guidbase.has_child_widget(hero, "primary")>
${""?left_pad(indent)}    <span>{{ ${js.nameVariable(hero.id)}Data.${js.nameVariable(guidbase.get_child_from_tile(hero, "primary").id)} }}</span>
  </#if>
${""?left_pad(indent)}  </div>

  <#-- 2. 中间信息区 (标题、编码、三级描述信息、标签) -->
${""?left_pad(indent)}  <div style="flex: 1; min-width: 0;">
  <#if guidbase.has_child_widget(hero, "primary")>
${""?left_pad(indent)}    <div class="${namespace}-obj-title">{{ ${js.nameVariable(hero.id)}Data.${js.nameVariable(guidbase.get_child_from_tile(hero, "primary").id)} }}</div>
  </#if>
  <#if guidbase.has_child_widget(hero, "secondary")>
${""?left_pad(indent)}    <div class="${namespace}-obj-id">{{ ${js.nameVariable(hero.id)}Data.${js.nameVariable(guidbase.get_child_from_tile(hero, "secondary").id)} }}</div>
  </#if>
  <#if guidbase.has_child_widget(hero, "tertiary")>
${""?left_pad(indent)}    <div class="${namespace}-obj-meta">
${""?left_pad(indent)}      <span>{{ ${js.nameVariable(hero.id)}Data.${js.nameVariable(guidbase.get_child_from_tile(hero, "tertiary").id)} }}</span>
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(hero, "tags") || guidbase.has_child_widget(hero, "tag")>
    <#local tagsWidget = guidbase.has_child_widget(hero, "tags")?then(guidbase.get_child_from_tile(hero, "tags"), guidbase.get_child_from_tile(hero, "tag"))>
    <#local tagsField = js.nameVariable(hero.id) + "Data." + js.nameVariable(tagsWidget.id)>
    <#local tagTheme = tagsWidget.value("theme", tagsWidget.value("tagType", "primary"))>
${""?left_pad(indent)}    <div class="${namespace}-obj-tags" style="display: flex; gap: 6px; flex-wrap: wrap; margin-top: 6px;">
${""?left_pad(indent)}      <span
${""?left_pad(indent)}        v-for="(tag, tagIdx) in (Array.isArray(${tagsField}) ? ${tagsField} : String(${tagsField} || '').split(/[,，]/).map(s => s.trim()).filter(Boolean))"
${""?left_pad(indent)}        :key="tagIdx"
${""?left_pad(indent)}        :class="['${namespace}-tag', '${namespace}-tag--' + (typeof tag === 'object' && tag.type ? tag.type : '${tagTheme}')]"
${""?left_pad(indent)}      >{{ typeof tag === 'object' && tag !== null ? (tag.label || tag.name || tag.title || tag.value) : tag }}</span>
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}  </div>
  <#-- 3. 右侧状态指示与操作栏 -->
${""?left_pad(indent)}  <div class="${namespace}-obj-status">
  <#if guidbase.has_child_widget(hero, "status")>
${""?left_pad(indent)}    <div class="${namespace}-status-chip ${namespace}-status-active">{{ ${js.nameVariable(hero.id)}Data.${js.nameVariable(guidbase.get_child_from_tile(hero, "status").id)} }}</div>
  </#if>
  <#list hero.children as widget>
    <#if widget.type == "buttons">
${""?left_pad(indent)}    <div class="${namespace}-obj-actions">
      <#list widget.children as button>
<@print_widget_layout widget=button indent=indent+6 />
      </#list>
${""?left_pad(indent)}    </div>
      <#break>
    </#if>
  </#list>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                KPI CHART                                -->
<!----------------------------------------------------------------------------->
<#macro print_kpi_chart_layout kpi varname="row" indent=0>
<#local kpiData = js.nameVariable(kpi.id) + "Data">
<#local chartRef = js.nameVariable(kpi.id) + "ChartRef">
${""?left_pad(indent)}<div class="${namespace}-kpi-card">
  <#-- 1. 卡片顶部：指标标题与趋势胶囊 -->
${""?left_pad(indent)}  <div class="${namespace}-kpi-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px;">
${""?left_pad(indent)}    <span class="${namespace}-kpi-title" style="font-size: 12px; font-weight: bold; color: var(--${namespace}-text-muted);">${kpi.title}</span>
  <#-- 趋势角标 (支持 success / danger / neutral 等主题切换) -->
  <#if guidbase.get_child_from_tile(kpi, "status")??>
    <#local trendWidget = guidbase.get_child_from_tile(kpi, "status")>
    <#local trendField = js.nameVariable(trendWidget.id)>
    <#local trendTheme = trendWidget.value("theme", "success")>
${""?left_pad(indent)}    <span :class="['${namespace}-tag', '${namespace}-tag--' + (trendType || '${trendTheme}')]">{{ ${kpiData}.${trendField} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#-- 2. 核心大数值与单位行 -->
${""?left_pad(indent)}  <div class="${namespace}-kpi-main" style="display: flex; align-items: baseline; gap: 4px; margin-bottom: 4px;">
  <#if guidbase.get_child_from_tile(kpi, "primary")??>
    <#local valWidget = guidbase.get_child_from_tile(kpi, "primary")>
${""?left_pad(indent)}    <span class="${namespace}-kpi-num" style="font-family: var(--${namespace}-mono); font-size: 22px; font-weight: bold; color: var(--${namespace}-text); line-height: 1;">{{ ${js.nameVariable(valWidget.id)} }}</span>
  </#if>
  <#if guidbase.has_child_widget(kpi, "secondary")>
    <#local unitWidget = guidbase.get_child_from_tile(kpi, "secondary")>
${""?left_pad(indent)}    <span class="${namespace}-kpi-unit" style="font-size: 11px; color: var(--${namespace}-text-light);">{{ ${kpiData}.${js.nameVariable(unitWidget.id)} }}</span>
  <#elseif kpi.value("unit")??>
${""?left_pad(indent)}    <span class="${namespace}-kpi-unit" style="font-size: 11px; color: var(--${namespace}-text-light);">${kpi.value("unit")}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#-- 3. 辅助说明与子信息 (如环比、目标) -->
  <#if guidbase.get_child_from_tile(kpi, "tertiary")??>
    <#local subWidget = guidbase.get_child_from_tile(kpi, "tertiary")>
${""?left_pad(indent)}  <div class="${namespace}-kpi-sub" style="font-size: 11px; color: var(--${namespace}-text-muted); display: flex; justify-content: space-between; margin-bottom: 6px;">
${""?left_pad(indent)}    <span>{{ ${kpiData}.${js.nameVariable(subWidget.id)} }}</span>
    <#if kpi.value("target")??>
${""?left_pad(indent)}    <span style="font-family: var(--${namespace}-mono); color: var(--${namespace}-text-light);">6000</span>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
  <#-- 4. 底部微型图表挂载容器 (Chart 容器) -->
${""?left_pad(indent)}  <${namespace}-sparkline 
${""?left_pad(indent)}    :data="${kpiData}.plotData" 
${""?left_pad(indent)}    type="${kpi.value("plot", "line")}" 
${""?left_pad(indent)}    height="48px" 
${""?left_pad(indent)}  />
  <#-- 5. 操作按钮区 (如卡片自带下钻、配置按钮) -->
  <#list kpi.children as widget>
    <#if widget.type == "buttons">
${""?left_pad(indent)}  <div class="${namespace}-kpi-actions" style="margin-top: 6px; display: flex; justify-content: flex-end; gap: 4px;">
      <#list widget.children as button>
<@print_widget_layout widget=button indent=indent+4 />
      </#list>
${""?left_pad(indent)}  </div>
      <#break>
    </#if>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTONS                                 -->
<!----------------------------------------------------------------------------->
<#macro print_buttons_layout buttons indent=0>
  <#if buttons.ancestor("tabs")??>
    <#return>
  </#if>
${""?left_pad(indent)}<div class="${namespace}-form-footer">
${""?left_pad(indent)}  <div style="margin-left: auto;">
  <#list buttons.children as child>
<@print_widget_layout widget=child indent=indent+4 />
  </#list>    
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_container_layout widget indent>
<@print_widget_layout widget=widget indent=indent />
</#macro>

<#macro print_custom_layout widget indent>
  <#if widget.type == "card">
${""?left_pad(indent)}<div class="${namespace}-panel">
${""?left_pad(indent)}  <div class="${namespace}-panel-head">${widget.title!"这里是标题"}</div>
    <#list widget.children as child>
<@print_widget_layout widget=child indent=indent+2 />
    </#list>
${""?left_pad(indent)}</div>  
  <#elseif widget.type == "button">
    <#if widget.ancestor("paged_table")??>
${""?left_pad(indent)}<button class="${namespace}-btn btn-sm ${namespace}-btn--${guidbase.get_button_variant(widget)} ${namespace}-btn-gap" @click="${guidbase.name_button_method(widget)}">${widget.title}</button>    
    <#else>
${""?left_pad(indent)}<button class="${namespace}-btn ${namespace}-btn--${guidbase.get_button_variant(widget)} ${namespace}-btn-gap" @click="${guidbase.name_button_method(widget)}">${widget.title}</button>
    </#if>
  <#elseif widget.type == "longtext">
${""?left_pad(indent)}<textarea class="${namespace}-textarea" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}          v-model="${guidbase.name_input_variable(widget)}" placeholder="${widget.value("placeholder",("请输入" + widget.title))}"></textarea>  
  <#elseif widget.type == "text">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${guidbase.name_input_variable(widget)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}       :class="{ '${namespace}-input--readonly': true }" :disabled="true">
    <#else>
${""?left_pad(indent)}       placeholder="${widget.value("placeholder",("请输入" + widget.title))}">
    </#if>
    <#if widget.value("unit") != "">
${""?left_pad(indent)}<span class="${namespace}-field-unit">${widget.value("unit")}</span>
    </#if>
  <#elseif widget.type == "number">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${guidbase.name_input_variable(widget)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}       :class="{ '${namespace}-input--readonly': true }" :disabled="true">
    <#else>
${""?left_pad(indent)}       placeholder="${widget.value("placeholder",("请输入" + widget.title))}">
    </#if>
    <#if widget.value("unit") != "">
${""?left_pad(indent)}<span class="${namespace}-field-unit">${widget.value("unit")}</span>
    </#if>
  </#if>
</#macro>