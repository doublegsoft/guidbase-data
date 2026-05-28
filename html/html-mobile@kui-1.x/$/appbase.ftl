<#macro html_item_widget indent type model>
  <#if type == 'single_line'>
<@html_item_single_line indent=indent model=model />
  <#elseif type == 'two_line'>
<@html_item_two_line indent=indent model=model />
  <#elseif type == 'border_two_line'>
<@html_item_border_two_line indent=indent model=model />
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

<#import "/$/modelbase.ftl" as modelbase>

<#macro print_source_code_html snippet widget indent>
<@modelbase.print_source_code platform="MOBILE" framework="kui" language="html" snippet=snippet
                              component=widget.widgetType widget=widget indent=indent />
</#macro>

<#macro print_source_code_js snippet widget indent>
<@modelbase.print_source_code platform="MOBILE" framework="kui" language="js" snippet=snippet
                              component=widget.widgetType widget=widget indent=indent />
</#macro>

<#macro print_string_line_by_line text indent>
  <#assign lines = text?split('\n')>
  <#list lines as line>
${""?left_pad(indent)}${line}
  </#list>
</#macro>

<#--
 ### ------------------
 ### | title          |
 ### ------------------
 -->
<#macro html_item_single_line indent model>
${""?left_pad(indent)}<strong>${r'${row.'}${model.primary!'primary'}${r'}'}</strong>
</#macro>

<#--
 ### ------------------
 ### | primary        |
 ### | secondary      |
 ### ------------------
 -->
<#macro html_item_two_line indent model>
${""?left_pad(indent)}<div class="pl-2"">
${""?left_pad(indent)}  <div>${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}  <div class="small text-muted">${r'${row.'}${model.secondary!'secondary'}${r'}'}</div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### ------------------
 ### || primary       |
 ### || secondary     |
 ### ------------------
 -->
<#macro html_item_border_two_line indent model>
${""?left_pad(indent)}<div class="pl-2" style="border-left: 4px solid rgb(229, 83, 83);">
${""?left_pad(indent)}  <div>${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}  <div class="small text-muted">${r'${row.'}${model.secondary!'secondary'}${r'}'}</div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### -------------------------
 ### |  /\  | primary        |
 ### |  \/  | secondary      |
 ### -------------------------
 -->
<#macro html_item_image_two_line indent model>
${""?left_pad(indent)}<div class="d-flex align-items-center">
${""?left_pad(indent)}  <div class="bg-gradient-primary">
${""?left_pad(indent)}    <img src="${r'${row.'}${model.image!'image'}${r'}'}" style="width:56px; height: 56px">
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div>
${""?left_pad(indent)}    <div class="text-value text-primary font-16">${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}    <div class="text-muted font-weight-bold small">${r'${row.'}${model.secondary!'secondary'}${r'}'}</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
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
${""?left_pad(indent)}<div class="d-flex align-items-center">
${""?left_pad(indent)}  <div class="bg-gradient-primary">
${""?left_pad(indent)}    <img src="${r'${row.'}${model.image!'image'}${r'}'}" style="width:96px; height: 96px">
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div>
${""?left_pad(indent)}    <div class="text-value text-primary font-16">${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}    <div class="text-muted font-weight-bold small">${r'${row.'}${model.secondary!'secondary'}${r'}'}</div>
${""?left_pad(indent)}    <div class="text-muted">${r'${row.'}${model.tertiary!'tertiary'}${r'}'}</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------------------------
 ### |  /\  | primary      | /\ |
 ### |  \/  | secondary    | \/ |
 ### ----------------------------
 -->
<#macro html_item_image_two_line_float indent model>
${""?left_pad(indent)}<div class="d-flex align-items-center">
${""?left_pad(indent)}  <div class="bg-gradient-primary">
${""?left_pad(indent)}    <img src="${r'${row.'}${model.image!'image'}${r'}'}" style="width:56px; height: 56px">
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div>
${""?left_pad(indent)}    <div class="text-value text-primary font-16">${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}    <div class="text-muted font-weight-bold small">${r'${row.'}${model.secondary!'secondary'}${r'}'}</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="float-right position-relative" style="top: 8px; height: 26px;">
${""?left_pad(indent)}    <i class="fas fa-todo"></i>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### ---------------------
 ### | primary      | /\ |
 ### | secondary    | \/ |
 ### ---------------------
 -->
<#macro html_item_two_line_float model>
${""?left_pad(indent)}<div class="d-flex justify-content-between pl-2 full-width" style="border-left: 4px solid rgb(69, 161, 100);">
${""?left_pad(indent)}  <div>
${""?left_pad(indent)}    <div>${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}    <div class="small text-muted">
${""?left_pad(indent)}      <span class="text-success">${r'${row.'}${model.secondary!'secondary'}${r'}'}</span>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="float-right position-relative" style="top: 8px; height: 26px;">
${""?left_pad(indent)}    <i class="fas fa-todo"></i>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | /\ | /\ | /\ | /\ | /\ |
 ### | \/ | \/ | \/ | \/ | \/ |
 ### --------------------------
 -->
<#macro html_item_images indent model>
${""?left_pad(indent)}<div class="row m-auto" style="justify-content: center;">
${""?left_pad(indent)}</div>
</#macro>

<#macro html_item_image indent model>
${""?left_pad(indent)}<div class="avatar avatar-36 tooltip-avatar">
${""?left_pad(indent)}  <img src="${r'${row.'}${model.image!'image'}${r'}'}">
${""?left_pad(indent)}  <span class="tooltip-text">${r'${row.'}${model.primary!'primary'}${r'}'}</span>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | 80%        start - end |
 ### | ==================     |
 ### --------------------------
 -->
<#macro html_item_duration_progress indent model>
${""?left_pad(indent)}<div>
${""?left_pad(indent)}  <div class="clearfix">
${""?left_pad(indent)}    <div class="float-left">
${""?left_pad(indent)}      <strong>${r'${row.'}${model.percentage!'percentage'}${r'}'}%</strong>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="float-right">
${""?left_pad(indent)}      <small class="text-muted">${r'${row.'}${model.startTime!'startTime'}${r'}'} - ${r'${row.'}${model.endTime!'endTime'}${r'}'}</small>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="progress progress-xs">
${""?left_pad(indent)}    <div class="progress-bar bg-${r'${row.'}${model.status!'status'}${r'}'}" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div> 
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | primary            80% |
 ### | ==================     |
 ### --------------------------
 -->
<#macro html_item_theme_progress indent model>
${""?left_pad(indent)}<div class="progress-group">
${""?left_pad(indent)}  <div class="progress-group-header">
${""?left_pad(indent)}    <svg class="c-icon progress-group-icon">
${""?left_pad(indent)}      <use xlink:href="vendors/@coreui/icons/svg/free.svg#cil-user"></use>
${""?left_pad(indent)}    </svg>
${""?left_pad(indent)}    <div>${r'${row.'}${model.primary!'primary'}${r'}'}</div>
${""?left_pad(indent)}    <div class="mfs-auto font-weight-bold">${r'${row.'}${model.percentage!'percentage'}${r'}'}%</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="progress-group-bars">
${""?left_pad(indent)}    <div class="progress progress-xs">
${""?left_pad(indent)}      <div class="progress-bar bg-warning" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### --------------------------
 ### | primary ============== |
 ### |         =========      |
 ### --------------------------
 -->
<#macro html_item_comparison_progress indent model>
${""?left_pad(indent)}<div class="progress-group mb-4">
${""?left_pad(indent)}  <div class="progress-group-prepend">
${""?left_pad(indent)}    <span class="progress-group-text">${r'${row.'}${model.primary!'primary'}${r'}'}</span>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="progress-group-bars">
${""?left_pad(indent)}    <div class="progress progress-xs">
${""?left_pad(indent)}      <div class="progress-bar bg-info" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="progress progress-xs">
${""?left_pad(indent)}      <div class="progress-bar bg-danger" role="progressbar" style="width: ${r'${row.'}${model.percentage!'percentage'}${r'}'}%" aria-valuenow="${r'${row.'}${model.percentage!'percentage'}${r'}'}" aria-valuemin="0" aria-valuemax="100"></div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### ----------------------------
 ### | [] | primary | secondary |
 ### ----------------------------
 -->
<#macro html_item_person indent model>
${""?left_pad(indent)}<div class="ui yellow image label bg-info text-white">
${""?left_pad(indent)}  <img src="${r'${row.'}${model.image!'image'}${r'}'}" height="32">
${""?left_pad(indent)}  <span>${r'${row.'}${model.primary!'primary'}${r'}'}</span>
${""?left_pad(indent)}  <p class="detail">${r'${row.'}${model.secondary!'secondary'}${r'}'}</p>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ### ---------
 ### | /---| |
 ### | \---| |
 ### ---------
 -->
<#macro html_item_tag indent model>
${""?left_pad(indent)}<a class="ui tag label bg-danger text-white ml-5">${r'${row.'}${model.primary!'primary'}${r'}'}</a>
</#macro>

<#macro html_widget indent model>
<#if model.type == '滚动导航'>
<@滚动导航_html indent=indent model=model/>
<#elseif model.type == '列表导航'>
<@列表导航_html indent=indent model=model/>
</#if>
</#macro>

<#macro js_widget_init indent model>
<#if model.type == '滚动导航'>
<@滚动导航_js_init indent=indent model=model/>
<#elseif model.type == '列表导航'>
<@列表导航_js_init indent=indent model=model/>
</#if>
</#macro>

<#macro 滚动导航_html indent model>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(model.variable)}" class="swiper" 
${""?left_pad(indent)}     style="{{{style}}}">
${""?left_pad(indent)}  <div class="swiper-wrapper">
${""?left_pad(indent)}    <div class="swiper-slide">
${""?left_pad(indent)}      <img src="/img/placeholder/600x200.png" height="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide">
${""?left_pad(indent)}      <img src="/img/placeholder/600x200.png" height="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide">
${""?left_pad(indent)}      <img src="/img/placeholder/600x200.png" height="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro 滚动导航_js_init indent model>
${""?left_pad(indent)}this.swiper${js.nameType(model.variable)} = new Swiper(this.widget${js.nameType(model.variable)}, {
${""?left_pad(indent)}  direction: 'horizontal',
${""?left_pad(indent)}  loop: true,
${""?left_pad(indent)}});
</#macro>

<#macro 列表导航_html indent model>
${""?left_pad(indent)}<ul class="list-group" 
${""?left_pad(indent)}    style="
${""?left_pad(indent)}      margin-bottom: {{marginBottom}};
${""?left_pad(indent)}      margin-top: {{marginTop}};
${""?left_pad(indent)}    ">
<#list model.items as item>
${""?left_pad(indent)}  <li class="list-group-item list-group-item-action d-flex">
${""?left_pad(indent)}    <strong class="font-20">${item.title}</strong>
${""?left_pad(indent)}    <span class="ml-auto material-icons font-20 position-relative" style="top: 3px;">navigate_next</span>
${""?left_pad(indent)}  </li>
</#list>
${""?left_pad(indent)}</ul>
</#macro>

<#macro 列表导航_js_init indent model>

</#macro>

<#macro print_html_declare_cyclenavigator widget indent>
${""?left_pad(indent)}<div widget-id="widgetSwiper${js.nameType(widget.variable)}" class="swiper" style="height: 100%;">
${""?left_pad(indent)}  <div class="swiper-wrapper">
${""?left_pad(indent)}    <div class="swiper-slide">
${""?left_pad(indent)}      <img src="/img/placeholder/600x200.png" height="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide">
${""?left_pad(indent)}      <img src="/img/placeholder/600x200.png" height="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide">
${""?left_pad(indent)}      <img src="/img/placeholder/600x200.png" height="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_scrollnavigator widget indent>
${""?left_pad(indent)}<div widget-id="widgetSwiper${js.nameType(widget.variable!"todo")}" class="swiper">
${""?left_pad(indent)}  <div class="swiper-wrapper">
${""?left_pad(indent)}    <div class="swiper-slide height-80">
${""?left_pad(indent)}      <img src="/img/placeholder/120x80.png">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide height-80">
${""?left_pad(indent)}      <img src="/img/placeholder/120x80.png">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide height-80">
${""?left_pad(indent)}      <img src="/img/placeholder/120x80.png">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide height-80">
${""?left_pad(indent)}      <img src="/img/placeholder/120x80.png">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="swiper-slide height-80">
${""?left_pad(indent)}      <img src="/img/placeholder/120x80.png">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_gridnavigator widget indent>
${""?left_pad(indent)}<div class="square-menu my-2">
<#list widget.items as item>
  <#if item.title?? && item.title != "">
${""?left_pad(indent)}  <a widget-id="button${js.nameType(item.url!"todo")}" class="entry btn">
${""?left_pad(indent)}    <div class="d-flex flex-column text-primary">
${""?left_pad(indent)}      <i class="fas fa-monument text-gray font-4xl"></i>
${""?left_pad(indent)}      <span class="font-14 text-gray mt-2">${item.title}</span>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </a>
  <#else>
${""?left_pad(indent)}  <div class="entry btn"></div>
  </#if>
</#list>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_columnnavigator widget indent>
${""?left_pad(indent)}<div class="row mx-0 my-2" style="height: 180px;">
${""?left_pad(indent)}  <div class="col-24-12 pr-1">
${""?left_pad(indent)}    <img src="/img/placeholder/300x450.png" width="100%">
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="col-24-12 pl-1">
${""?left_pad(indent)}    <div class="pb-1">
${""?left_pad(indent)}      <img src="/img/placeholder/240x150.png" width="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="pt-1">
${""?left_pad(indent)}      <img src="/img/placeholder/240x150.png" width="100%">
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_listnavigator widget indent>
${""?left_pad(indent)}<ul class="list-group">
<#list widget.items as item>
${""?left_pad(indent)}  <li widget-id="button${js.nameType(item.url!"todo")}" class="list-group-item list-group-item-action d-flex">
${""?left_pad(indent)}    <strong class="font-18">${item.title!"标题"}</strong>
${""?left_pad(indent)}    <span class="ml-auto material-icons font-20 position-relative" style="top: 3px;">navigate_next</span>
${""?left_pad(indent)}  </li>
</#list>
${""?left_pad(indent)}</ul>
</#macro>

<#macro print_html_declare_tabnavigator widget indent>
${""?left_pad(indent)}<div>
${""?left_pad(indent)}  <div widget-id="widgetNavigator${js.nameType(widget.variable!"todo")}"
${""?left_pad(indent)}       class="d-flex no-scrollbar position-relative"></div>
${""?left_pad(indent)}  <div widget-id="widgetContent${js.nameType(widget.variable!"todo")}"
${""?left_pad(indent)}       style="overflow-y: auto; overflow-x: hidden; margin-top: 2px;"></div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_groupnavigator widget indent>
${""?left_pad(indent)}<div class="d-flex no-scrollbar position-relative height-36 line-height-36">
  <#list widget.items![] as item>
${""?left_pad(indent)}  <a class="btn-link mx-2 font-16">${item.title!"标题"}</a>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_formlayout widget indent></#macro>

<#macro print_html_declare_styledform widget indent>
  <#if !widget.customStyled??><#return></#if>
${""?left_pad(indent)}<ul class="list-group">
  <#list widget.customStyled.fields as field>
    <#if !field.input??>
      <#assign field = field + {'input': 'single', 'title': "标题"}>
    </#if>
${""?left_pad(indent)}  <li class="list-group-item">
    <#if field.input?? && field.input == 'bool'>
${""?left_pad(indent)}    <div class="full-width d-flex" style="margin-bottom: -9px; margin-top: -3px;">
${""?left_pad(indent)}      <strong class="font-18" style="line-height: 34px;">${field.title}</strong>
${""?left_pad(indent)}      <div class="switch-item ml-auto">
${""?left_pad(indent)}        <label class="c-switch c-switch-label c-switch-pill c-switch-info mb-0">
${""?left_pad(indent)}          <input class="c-switch-input" value="T" name="${field.title!"标题"}" type="checkbox">
${""?left_pad(indent)}          <span class="c-switch-slider" data-checked="是" data-unchecked="否"></span>
${""?left_pad(indent)}        </label>
${""?left_pad(indent)}     </div>
${""?left_pad(indent)}    </div>
    <#elseif field.input?? && field.input == 'successive'>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-18">${field.title!"标题"}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!"标题"}" class="ml-auto position-relative" style="top: 2px;">
${""?left_pad(indent)}        <i class="fas fa-star mx-1" style="font-size: 22px;"></i>
${""?left_pad(indent)}        <i class="fas fa-star mx-1" style="font-size: 22px;"></i>
${""?left_pad(indent)}        <i class="fas fa-star mx-1" style="font-size: 22px;"></i>
${""?left_pad(indent)}        <i class="fas fa-star mx-1" style="font-size: 22px;"></i>
${""?left_pad(indent)}        <i class="fas fa-star mx-1" style="font-size: 22px;"></i>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#elseif field.input?? && field.input == 'multiple'>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-18">${field.title!"标题"}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!"标题"}" class="ml-auto position-relative" style="top: 2px;">
${""?left_pad(indent)}        <i class="fas fa-apple-alt font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-baseball-ball font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-coffee font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-smoking font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-bed font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-poop font-24 mx-1"></i>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#elseif field.input?? && field.input == 'ruler'>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-18">${field.title!"标题"}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!"标题"}" class="ml-auto position-relative">
${""?left_pad(indent)}        <span style="font-size: 24px; color: var(--color-primary);"></span>
${""?left_pad(indent)}        <span style="font-size: 12px; color: var(--color-primary);">${field.unit!""}</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#else>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-18">${field.title!"标题"}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!"标题"}" class="ml-auto position-relative" style="top: 2px;">
${""?left_pad(indent)}        <i class="fas fa-sad-cry font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-frown font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-meh font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-smile font-24 mx-1"></i>
${""?left_pad(indent)}        <i class="fas fa-laugh-beam font-24 mx-1"></i>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </li>
  </#list>
${""?left_pad(indent)}</ul>
</#macro>

<#macro print_html_declare_readonlyform widget indent></#macro>

<#macro print_html_declare_chart widget indent></#macro>

<#macro print_html_declare_staticimage widget indent>
${""?left_pad(indent)}<div class="d-flex full-width overflow-hidden" style="<#if widget.style??>${widget.style}</#if>">
${""?left_pad(indent)}  <img src="/img/placeholder/300x450.png" class="m-auto" style="height: 100%;">
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_textbuttons widget indent>
${""?left_pad(indent)}<div class="full-width text-center">
  <#list widget.buttons![] as button>
${""?left_pad(indent)}  <button class="btn my-3"
${""?left_pad(indent)}          style="background: ${button.backgroundColor!'black'};
${""?left_pad(indent)}                 height: 48px
${""?left_pad(indent)}                 line-height: 48px;
${""?left_pad(indent)}                 color: ${button.foregroundColor!'#fff'};
${""?left_pad(indent)}                 font-size: ${widget['fontSize']!'18px'};
${""?left_pad(indent)}                 width: ${widget['buttonWidth']!'75%'};">${button.title!"todo"}</button>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_blankcard widget indent>
<@print_string_line_by_line text=widget.html!"" indent=indent />
</#macro>

<#macro print_html_declare_avatar widget indent>
${""?left_pad(indent)}<div class="d-flex full-width height-200">
${""?left_pad(indent)}  <img widget-id="image${js.nameType(widget.variable!"todo")}" class="avatar avatar-128 m-auto" src="/img/placeholder/128x128.png">
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_notification widget indent>
${""?left_pad(indent)}<div class="marquee" style="line-height: 24px;">
${""?left_pad(indent)}  <span class="material-icons mx-2 font-24 text-danger">campaign</span>
${""?left_pad(indent)}  <span class="marquee-message font-12">${widget.title}</span>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_themetitle widget indent>
${""?left_pad(indent)}<div class="d-flex full-width px-2">
${""?left_pad(indent)}  <strong>${widget.title!"标题"}</strong>
  <#if widget.more?? && widget.more == true>
${""?left_pad(indent)}  <a widget-id="buttoMore${js.nameType(widget.variable)}" class="btn-link ml-auto small">更多...</a>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_searchbox widget indent>
${""?left_pad(indent)}<div class="d-flex full-width">
${""?left_pad(indent)}  <input type="text" name="search${js.nameType(widget.variable)}" readonly placeholder="搜索..."
${""?left_pad(indent)}         style="width: 100%;border: 3px solid var(--color-primary); border-right: none; padding: 5px; height: 36px; outline: none; color: #9DBFAF; border-radius: unset!important;">
${""?left_pad(indent)}  <button style="width: 40px; height: 36px; border: 1px solid var(--color-primary); background: var(--color-primary);text-align: center; color: #fff; display: flex; justify-content: center; align-items: center;">
${""?left_pad(indent)}    <i class="fa fa-search position-relative font-18"></i>
${""?left_pad(indent)}  </button>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_chatpage widget indent>
${""?left_pad(indent)}<div class="ab-chat">
${""?left_pad(indent)}  <div class="contact bar d-flex">
${""?left_pad(indent)}    <div class="name">某某人</div>
${""?left_pad(indent)}    <div class="seen">某某职位</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="conversation">
${""?left_pad(indent)}    <div class="time" style="font-size: 12px;">2022年08月21日 13:28</div>
${""?left_pad(indent)}    <div class="messages outgoing">
${""?left_pad(indent)}      <div class="message">你好，某某人</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="time" style="font-size: 12px;">2022年08月21日 13:31</div>
${""?left_pad(indent)}    <div class="messages incoming">
${""?left_pad(indent)}      <div class="message">很好，这是你的图片</div>
${""?left_pad(indent)}      <div class="message">
${""?left_pad(indent)}        <img mode="aspectfill" src="https://via.placeholder.com/120x80" style="width: 120px; height: 80px;"/>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="time" style="font-size: 12px;">2022年08月21日 13:33</div>
${""?left_pad(indent)}    <div class="messages outgoing">
${""?left_pad(indent)}      <div class="message">
${""?left_pad(indent)}        <div class="voice">
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="typebar">
${""?left_pad(indent)}    <i class="fas fa-plus-circle font-24 mr-2 ml-2"></i>
${""?left_pad(indent)}    <input confirm-type="send"></input>
${""?left_pad(indent)}    <i class="fas fa-paper-plane font-24 mr-2"></i>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_html_declare_videopage widget indent>
${""?left_pad(indent)}<div class="ab-chat">
${""?left_pad(indent)}  <div class="contact bar d-flex">
${""?left_pad(indent)}    <div class="name">某某人</div>
${""?left_pad(indent)}    <div class="seen">某某职位</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="conversation">
${""?left_pad(indent)}    <div class="time" style="font-size: 12px;">2022年08月21日 13:28</div>
${""?left_pad(indent)}    <div class="messages outgoing">
${""?left_pad(indent)}      <div class="message">你好，某某人</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="time" style="font-size: 12px;">2022年08月21日 13:31</div>
${""?left_pad(indent)}    <div class="messages incoming">
${""?left_pad(indent)}      <div class="message">很好，这是你的图片</div>
${""?left_pad(indent)}      <div class="message">
${""?left_pad(indent)}        <img mode="aspectfill" src="https://via.placeholder.com/120x80" style="width: 120px; height: 80px;"/>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="time" style="font-size: 12px;">2022年08月21日 13:33</div>
${""?left_pad(indent)}    <div class="messages outgoing">
${""?left_pad(indent)}      <div class="message">
${""?left_pad(indent)}        <div class="voice">
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}          <div class="bar"></div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="typebar">
${""?left_pad(indent)}    <i class="fas fa-plus-circle font-24 mr-2 ml-2"></i>
${""?left_pad(indent)}    <input confirm-type="send"></input>
${""?left_pad(indent)}    <i class="fas fa-paper-plane font-24 mr-2"></i>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_js_init_gridview widget indent>
${""?left_pad(indent)}this.grid${js.nameType(widget.variable)} = new GridView({
${""?left_pad(indent)}  emptyHtml: `
${""?left_pad(indent)}    <div class="d-flex flex-wrap mt-2">
${""?left_pad(indent)}      <img class="m-auto" src="img/nodata.png" width="60%">
${""?left_pad(indent)}      <div style="flex-basis: 100%; height: 0;"></div>
${""?left_pad(indent)}      <div class="text-muted m-auto mt-2" style="font-weight: bold;">没有任何数据</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  `,
${""?left_pad(indent)}  url: ${app.name}.URL_${(widget.urlData!(page.uri + '_' + widget.variable))?replace('/', '_')?upper_case},
${""?left_pad(indent)}  idField: '${js.nameVariable(widget.variable)}Id',
${""?left_pad(indent)}  create: (idx, row) => {
${""?left_pad(indent)}    let ret = dom.templatize(`
<#if !widget.tile??>
${""?left_pad(indent)}      <div class="d-flex align-items-center full-width" style="padding: 8px 16px; width: 100%;">
${""?left_pad(indent)}        <img class="avatar" src="{{${widget.varAvatar!'avatar'}}}">
${""?left_pad(indent)}        <div class="pl-2">
${""?left_pad(indent)}          <strong>{{${widget.varPrimary!'primary'}}}</strong>
${""?left_pad(indent)}          <div class="small text-muted">{{${widget.varSecondary!'secondary'}}}</div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}        <div class="font-13 tag-success pointer position-relative ml-auto" style="top: 4px;">
${""?left_pad(indent)}          <span>{{${widget.varTertiary!'tertiary'}}}</span>
${""?left_pad(indent)}          <div class="tag-success-after"></div>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
<#else>
<@print_string_line_by_line text=widget.tile indent=indent+6 />
</#if>
${""?left_pad(indent)}    `, row);
${""?left_pad(indent)}    dom.bind(ret, 'click', ev => {
<#if widget.urlDetail??>
${""?left_pad(indent)}      kuim.navigateTo('mhtml/${widget.urlDetail?replace(app.name + '/', "")}.html', {
${""?left_pad(indent)}        title: '这是标题',
${""?left_pad(indent)}      });
</#if>
${""?left_pad(indent)}    });
${""?left_pad(indent)}    return ret;
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}this.grid${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
</#macro>

<#macro print_js_init_timeline widget indent>
${""?left_pad(indent)}this.timeline${js.nameType(widget.variable)} = new Timeline({
${""?left_pad(indent)}  url: ${app.name}.URL_${(widget.urlData!"todo")?replace('/', '_')?upper_case},
${""?left_pad(indent)}  params: {
${""?left_pad(indent)}    _order_by: 'reportTime desc',
${""?left_pad(indent)}  },
${""?left_pad(indent)}  title: (row, index) => {
${""?left_pad(indent)}    return moment(row.reportTime).format('YYYY年MM月DD日');
${""?left_pad(indent)}  },
${""?left_pad(indent)}  subtitle: (row, index) => {
${""?left_pad(indent)}
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}this.timeline${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
</#macro>

<#macro print_js_init_formlayout widget indent>
  <#assign fields = []>
  <#if widget.managedObject??>
    <#list widget.managedObject.fields as field>
      <#assign input = field.properties.input!'none'>
      <#if input != 'none'>
        <#assign fields = fields + [field]>
      </#if>
    </#list>
  <#else>
    <#assign fields = widget.fields>
  </#if>
${""?left_pad(indent)}this.form${js.nameType(widget.variable)} = new MobileForm({
${""?left_pad(indent)}  fields:[{
<#list fields as field>
  <#if field?index != 0>
${""?left_pad(indent)}  },{
  </#if>
  <#assign input = field.properties.input!'none'>
  <#if field.name??>
    <#assign fieldName = field.name?substring(0, field.name?index_of('@'))>
    <#assign objectName = field.name?substring(field.name?index_of('@') + 1)>
  <#else>
    <#assign fieldName = field.properties.title>
    <#assign objectName = widget.variable>
  </#if>
  <#if input == 'select'>
${""?left_pad(indent)}    title: '${field.properties.title}',
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
${""?left_pad(indent)}    input: 'select',
${""?left_pad(indent)}    url: '/api/v3/common/script/stdbiz/gb/${fieldName}/find',
${""?left_pad(indent)}    valueField: '${js.nameVariable(fieldName)}Code',
${""?left_pad(indent)}    textField: '${js.nameVariable(fieldName)}Name',
  <#elseif input == 'date' || input == 'datetime'>
${""?left_pad(indent)}    title: '${field.properties.title}',
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
${""?left_pad(indent)}    input: 'date',
  <#elseif input == 'id'>
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
${""?left_pad(indent)}    input: 'hidden',
  <#else>
${""?left_pad(indent)}    title: '${field.properties.title}',
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
  </#if>
</#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.form${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
</#macro>

<#macro print_js_init_readonlyform widget indent>
<#assign fields = []>
<#list widget.managedObject.fields as field>
  <#assign input = field.properties.input!'none'>
  <#if input != 'none'>
    <#assign fields = fields + [field]>
  </#if>
</#list>
${""?left_pad(indent)}this.form${js.nameType(widget.variable)} = new MobileForm({
${""?left_pad(indent)}  readonly: true,
${""?left_pad(indent)}  fields:[{
<#list fields as field>
  <#if field?index != 0>
${""?left_pad(indent)}  },{
  </#if>
  <#assign input = field.properties.input!'none'>
  <#assign fieldName = field.name?substring(0, field.name?index_of('@'))>
  <#assign objectName = field.name?substring(field.name?index_of('@') + 1)>
  <#if input == 'select'>
${""?left_pad(indent)}    title: '${field.properties.title}',
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
${""?left_pad(indent)}    input: 'select',
${""?left_pad(indent)}    url: '/api/v3/common/script/stdbiz/gb/${fieldName}/find',
${""?left_pad(indent)}    valueField: '${js.nameVariable(fieldName)}Code',
${""?left_pad(indent)}    textField: '${js.nameVariable(fieldName)}Name',
  <#elseif input == 'date' || input == 'datetime'>
${""?left_pad(indent)}    title: '${field.properties.title}',
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
${""?left_pad(indent)}    input: 'date',
  <#elseif input == 'id'>
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
${""?left_pad(indent)}    input: 'hidden',
  <#else>
${""?left_pad(indent)}    title: '${field.properties.title}',
${""?left_pad(indent)}    name: '${js.nameVariable(fieldName)}',
  </#if>
</#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.form${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
</#macro>

<#macro print_js_init_searchbox widget indent>
${""?left_pad(indent)}dom.bind(this.search${js.nameType(widget.variable!"todo")}, 'click', ev => {
${""?left_pad(indent)}  kuim.navigateTo('mhtml/common/search.html?', {
${""?left_pad(indent)}    title: '搜索',
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#macro>

<#--
 ###
 ### 参照桌面应用改写的手机应用渲染方式。
 ###
 ### 2023年5月25日
 ###
 -->
<#macro print_js_declare_formlayout widget indent>
  <#if !widget.customForm??><#return></#if>
  <#assign customForm = widget.customForm>
  <#assign existingFields = {}>
  <#assign fieldIndex = 0>
${""?left_pad(indent)}this.form${js.nameType(widget["variable"])} = new MobileForm({
${""?left_pad(indent)}  fields: [{
  <#list customForm["fields"] as field>
    <#assign input = field["input"]!'text'>
    <#if field["identifiable"]!false><#continue></#if>
    <#if input == 'none'><#continue></#if>
<#--    <#assign fieldName = java.nameVariable(field["name"]?substring(0, field["name"]?index_of('@')))>-->
    <#assign fieldName = field["name"]!field["title"]>
    <#if existingFields[fieldName]??><#continue></#if>
    <#assign existingFields = existingFields + {fieldName: field}>
    <#if fieldIndex != 0>
${""?left_pad(indent)}  },{
    </#if>
${""?left_pad(indent)}    title: '${(field["title"]!"")?trim}',
${""?left_pad(indent)}    name: '${fieldName?trim}',
${""?left_pad(indent)}    required: <#if field["required"]!false == true>true<#else>false</#if>,
    <#if input == 'select'>
${""?left_pad(indent)}    input: 'select',
${""?left_pad(indent)}    options: {
${""?left_pad(indent)}      placeholder: '请选择',
${""?left_pad(indent)}      searchable: false,
${""?left_pad(indent)}      values: [],
${""?left_pad(indent)}      fields: {value: "", text: ""},
${""?left_pad(indent)}    },
    <#elseif input == 'radio'>
${""?left_pad(indent)}    input: 'radio',
${""?left_pad(indent)}    options: {
${""?left_pad(indent)}      values: [{
${""?left_pad(indent)}        value: 'A', text: '单选A', checked: true,
${""?left_pad(indent)}      },{
${""?left_pad(indent)}        value: 'B', text: '单选B',
${""?left_pad(indent)}      }]
${""?left_pad(indent)}    },
    <#elseif input == 'check'>
${""?left_pad(indent)}    input: 'check',
${""?left_pad(indent)}    options: {
${""?left_pad(indent)}      values: [{
${""?left_pad(indent)}        value: 'A', text: '复选A',
${""?left_pad(indent)}      },{
${""?left_pad(indent)}        value: 'B', text: '复选B',
${""?left_pad(indent)}      }]
${""?left_pad(indent)}    },
    <#elseif input == 'attachment'>
${""?left_pad(indent)}    input: 'file',
    <#else>
${""?left_pad(indent)}    input: '${field.input!'text'}',
    </#if>
    <#if field.unit?? && field.unit?trim != "">
${""?left_pad(indent)}    unit: '${field.unit}',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.form${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])});
</#macro>

<#macro print_js_declare_styledform widget indent>
  <#if !widget.customStyled??><#return></#if>
  <#list widget.customStyled.fields as field>
    <#if field.input == 'single'>
${""?left_pad(indent)}this['${field.title}'].querySelectorAll('i').forEach((el, idx) => {
${""?left_pad(indent)}  dom.bind(el, 'click', ev => {
${""?left_pad(indent)}    this['${field.title}'].querySelectorAll('i').forEach((el, idx) => {
${""?left_pad(indent)}      el.style.color = 'unset';
${""?left_pad(indent)}    });
${""?left_pad(indent)}    el.style.color = 'var(--color-primary)';
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
    <#elseif field.input == 'successive'>
${""?left_pad(indent)}this['${field.title}'].querySelectorAll('i').forEach((el, idx) => {
${""?left_pad(indent)}  dom.bind(el, 'click', ev => {
${""?left_pad(indent)}    this['${field.title}'].querySelectorAll('i').forEach((el, idx) => {
${""?left_pad(indent)}      el.style.color = 'unset';
${""?left_pad(indent)}    });
${""?left_pad(indent)}    let icons = this['${field.title}'].querySelectorAll('i');
${""?left_pad(indent)}    for (let i = 0; i < icons.length; i++) {
${""?left_pad(indent)}      if (i <= idx) icons[i].style.color = 'var(--color-primary)';
${""?left_pad(indent)}    }
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
    <#elseif field.input == 'multiple'>
${""?left_pad(indent)}this['${field.title}'].querySelectorAll('i').forEach((el) => {
${""?left_pad(indent)}  dom.bind(el, 'click', ev => {
${""?left_pad(indent)}    if (el.style.color != 'var(--color-primary)') {
${""?left_pad(indent)}      el.style.color = 'var(--color-primary)';
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      el.style.color = 'unset';
${""?left_pad(indent)}    }
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
    <#elseif field.input == 'ruler'>
${""?left_pad(indent)}dom.bind(this['${field.title}'].parentElement, 'click', ev => {
${""?left_pad(indent)}  new PopupRuler({
${""?left_pad(indent)}    unit: 'kg',
${""?left_pad(indent)}    range: [1, 300],
${""?left_pad(indent)}    value: 60,
${""?left_pad(indent)}    success: res => {
${""?left_pad(indent)}      this['${field.title}'].children[0].innerText = res;
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }).show(this.page);
${""?left_pad(indent)}});
    </#if>

  </#list>
</#macro>


<#macro print_js_declare_readonlyform widget indent>
  <#if !widget.customReadonly??><#return></#if>
  <#assign customReadonly = widget.customReadonly>
  <#assign existingFields = {}>
  <#assign fieldIndex = 0>
${""?left_pad(indent)}this.form${js.nameType(widget["variable"])} = new MobileForm({
${""?left_pad(indent)}  readonly: true,
${""?left_pad(indent)}  fields: [{
  <#list customReadonly["fields"] as field>
    <#assign input = field["input"]!'text'>
    <#if field["identifiable"]!false><#continue></#if>
    <#if input == 'none'><#continue></#if>
<#--    <#assign fieldName = java.nameVariable(field["name"]?substring(0, field["name"]?index_of('@')))>-->
    <#assign fieldName = field["name"]!field["title"]>
    <#if existingFields[fieldName]??><#continue></#if>
    <#assign existingFields = existingFields + {fieldName: field}>
    <#if fieldIndex != 0>
${""?left_pad(indent)}  },{
    </#if>
${""?left_pad(indent)}    title: '${field["title"]!""}',
${""?left_pad(indent)}    name: '${fieldName}',
${""?left_pad(indent)}    required: <#if field["required"]!false == true>true<#else>false</#if>,
    <#if input == 'select'>
${""?left_pad(indent)}    input: 'select',
${""?left_pad(indent)}    options: {
${""?left_pad(indent)}      placeholder: '请选择',
${""?left_pad(indent)}      searchable: false,
${""?left_pad(indent)}      values: [],
${""?left_pad(indent)}      fields: {value: "", text: ""},
${""?left_pad(indent)}    },
    <#elseif input == 'attachment'>
${""?left_pad(indent)}    input: 'file',
    <#else>
${""?left_pad(indent)}    input: '${field.input!'text'}',
    </#if>
    <#if field.unit?? && field.unit?trim != "">
${""?left_pad(indent)}    unit: '${field.unit}',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.form${js.nameType(widget["variable"])}.render(this.widget${js.nameType(widget["variable"])});
</#macro>

<#macro print_js_declare_listview widget indent>
  <#assign tile = widget.tile!{}>
  <#assign fields = tile.fields!{}>
  <#assign primary = fields.primary!'primary'>
  <#assign secondary = fields.secondary!'secondary'>
  <#assign tertiary = fields.tertiary!'tertiary'>
  <#assign quaternary = fields.quaternary!'quaternary'>
  <#assign image = fields.image!'image'>
  <#assign status = fields.status!'status'>
${""?left_pad(indent)}
${""?left_pad(indent)}let ${js.nameVariable(widget["variable"]!"todo")}Data = [];
  <#if widget.uri??>
${""?left_pad(indent)}${js.nameVariable(widget["variable"]!"todo")}Data = await xhr.promise({
${""?left_pad(indent)}  url: '/api/v3/common/script/${widget['uri']!"todo"}/find',
${""?left_pad(indent)}  params: {
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
  </#if>
${""?left_pad(indent)}${js.nameVariable(widget["variable"]!"todo")}Data = [{
${""?left_pad(indent)}  ${primary}: '主要内容',
${""?left_pad(indent)}  ${secondary}: '次要内容',
${""?left_pad(indent)}  ${tertiary}: '再次内容',
${""?left_pad(indent)}  ${quaternary}: '最次内容',
${""?left_pad(indent)}  ${image}: '/img/user.png',
${""?left_pad(indent)}  ${status}: '<i class="fas fa-arrow-right"></i>',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  ${primary}: '主要内容',
${""?left_pad(indent)}  ${secondary}: '次要内容',
${""?left_pad(indent)}  ${tertiary}: '再次内容',
${""?left_pad(indent)}  ${quaternary}: '最次内容',
${""?left_pad(indent)}  ${image}: '/img/user.png',
${""?left_pad(indent)}  ${status}: '<i class="fas fa-arrow-right"></i>',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  ${primary}: '主要内容',
${""?left_pad(indent)}  ${secondary}: '次要内容',
${""?left_pad(indent)}  ${tertiary}: '再次内容',
${""?left_pad(indent)}  ${quaternary}: '最次内容',
${""?left_pad(indent)}  ${image}: '/img/user.png',
${""?left_pad(indent)}  ${status}: '<i class="fas fa-arrow-right"></i>',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  ${primary}: '主要内容',
${""?left_pad(indent)}  ${secondary}: '次要内容',
${""?left_pad(indent)}  ${tertiary}: '再次内容',
${""?left_pad(indent)}  ${quaternary}: '最次内容',
${""?left_pad(indent)}  ${image}: '/img/user.png',
${""?left_pad(indent)}  ${status}: '<i class="fas fa-arrow-right"></i>',
${""?left_pad(indent)}}];
${""?left_pad(indent)}
${""?left_pad(indent)}this.list${js.nameType(widget["variable"]!"todo")} = new ListView({
${""?left_pad(indent)}  local: ${js.nameVariable(widget["variable"]!"todo")}Data,
${""?left_pad(indent)}  emptyHtml: `
${""?left_pad(indent)}    <div class="d-flex flex-wrap mt-2">
${""?left_pad(indent)}      <img class="m-auto" src="img/nodata.png" width="60%">
${""?left_pad(indent)}      <div style="flex-basis: 100%; height: 0;"></div>
${""?left_pad(indent)}      <div class="text-muted m-auto mt-2" style="font-weight: bold;">没有任何数据</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  `,
${""?left_pad(indent)}  create: (idx, row) => {
${""?left_pad(indent)}    let ret = dom.templatize(`
${tile.html!'<div></div>'}
${""?left_pad(indent)}    `, row);
  <#if widget.url??>
${""?left_pad(indent)}    dom.bind(ret, 'click', ev => {
${""?left_pad(indent)}      kuim.navigateTo('mhtml/${widget.url!"todo"}.html', {
${""?left_pad(indent)}        title: '这是标题',
${""?left_pad(indent)}      });
${""?left_pad(indent)}    });
  </#if>
${""?left_pad(indent)}    return ret;
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}this.list${js.nameType(widget.variable)}.render(this.widget${js.nameType(widget.variable)});
</#macro>

<#macro print_js_declare_cyclenavigator widget indent>
${""?left_pad(indent)}this.swiper${js.nameType(widget.variable)} = new Swiper(this.widgetSwiper${js.nameType(widget.variable)}, {
${""?left_pad(indent)}  direction: 'horizontal',
${""?left_pad(indent)}  loop: true,
${""?left_pad(indent)}});
</#macro>

<#macro print_js_declare_scrollnavigator widget indent>
${""?left_pad(indent)}this.swiper${js.nameType(widget.variable)} = new Swiper(this.widgetSwiper${js.nameType(widget.variable)}, {
${""?left_pad(indent)}  slidesPerView: 'auto',
${""?left_pad(indent)}  spaceBetween: 15,
${""?left_pad(indent)}  slidesPerView: 3,
${""?left_pad(indent)}  centeredSlides: false,
${""?left_pad(indent)}  loop: true,
${""?left_pad(indent)}  noSwiping: true,
${""?left_pad(indent)}});
</#macro>

<#macro print_js_declare_gridnavigator widget indent>
<#list widget.items as item>
  <#if !item.title?? || item.title == ""><#continue></#if>
${""?left_pad(indent)}dom.bind(this.button${js.nameType(item.url!"todo")}, 'click', ev => {
${""?left_pad(indent)}  kuim.navigateTo('mhtml/${(item.url!"todo")}.html?', {
${""?left_pad(indent)}    title: '${item.title}',
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#list>
</#macro>

<#macro print_js_declare_listnavigator widget indent>
  <#list widget.items as item>
${""?left_pad(indent)}dom.bind(this.button${js.nameType(item.url!"todo")}, 'click', ev => {
${""?left_pad(indent)}  kuim.navigateTo('mhtml/${(item.url!"todo")}.html?', {
${""?left_pad(indent)}    title: '${item.title!"标题"}',
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
  </#list>
</#macro>

<#macro print_js_declare_tabnavigator widget indent>
${""?left_pad(indent)}this.tabs${js.nameType(widget.variable!"todo")} = new Tabs({
${""?left_pad(indent)}  lazy: true,
${""?left_pad(indent)}  autoClear: true,
${""?left_pad(indent)}  navigatorId: this.widgetNavigator${js.nameType(widget.variable)},
${""?left_pad(indent)}  contentId: this.widgetContent${js.nameType(widget.variable)},
${""?left_pad(indent)}  tabActiveClass: 'active',
${""?left_pad(indent)}  tabs: [{
  <#list widget.items as item>
    <#if item?index != 0>
${""?left_pad(indent)}  },{
    </#if>
${""?left_pad(indent)}    id: '${item.id}',
${""?left_pad(indent)}    text: '${item.title}',
  <#if item.url??>
${""?left_pad(indent)}    url: 'mhtml/${item.url}.html',
  <#else>
${""?left_pad(indent)}    onClicked: () => {},
  </#if>
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.tabs${js.nameType(widget.variable!"todo")}.render();
</#macro>

<#macro print_js_declare_calendar widget indent>
${""?left_pad(indent)}this.calendar${js.nameType(widget.variable!"todo")} = new Calendar({});
${""?left_pad(indent)}this.calendar${js.nameType(widget.variable!"todo")}.render(this.widget${js.nameType(widget.variable!'calendar')});
</#macro>

<#macro print_js_declare_chart widget indent>
${""?left_pad(indent)}let chart${js.nameType(widget.variable)} = echarts.init(this.widget${js.nameType(widget.variable)});
  <#if widget.chartType == 'PIE'>
${""?left_pad(indent)}let option${js.nameType(widget.variable)} = {
${""?left_pad(indent)}  legend: {
${""?left_pad(indent)}    top: '5%',
${""?left_pad(indent)}    left: 'center'
${""?left_pad(indent)}  },
${""?left_pad(indent)}  series: [{
${""?left_pad(indent)}    name: 'Access From',
${""?left_pad(indent)}    type: 'pie',
${""?left_pad(indent)}    radius: ['40%', '70%'],
${""?left_pad(indent)}    avoidLabelOverlap: false,
${""?left_pad(indent)}    itemStyle: {
${""?left_pad(indent)}      borderRadius: 10,
${""?left_pad(indent)}      borderColor: '#fff',
${""?left_pad(indent)}      borderWidth: 2
${""?left_pad(indent)}    },
${""?left_pad(indent)}    label: {
${""?left_pad(indent)}      show: false,
${""?left_pad(indent)}      position: 'center'
${""?left_pad(indent)}    },
${""?left_pad(indent)}    labelLine: {
${""?left_pad(indent)}      show: false
${""?left_pad(indent)}    },
${""?left_pad(indent)}    data: [
${""?left_pad(indent)}      { value: 1048, name: 'Search Engine' },
${""?left_pad(indent)}      { value: 735, name: 'Direct' },
${""?left_pad(indent)}      { value: 580, name: 'Email' },
${""?left_pad(indent)}      { value: 484, name: 'Union Ads' },
${""?left_pad(indent)}      { value: 300, name: 'Video Ads' }
${""?left_pad(indent)}    ]
${""?left_pad(indent)}  }]
${""?left_pad(indent)}};
  <#elseif widget.chartType == 'BAR'>
${""?left_pad(indent)}let option${js.nameType(widget.variable)} = {
${""?left_pad(indent)}  xAxis: {
${""?left_pad(indent)}    type: 'category',
${""?left_pad(indent)}    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
${""?left_pad(indent)}  },
${""?left_pad(indent)}  yAxis: {
${""?left_pad(indent)}    type: 'value'
${""?left_pad(indent)}  },
${""?left_pad(indent)}  series: [{
${""?left_pad(indent)}    data: [120, 200, 150, 80, 70, 110, 130],
${""?left_pad(indent)}    type: 'bar'
${""?left_pad(indent)}  }]
${""?left_pad(indent)}};
  <#elseif widget.chartType == 'LINE'>
${""?left_pad(indent)}let option${js.nameType(widget.variable)} = {
${""?left_pad(indent)}  title: {
${""?left_pad(indent)}    text: 'Stacked Line'
${""?left_pad(indent)}  },
${""?left_pad(indent)}  legend: {
${""?left_pad(indent)}    data: ['Email', 'Union Ads', 'Video Ads', 'Direct', 'Search Engine']
${""?left_pad(indent)}  },
${""?left_pad(indent)}  grid: {
${""?left_pad(indent)}    left: '3%',
${""?left_pad(indent)}    right: '4%',
${""?left_pad(indent)}    bottom: '3%',
${""?left_pad(indent)}    containLabel: true
${""?left_pad(indent)}  },
${""?left_pad(indent)}  xAxis: {
${""?left_pad(indent)}    type: 'category',
${""?left_pad(indent)}    boundaryGap: false,
${""?left_pad(indent)}    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
${""?left_pad(indent)}  },
${""?left_pad(indent)}  yAxis: {
${""?left_pad(indent)}    type: 'value'
${""?left_pad(indent)}  },
${""?left_pad(indent)}  series: [{
${""?left_pad(indent)}    name: 'Email',
${""?left_pad(indent)}    type: 'line',
${""?left_pad(indent)}    stack: 'Total',
${""?left_pad(indent)}    data: [120, 132, 101, 134, 90, 230, 210]
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    name: 'Union Ads',
${""?left_pad(indent)}    type: 'line',
${""?left_pad(indent)}    stack: 'Total',
${""?left_pad(indent)}    data: [220, 182, 191, 234, 290, 330, 310]
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    name: 'Video Ads',
${""?left_pad(indent)}    type: 'line',
${""?left_pad(indent)}    stack: 'Total',
${""?left_pad(indent)}    data: [150, 232, 201, 154, 190, 330, 410]
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    name: 'Direct',
${""?left_pad(indent)}    type: 'line',
${""?left_pad(indent)}    stack: 'Total',
${""?left_pad(indent)}    data: [320, 332, 301, 334, 390, 330, 320]
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    name: 'Search Engine',
${""?left_pad(indent)}    type: 'line',
${""?left_pad(indent)}    stack: 'Total',
${""?left_pad(indent)}    data: [820, 932, 901, 934, 1290, 1330, 1320]
${""?left_pad(indent)}  }]
${""?left_pad(indent)}};
  </#if>
${""?left_pad(indent)}chart${js.nameType(widget.variable)}.setOption(option${js.nameType(widget.variable)});
</#macro>