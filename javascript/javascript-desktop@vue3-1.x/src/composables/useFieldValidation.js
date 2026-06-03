import { reactive } from 'vue'

/**
 * 表单字段校验 Composable
 *
 * @param {Array} fieldDefs — 字段校验定义
 *   每个元素: { name: string, rules: Array<{ type: string, message: string, validator?: Function }> }
 *   内置 type: 'required' | 'number'
 *
 * 用法:
 *   const { errors, validate, clearErrors, setError } = useFieldValidation([
 *     { name: 'text1', rules: [{ type: 'required', message: '请输入文本' }] },
 *     { name: 'num1',  rules: [
 *       { type: 'required', message: '请输入数字' },
 *       { type: 'number',  message: '请输入有效数字' }
 *     ]},
 *   ])
 *   const ok = validate(formData)  // 返回 true/false
 */
export function useFieldValidation(fieldDefs) {
  // 构建 errors 对象，每个字段初始为空字符串（空 = 无错误）
  const errors = reactive(
    Object.fromEntries(fieldDefs.map(d => [d.name, '']))
  )

  /** 校验全部字段，返回 true 表示通过 */
  function validate(data) {
    let valid = true

    for (const def of fieldDefs) {
      const val = data[def.name]
      let msg = ''

      for (const rule of def.rules) {
        if (rule.type === 'required') {
          if (val === '' || val === null || val === undefined) {
            msg = rule.message || '此字段为必填项'
            break
          }
        } else if (rule.type === 'number') {
          if (val !== '' && val !== null && val !== undefined) {
            const n = Number(val)
            if (isNaN(n)) {
              msg = rule.message || '请输入有效数字'
              break
            }
          }
        } else if (rule.type === 'custom' && typeof rule.validator === 'function') {
          const result = rule.validator(val, data)
          if (result !== true) {
            msg = typeof result === 'string' ? result : (rule.message || '校验未通过')
            break
          }
        }
      }

      errors[def.name] = msg
      if (msg) valid = false
    }

    return valid
  }

  /** 清除全部错误 */
  function clearErrors() {
    for (const key of Object.keys(errors)) {
      errors[key] = ''
    }
  }

  /** 手动设置单个字段错误 */
  function setError(name, message) {
    if (name in errors) {
      errors[name] = message
    }
  }

  return { errors, validate, clearErrors, setError }
}
