/**
 * df-empty · 空状态组件
 *
 * 用法一（属性驱动）:
 *   <df-empty icon="📅" title="暂无日程" description="点击下方按钮添加" actionText="新建日程" bind:action="onAdd" />
 *
 * 用法二（插槽自定义）:
 *   <df-empty>
 *     <view>任意自定义内容</view>
 *   </df-empty>
 */
Component({
  properties: {
    /** 图标（emoji 或字符），传空字符串则不显示 */
    icon: { type: String, value: '📭' },
    /** 主标题 */
    title: { type: String, value: '暂无数据' },
    /** 辅助描述文字 */
    description: { type: String, value: '' },
    /** 操作按钮文字，传空字符串则不显示按钮 */
    actionText: { type: String, value: '' },
    /** 操作按钮颜色: teal | amber | red | blue */
    actionColor: { type: String, value: 'teal' },
  },

  methods: {
    handleAction: function () {
      this.triggerEvent('action');
    },
  },
});
