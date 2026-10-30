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
${""?left_pad(indent)}<div id="entry${js.nameType(form.id)}">
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
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if>">${child.title}</label>
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
${""?left_pad(indent)}      <div class="${namespace}-of__meta">
${""?left_pad(indent)}        <span>机密程度：{{ confidentialLevel }}</span>
${""?left_pad(indent)}        <span>流程编号：{{ flowNo }}</span>
${""?left_pad(indent)}        <span>申请日期：{{ applyDate }}</span>
${""?left_pad(indent)}      </div>
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
            <#if (child.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="sdk.${js.nameVariable(child.id)}Options" :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />    
            <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options"  :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />
            </#if>
          <#elseif child.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
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
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_layout form indent=0>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}" class="${namespace}-toolbar">
  <#list form.children as widget>
    <#if widget.type != "buttons">
<@print_widget_layout widget=widget indent=indent+2 />
    </#if>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_layout form indent=0>
  <#local cols = form.value("cols", "3")>
  <#local formId = js.nameVariable(form.id)>
${""?left_pad(indent)}<div id="${formId}">
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
${""?left_pad(indent)}      <div class="${namespace}-fv<#if span != ""> ${namespace}-fv--span${span}</#if>">
${""?left_pad(indent)}        <div class="${namespace}-fv-label">${input.title}</div>
        <#-- 1. 普通 Tags / Tag 类型 -->
        <#if input.type?? && (input.type == "tags" || input.type == "tag")>
${""?left_pad(indent)}        <div class="${namespace}-fv-val" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span
${""?left_pad(indent)}            v-for="(tag, tagIdx) in (Array.isArray(${dataField}) ? ${dataField} : String(${dataField} || '').split(/[,，]/).map(s => s.trim()).filter(Boolean))"
${""?left_pad(indent)}            :key="tagIdx"
${""?left_pad(indent)}            :class="['${namespace}-tag', '${namespace}-tag--' + (typeof tag === 'object' && tag.type ? tag.type : '${tagTheme}')]"
${""?left_pad(indent)}          >{{ typeof tag === 'object' && tag !== null ? (tag.label || tag.name || tag.title || tag.value) : tag }}</span>
${""?left_pad(indent)}        </div>
        <#-- 2. 多选下拉 multiselect 类型：单独处理 Option 对象，优先渲染 option.text -->
        <#elseif input.type?? && input.type == "multiselect">
${""?left_pad(indent)}        <div class="${namespace}-fv-val" style="gap: 6px; flex-wrap: wrap;">
${""?left_pad(indent)}          <span
${""?left_pad(indent)}            v-for="(opt, optIdx) in (Array.isArray(${dataField}) ? ${dataField} : (${dataField} ? [${dataField}] : []))"
${""?left_pad(indent)}            :key="optIdx"
${""?left_pad(indent)}            :class="['${namespace}-tag', '${namespace}-tag--${tagTheme}']"
${""?left_pad(indent)}          >{{ typeof opt === 'object' && opt !== null ? (opt.text ?? opt.label ?? opt.value) : opt }}</span>
${""?left_pad(indent)}        </div>
        <#-- 3. 默认文本展示 -->
        <#else>
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono">{{ ${dataField} }}</div>
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