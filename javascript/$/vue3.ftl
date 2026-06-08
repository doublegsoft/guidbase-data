<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单校验规则
const ${js.nameVariable(form.id)}Rules = [
  <#list form.inputs as input>  
    <#if input.value("readonly") == "true"><#continue></#if>
  {name: '${js.nameVariable(input.id)}',rules: [<#if input.value("required") == "true">{ type: 'required', message: '${input.title}必须填写！' },</#if><#if input.type == "number">{ type: 'number', message: '请正确输入${input.title}！' }</#if>]},
  </#list>
]
const { errors, validate, clearErrors } = useFieldValidation(${js.nameVariable(form.id)}Rules)
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect") && !(input.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
    <#elseif input.type == "select">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    <#elseif input.type == "cascade">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    </#if>
  </#list>
const showConfirm${js.nameType(form.id)}Reset = ref(false)
const show${js.nameType(form.id)}Error = ref(false)
const validationErrorMessage = ref('')
</#macro>

<#macro print_entry_form_methods form indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(form.id)}Data = async () => {
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(form.id)}Data()
    Object.assign(${js.nameVariable(form.id)}Data, data)
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isLoading.value = false
  }
}

/**
 * 保存数据的界面函数
 */
const save${js.nameType(form.id)}Data = async () => {
  if (!validate(demoEntryData)) {
    const msgs = Object.entries(errors)
      .filter(([, msg]) => msg)
      .map(([, msg]) => `· ${r"${msg}"}`)
    validationErrorMessage.value = msgs.join('\n')
    show${js.nameType(form.id)}Error.value = true
    return
  }
  isSubmitting.value = true
  try {
    // const result = await saveUserDataApi(${js.nameVariable(form.id)}Data)
    // if (result.success) {
    //   alert('用户信息保存成功！')
    // }
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isSubmitting.value = false
  }
}

const { loading: isSubmitting, run: handle${js.nameType(form.id)}Save } = useAsyncLock(save${js.nameType(form.id)}Data)
</#macro>

<#macro print_layout_entry_form form indent=0>
  <#local cols = form.value("cols")!"3">
  <#local groups = form.groups()>
${""?left_pad(indent)}<div id="entry${js.nameType(form.id)}">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}    <div class="${namespace}-form ${namespace}-form--${cols}">
    <#list rows as row>
      <#list row as child>
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if>">${child.title}</label>
<@print_layout_widget widget=child indent=indent+8 />
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>    
${""?left_pad(indent)}  </div>  
  </#list>
${""?left_pad(indent)}</div>
${""?left_pad(indent)}<${namespace}-feedback v-model="showConfirm${js.nameType(form.id)}Reset" type="confirm" title="提示" message="确定要重置吗？所有已填写的数据将被清空。" @confirm="handle${js.nameType(form.id)}Reset" />
${""?left_pad(indent)}<${namespace}-feedback v-model="show${js.nameType(form.id)}Error" type="error" title="${form.title}校验未通过" :message="validationErrorMessage" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_official_form_variables form indent=0>
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单校验规则
const ${js.nameVariable(form.id)}Rules = [
  <#list form.inputs as input>  
    <#if input.value("readonly") == "true"><#continue></#if>
  {name: '${js.nameVariable(input.id)}',rules: [<#if input.value("required") == "true">{ type: 'required', message: '${input.title}必须填写！' },</#if><#if input.type == "number">{ type: 'number', message: '请正确输入${input.title}！' }</#if>]},
  </#list>
]
const { errors, validate, clearErrors } = useFieldValidation(${js.nameVariable(form.id)}Rules)
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect") && !(input.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
    <#elseif input.type == "select">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    <#elseif input.type == "cascade">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    </#if>
  </#list>
const showConfirm${js.nameType(form.id)}Reset = ref(false)
const show${js.nameType(form.id)}Error = ref(false)
const validationErrorMessage = ref('')
</#macro>

<#macro print_layout_official_form form indent>
  <#local cols = form.value("cols")!"3">
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
<#--  ${""?left_pad(indent)}    
${""?left_pad(indent)}      <tr>
${""?left_pad(indent)}        <td class="${namespace}-of__label ${namespace}-of__required">项目名称</td>
${""?left_pad(indent)}        <td colspan="3">
${""?left_pad(indent)}          <input
${""?left_pad(indent)}            type="text"
${""?left_pad(indent)}            class="${namespace}-of__input"
${""?left_pad(indent)}            :placeholder="readonly ? '' : '请输入项目全称（需与合同保持一致）'"
${""?left_pad(indent)}            :value="form.projectName"
${""?left_pad(indent)}            :readonly="readonly"
${""?left_pad(indent)}            @input="updateField('projectName', $event.target.value)"
${""?left_pad(indent)}          >
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}        <td class="${namespace}-of__label ${namespace}-of__required">预算年度</td>
${""?left_pad(indent)}        <td>
${""?left_pad(indent)}          <select
${""?left_pad(indent)}            class="${namespace}-of__select"
${""?left_pad(indent)}            :value="form.budgetYear"
${""?left_pad(indent)}            :disabled="readonly"
${""?left_pad(indent)}            @change="updateField('budgetYear', $event.target.value)"
${""?left_pad(indent)}          >
${""?left_pad(indent)}            <option v-for="y in budgetYearOptions" :key="y" :value="y">{{ y }}年度</option>
${""?left_pad(indent)}          </select>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}      </tr>
${""?left_pad(indent)}      <tr>
${""?left_pad(indent)}        <td class="${namespace}-of__label">项目类别</td>
${""?left_pad(indent)}        <td>
${""?left_pad(indent)}          <select
${""?left_pad(indent)}            class="${namespace}-of__select"
${""?left_pad(indent)}            :value="form.projectCategory"
${""?left_pad(indent)}            :disabled="readonly"
${""?left_pad(indent)}            @change="updateField('projectCategory', $event.target.value)"
${""?left_pad(indent)}          >
${""?left_pad(indent)}            <option v-for="opt in categoryOptions" :key="opt.value" :value="opt.value">{{ opt.label }}</option>
${""?left_pad(indent)}          </select>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}        <td class="${namespace}-of__label">资金来源</td>
${""?left_pad(indent)}        <td>
${""?left_pad(indent)}          <select
${""?left_pad(indent)}            class="${namespace}-of__select"
${""?left_pad(indent)}            :value="form.fundingSource"
${""?left_pad(indent)}            :disabled="readonly"
${""?left_pad(indent)}            @change="updateField('fundingSource', $event.target.value)"
${""?left_pad(indent)}          >
${""?left_pad(indent)}            <option v-for="opt in fundingOptions" :key="opt.value" :value="opt.value">{{ opt.label }}</option>
${""?left_pad(indent)}          </select>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}        <td class="${namespace}-of__label ${namespace}-of__required">申报金额(元)</td>
${""?left_pad(indent)}        <td>
${""?left_pad(indent)}          <input
${""?left_pad(indent)}            type="number"
${""?left_pad(indent)}            class="${namespace}-of__input ${namespace}-of__input--amount"
${""?left_pad(indent)}            :value="form.amount"
${""?left_pad(indent)}            :readonly="readonly"
${""?left_pad(indent)}            @input="updateField('amount', Number($event.target.value))"
${""?left_pad(indent)}          >
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}      </tr>
${""?left_pad(indent)}      <tr>
${""?left_pad(indent)}        <td class="${namespace}-of__label ${namespace}-of__required">立项申请原因及主要内容简述</td>
${""?left_pad(indent)}        <td colspan="5" style="padding: 0;">
${""?left_pad(indent)}          <textarea
${""?left_pad(indent)}            class="${namespace}-of__textarea"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly }"
${""?left_pad(indent)}            :placeholder="readonly ? '' : '请详细填写：1.立项背景；2.要解决的具体业务痛点；3.预期达到的量化指标。'"
${""?left_pad(indent)}            :value="form.reason"
${""?left_pad(indent)}            :readonly="readonly"
${""?left_pad(indent)}            @input="updateField('reason', $event.target.value)"
${""?left_pad(indent)}          ></textarea>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}      </tr>
${""?left_pad(indent)}      <tr>
${""?left_pad(indent)}        <td class="${namespace}-of__label">预算明细清单</td>
${""?left_pad(indent)}        <td colspan="5" style="padding: 5px;">
${""?left_pad(indent)}          <table class="${namespace}-of__sub-table">
${""?left_pad(indent)}            <thead>
${""?left_pad(indent)}              <tr>
${""?left_pad(indent)}                <th style="width: 5%;">序号</th>
${""?left_pad(indent)}                <th style="width: 25%;">费用明细项目</th>
${""?left_pad(indent)}                <th style="width: 15%;">单价(元)</th>
${""?left_pad(indent)}                <th style="width: 10%;">数量</th>
${""?left_pad(indent)}                <th style="width: 15%;">估算金额(元)</th>
${""?left_pad(indent)}                <th>备注/品牌规格</th>
${""?left_pad(indent)}                <th v-if="!readonly" style="width: 6%;">操作</th>
${""?left_pad(indent)}              </tr>
${""?left_pad(indent)}            </thead>
${""?left_pad(indent)}            <tbody>
${""?left_pad(indent)}              <tr v-for="(item, idx) in form.budgetItems" :key="idx">
${""?left_pad(indent)}                <td style="text-align: center;">{{ idx + 1 }}</td>
${""?left_pad(indent)}                <td>
${""?left_pad(indent)}                  <input
${""?left_pad(indent)}                    type="text"
${""?left_pad(indent)}                    class="${namespace}-of__input"
${""?left_pad(indent)}                    :value="item.name"
${""?left_pad(indent)}                    :readonly="readonly"
${""?left_pad(indent)}                    @input="updateBudgetItem(idx, 'name', $event.target.value)"
${""?left_pad(indent)}                  >
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}                <td>
${""?left_pad(indent)}                  <input
${""?left_pad(indent)}                    type="number"
${""?left_pad(indent)}                    class="${namespace}-of__input"
${""?left_pad(indent)}                    style="text-align: right;"
${""?left_pad(indent)}                    :value="item.unitPrice"
${""?left_pad(indent)}                    :readonly="readonly"
${""?left_pad(indent)}                    @input="updateBudgetItem(idx, 'unitPrice', Number($event.target.value))"
${""?left_pad(indent)}                  >
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}                <td>
${""?left_pad(indent)}                  <input
${""?left_pad(indent)}                    type="number"
${""?left_pad(indent)}                    class="${namespace}-of__input"
${""?left_pad(indent)}                    style="text-align: center;"
${""?left_pad(indent)}                    :value="item.quantity"
${""?left_pad(indent)}                    :readonly="readonly"
${""?left_pad(indent)}                    @input="updateBudgetItem(idx, 'quantity', Number($event.target.value))"
${""?left_pad(indent)}                  >
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}                <td>
${""?left_pad(indent)}                  <input
${""?left_pad(indent)}                    type="number"
${""?left_pad(indent)}                    class="${namespace}-of__input ${namespace}-of__readonly"
${""?left_pad(indent)}                    style="text-align: right;"
${""?left_pad(indent)}                    :value="calcItemAmount(item)"
${""?left_pad(indent)}                    readonly
${""?left_pad(indent)}                  >
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}                <td>
${""?left_pad(indent)}                  <input
${""?left_pad(indent)}                    type="text"
${""?left_pad(indent)}                    class="${namespace}-of__input"
${""?left_pad(indent)}                    :value="item.remark"
${""?left_pad(indent)}                    :readonly="readonly"
${""?left_pad(indent)}                    @input="updateBudgetItem(idx, 'remark', $event.target.value)"
${""?left_pad(indent)}                  >
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}                <td v-if="!readonly" style="text-align: center;">
${""?left_pad(indent)}                  <button class="${namespace}-of__btn--del" @click="removeBudgetItem(idx)" title="删除行">✕</button>
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}              </tr>
${""?left_pad(indent)}              <tr>
${""?left_pad(indent)}                <td style="text-align: center;">合计</td>
${""?left_pad(indent)}                <td :colspan="readonly ? 3 : 4"></td>
${""?left_pad(indent)}                <td style="text-align: right; font-weight: bold; color: var(--${namespace}-primary);">
${""?left_pad(indent)}                  {{ formatAmount(budgetTotal) }}
${""?left_pad(indent)}                </td>
${""?left_pad(indent)}                <td :colspan="readonly ? 1 : 2">{{ amountChinese }}</td>
${""?left_pad(indent)}              </tr>
${""?left_pad(indent)}            </tbody>
${""?left_pad(indent)}          </table>
${""?left_pad(indent)}          <div v-if="!readonly" style="margin-top: 4px;">
${""?left_pad(indent)}            <button class="${namespace}-of__btn--add" @click="addBudgetItem">＋ 添加明细行</button>
${""?left_pad(indent)}          </div>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}      </tr>
${""?left_pad(indent)}      <tr>
${""?left_pad(indent)}        <td class="${namespace}-of__label">附件上传</td>
${""?left_pad(indent)}        <td colspan="5">
${""?left_pad(indent)}          <div class="${namespace}-of__attach">
${""?left_pad(indent)}            <input
${""?left_pad(indent)}              v-if="!readonly"
${""?left_pad(indent)}              type="file"
${""?left_pad(indent)}              style="font-size: 11px;"
${""?left_pad(indent)}              multiple
${""?left_pad(indent)}              @change="handleFileChange"
${""?left_pad(indent)}            >
${""?left_pad(indent)}            <div v-if="form.attachments.length" class="${namespace}-of__attach-list">
${""?left_pad(indent)}              已传：
${""?left_pad(indent)}              <template v-for="(f, i) in form.attachments" :key="i">
${""?left_pad(indent)}                {{ i > 0 ? '、' : '' }}
${""?left_pad(indent)}                <a href="#" class="${namespace}-of__link" @click.prevent="$emit('download', f)">{{ i + 1 }}. 《{{ f.name }}》</a>
${""?left_pad(indent)}                ({{ formatSize(f.size) }})
${""?left_pad(indent)}              </template>
${""?left_pad(indent)}            </div>
${""?left_pad(indent)}            <div v-else style="color: var(--${namespace}-text-light); font-size: 11px; margin-top: 4px;">暂无附件</div>
${""?left_pad(indent)}          </div>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}      </tr>
${""?left_pad(indent)}      <tr v-for="(op, idx) in form.opinions" :key="idx">
${""?left_pad(indent)}        <td class="${namespace}-of__label">{{ op.label }}</td>
${""?left_pad(indent)}        <td colspan="5" style="padding: 0;">
${""?left_pad(indent)}          <div class="${namespace}-of__opinion">
${""?left_pad(indent)}            <textarea
${""?left_pad(indent)}              class="${namespace}-of__textarea"
${""?left_pad(indent)}              :class="{ '${namespace}-of__readonly': readonly || op.readonly }"
${""?left_pad(indent)}              :placeholder="op.placeholder || ''"
${""?left_pad(indent)}              :value="op.content"
${""?left_pad(indent)}              :readonly="readonly || op.readonly"
${""?left_pad(indent)}              @input="updateOpinion(idx, 'content', $event.target.value)"
${""?left_pad(indent)}            ></textarea>
${""?left_pad(indent)}            <div class="${namespace}-of__opinion-sign">
${""?left_pad(indent)}              {{ op.signLabel }}：<span>{{ op.signer || '　' }}</span> &nbsp;
${""?left_pad(indent)}              日期：<span>{{ op.signDate || '____-__-__' }}</span>
${""?left_pad(indent)}            </div>
${""?left_pad(indent)}          </div>
${""?left_pad(indent)}        </td>
${""?left_pad(indent)}      </tr>  -->
${""?left_pad(indent)}    </table>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_excel_form_variables form indent=0>
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Cols = ref([{
  <#list form.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
    <#if column.id??>
${""?left_pad(indent)}  key:'${js.nameVariable(column.id)}',
    </#if>
${""?left_pad(indent)}  label:'${column.title}',
${""?left_pad(indent)}  type:'${column.type}',      
${""?left_pad(indent)}  width:${column.value("width","120")},

  </#list>
${""?left_pad(indent)}}])
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Rows = ref([])
</#macro>

<#macro print_excel_form_methods form indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(form.id)}Rows = async () => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(form.id)}Rows(0, -1)
    ${js.nameVariable(form.id)}Rows.value = res.data
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_excel_form form indent=0>
${""?left_pad(indent)}<${namespace}-excelform style="flex:1;"
${""?left_pad(indent)}  :columns="${js.nameVariable(form.id)}Cols"
${""?left_pad(indent)}  v-model:data="${js.nameVariable(form.id)}Rows"
${""?left_pad(indent)}  @cell-change="handle${js.nameType(form.id)}CellChange" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->

<#macro print_criteria_form_variables form indent=0>
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect")>
      <#if !(input.value("data")!"")?starts_with("enum[")>    
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      </#if>
    <#elseif input.type == "cascade">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    </#if>
  </#list>
</#macro>

<#macro print_layout_criteria_form form indent=0>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}" class="${namespace}-toolbar">
  <#list form.children as widget>
<@print_layout_widget widget=widget indent=indent+2 />
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_variables form indent=0>
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
</#macro>

<#macro print_display_form_methods form indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(form.id)}Data = async () => {
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(form.id)}Data()
    Object.assign(${js.nameVariable(form.id)}Data, data)
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_display_form form indent=0>
  <#list form.groups() as group>
${""?left_pad(indent)}<div class="${namespace}-panel">
${""?left_pad(indent)}  <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}  <div class="${namespace}-fview ${namespace}-fview--${form.value("cols","3")}">
  <#list form.group(group) as input>
    <#local span = input.value("span","")>
${""?left_pad(indent)}    <div class="${namespace}-fv<#if span != ""> ${namespace}-fv--span${span}</#if>">
${""?left_pad(indent)}      <div class="${namespace}-fv-label">${input.title}</div>
${""?left_pad(indent)}      <div class="${namespace}-fv-val ${namespace}-fv-val--mono">{{ ${js.nameVariable(form.id)}Data.${js.nameVariable(input.id)} }}</div>
${""?left_pad(indent)}    </div>
  </#list>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_variables tabs indent=0>
${""?left_pad(indent)}const tabs${js.nameType(tabs.id)} = [
  <#list tabs.children as tab>
${""?left_pad(indent)}  { key: '${js.nameVariable(tab.id)}',  label: '${tab.title}', badge: '' },
  </#list>
${""?left_pad(indent)}]
${""?left_pad(indent)}const activeTab${js.nameType(tabs.id)} = ref('${js.nameVariable(tabs.children[0].id)}')
${""?left_pad(indent)}const ${js.nameVariable(tabs.id)}Ref = ref(null)
${""?left_pad(indent)}const ${js.nameVariable(tabs.id)}Height = ref('${js.nameVariable(tabs.children[0].id)}')
</#macro>

<#macro print_tabs_methods tabs indent=0>
</#macro>

<#macro print_layout_tabs tabs indent=0>
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
<@print_layout_widget widget=button indent=indent+4 />
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
<@print_layout_widget widget=child indent=indent+4 />
      </#list>
    </#if>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_paged_table_variables table indent=0>
${""?left_pad(indent)}// ${js.nameVariable(table.id)}表格相关变量
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Ref = ref(null)
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Cols = ref([{
  <#list table.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
    <#if column.id??>
${""?left_pad(indent)}  key:'${js.nameVariable(column.id)}',
    </#if>
${""?left_pad(indent)}  title:'${column.title}',      
${""?left_pad(indent)}  width:'${column.value("width","120")}px', 
    <#if column.type == "date">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    <#elseif column.type == "number">
${""?left_pad(indent)}  align: 'right',    
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    <#elseif column.type == "buttons">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: (v, row) => {                                       
${""?left_pad(indent)}    return `
      <#list column.children as button>
<@print_layout_widget widget=button indent=indent+6 />      
      </#list>
${""?left_pad(indent)}    `   
${""?left_pad(indent)}  },    
    <#else>
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    </#if>
  </#list>
${""?left_pad(indent)}}])
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Rows = ref([])
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Total = ref(0)
</#macro>

<#macro print_paged_table_methods table indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(table.id)}Rows = async (pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(table.id)}Rows((pageNumber - 1) * pageSize, pageSize)
    ${js.nameVariable(table.id)}Rows.value = res.data
    ${js.nameVariable(table.id)}Total.value = res.total
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_paged_table table indent=0>
${""?left_pad(indent)}<${namespace}-pagedtable
${""?left_pad(indent)}  ref="${js.nameVariable(table.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  :columns="${js.nameVariable(table.id)}Cols"
${""?left_pad(indent)}  :data="${js.nameVariable(table.id)}Rows"
${""?left_pad(indent)}  :total="${js.nameVariable(table.id)}Total"
${""?left_pad(indent)}  :fetchData="load${js.nameType(table.id)}Rows"
${""?left_pad(indent)}  id-key="personId"
${""?left_pad(indent)}  :row-class-name="getRowClass"
${""?left_pad(indent)}  @selection-change="handleSelection" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTON                                 -->
<!----------------------------------------------------------------------------->

<#function get_button_role button>
  <#if (button.value("action")!"") == "save">
    <#return "primary">
  <#elseif (button.value("action")!"") == "search">
    <#return "primary">  
  <#elseif (button.value("action")!"") == "edit">
    <#return "primary">    
  <#elseif (button.value("action")!"") == "clear">
    <#return "warning">
  <#elseif (button.value("action")!"") == "reset">
    <#return "warning">  
  <#elseif (button.value("action")!"") == "delete">
    <#return "danger">  
  <#elseif (button.value("action")!"") == "cancel">
    <#return "default">
  <#else>
    <#return "default">
  </#if>
</#function>

<#function get_button_method_name button>
  <#local methodName = "handle">
  <#if button.ancestor("entry_form")??>
    <#local ancestor = button.ancestor("entry_form")>
  <#elseif button.ancestor("criteria_form")??>
    <#local ancestor = button.ancestor("criteria_form")>
  </#if>
  <#if methodName == "handle">
    <#if ancestor??>
      <#local methodName += js.nameType(ancestor.id)>
    <#else>
      <#local methodName += js.nameType(button.value("ref"))>
      <#local ancestor = button.page.byId(button.value("ref"))>
    </#if>
  </#if>
  <#if button.id??>
    <#local methodName += js.nameType(button.id)>
  <#else>
    <#local methodName += (js.nameType(button.value("action", "custom")))>  
  </#if>
  <#return methodName>
</#function>

<#macro print_paged_button_methods button indent=0>
  <#if (button.value("action")!"") == "save">
    <#return>
  </#if>
  <#if button.ancestor("entry_form")??>
    <#local ancestor = button.ancestor("entry_form")>
  <#elseif button.ancestor("criteria_form")??>
    <#local ancestor = button.ancestor("criteria_form")>
  </#if>
  <#if !ancestor??>
    <#local ancestor = button.page.byId(button.value("ref"))>
  </#if>
const ${get_button_method_name(button)} = () => {    
  <#if (button.value("action")!"") == "reset">
    <#list ancestor.inputs as input>
  ${js.nameVariable(ancestor.id)}Data.${js.nameVariable(input.id)} = '';
    </#list>
  <#elseif (button.value("action")!"") == "search">
  load${js.nameType(button.value("ref"))}Rows(1, 20)
  </#if>
}
</#macro>

<#macro print_layout_buttons buttons indent=0>
  <#-- bnrlike 模式下，按钮在tab页的右侧 -->
  <#if buttons.ancestor("tabs")??>
    <#return>
  </#if>
${""?left_pad(indent)}<div class="${namespace}-form-footer">
${""?left_pad(indent)}  <div style="margin-left: auto;">
  <#list buttons.children as child>
<@print_layout_widget widget=child indent=indent+4 />
  </#list>    
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_page_imports page indent=0>
  <#local visited_types = {}>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form' || widget.type == 'official_form' || widget.type == "excel_form">
import { useAsyncLock } from '@/composables/useAsyncLock'
import { useFieldValidation } from '@/composables/useFieldValidation'
import ${js.nameType(namespace)}Feedback from '@/components/${namespace}-feedback.vue'
      <#break>
    </#if>
  </#list>  
  <#list page.widgets as widget>
    <#if visited_types[widget.type]??><#continue></#if>
    <#if widget.type == "excel_form">
import ${js.nameType(namespace)}Excelform from '@/components/${namespace}-excelform.vue'
    <#elseif widget.type == "paged_table">
import ${js.nameType(namespace)}Pagedtable from '@/components/${namespace}-pagedtable.vue'
    <#elseif widget.type == "select">
import ${js.nameType(namespace)}Dropdown from '@/components/${namespace}-dropdown.vue'  
    <#elseif widget.type == "date">
import ${js.nameType(namespace)}Datepicker from '@/components/${namespace}-datepicker.vue'  
    <#elseif widget.type == "time">
import ${js.nameType(namespace)}Timepicker from '@/components/${namespace}-timepicker.vue'  
    <#elseif widget.type == "cascade">
import ${js.nameType(namespace)}Cascadepicker from '@/components/${namespace}-cascadepicker.vue'    
    <#elseif widget.type == "multiselect">
import ${js.nameType(namespace)}Multiselect from '@/components/${namespace}-multiselect.vue'   
    <#elseif widget.type == "tags">
import ${js.nameType(namespace)}Tagsinput from '@/components/${namespace}-tagsinput.vue' 
    </#if>
    <#local visited_types += {widget.type: widget} />
  </#list>
</#macro>

<#macro print_page_variables page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form'>
<@print_entry_form_variables form=widget indent=indent />
    <#elseif widget.type == 'official_form'>
<@print_official_form_variables form=widget indent=indent />
    <#elseif widget.type == 'excel_form'>
<@print_excel_form_variables form=widget indent=indent />
    <#elseif widget.type == 'criteria_form'>
<@print_criteria_form_variables form=widget indent=indent />
    <#elseif widget.type == 'display_form'>
<@print_display_form_variables form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_variables table=widget indent=indent />
    <#elseif widget.type == 'tabs'>
<@print_tabs_variables tabs=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form'>
<@print_entry_form_methods form=widget indent=indent />
    <#elseif widget.type == 'display_form'>
<@print_display_form_methods form=widget indent=indent />
    <#elseif widget.type == 'excel_form'>
<@print_excel_form_methods form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_methods table=widget indent=indent />
    <#elseif widget.type == 'tabs'>
<@print_tabs_methods tabs=widget indent=indent />
    <#elseif widget.type == 'button'>
<@print_paged_button_methods button=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_layout page indent=0>
  <#list page.children as child>
<@print_layout_widget widget=child indent=indent />
  </#list>
</#macro>

<#macro print_layout_widget widget indent=0>
  <#if widget.type == "entry_form">
<@print_layout_entry_form form=widget indent=indent+2 />    
  <#elseif widget.type == "official_form">
<@print_layout_official_form form=widget indent=indent+2 />   
  <#elseif widget.type == "excel_form">
<@print_layout_excel_form form=widget indent=indent+2 />      
  <#elseif widget.type == "paged_table">
<@print_layout_paged_table table=widget indent=indent+2 />    
  <#elseif widget.type == "criteria_form">
<@print_layout_criteria_form form=widget indent=indent+2 />
  <#elseif widget.type == "display_form">
<@print_layout_display_form form=widget indent=indent+2 />
  <#elseif widget.type == "tabs">
<@print_layout_tabs tabs=widget indent=indent+2 />
  <#elseif widget.type == "buttons">
<@print_layout_buttons buttons=widget indent=indent+2 />
  <#elseif widget.type == "button">
    <#if (widget.value("action")!"") == "reset" && widget.byRef()?? && widget.byRef().type == "entry_form">
${""?left_pad(indent)}<button class="${namespace}-btn ${namespace}-btn--${get_button_role(widget)} ${namespace}-btn-gap" @click="showConfirm${js.nameType(widget.value("ref"))}Reset = true">${widget.title}</button>    
    <#else>
${""?left_pad(indent)}<button class="${namespace}-btn ${namespace}-btn--${get_button_role(widget)} ${namespace}-btn-gap" @click="${get_button_method_name(widget)}">${widget.title}</button>
    </#if>
  <#elseif widget.type == "select">
    <#if (widget.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="sdk.${js.nameVariable(widget.id)}Options" :clearable="true" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />    
    <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options"  :clearable="true" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
    </#if>
  <#elseif widget.type == "date">
${""?left_pad(indent)}<${namespace}-datepicker data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />    
  <#elseif widget.type == "time">
${""?left_pad(indent)}<${namespace}-timepicker data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "cascade">
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "longtext">
${""?left_pad(indent)}<textarea class="${namespace}-textarea" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}          v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" placeholder="${widget.value("placeholder",("请输入" + widget.title))}"></textarea>  
  <#elseif widget.type == "text">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" 
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
${""?left_pad(indent)}       v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" 
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