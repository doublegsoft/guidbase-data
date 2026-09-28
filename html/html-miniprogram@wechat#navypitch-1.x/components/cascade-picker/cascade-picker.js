Component({

  properties: {
    // 标题与提示
    label: { type: String, value: '' },
    placeholder: { type: String, value: '请选择' },
    title: { type: String, value: '请选择' },
    disabled: { type: Boolean, value: false },
    // 数据字段映射
    fieldText: { type: String, value: 'name' },
    fieldValue: { type: String, value: 'id' },
    value: {
      type: Array,
      value: []
    },
    valueText: {
      type: String,
      value: '',
      observer(val) {
        this.setData({ displayPath: val });
      }
    },
  },

  data: {
    innerVisible: false,
    displayPath: '',
    tabs: [{ name: '请选择', value: null }],
    activeTab: 0,
    currentOptions: [],
    currentSelectedId: null,
    loading: false,

    cacheData: {},
  },

  methods: {

    preventTouchMove() {},

    stopBubble(e) {
      e.stopPropagation && e.stopPropagation();
    },

    handleOpen() {
      if (this.data.disabled) return;

      this.setData({ 
        innerVisible: true, 
      });
      this.triggerEvent('open');

      if (this.data.currentOptions.length === 0) {
        this.fetchLevelData(null, 0);
      }
    },

    handleClose() {
      this.setData({ innerVisible: false });
      this.triggerEvent('close');
    },

    async fetchLevelData(parentId, tabIndex) {
      this.setData({ loading: true });
      const cacheKey = parentId || '';

      this.triggerEvent('load', {
        parentId,
        tabIndex,
        resolve: (list) => {
          const options = list || [];
          this.data.cacheData[cacheKey] = options;
          this.setData({
            currentOptions: options,
            activeTab: tabIndex,
            loading: false
          });
        }
      });
    },

    // 选中选项
    handleOptionTap(e) {
      const item = e.currentTarget.dataset.item;
      const { fieldValue, fieldText, activeTab, tabs } = this.data;

      let newTabs = tabs.slice(0, activeTab + 1);
      newTabs[activeTab] = {
        name: item[fieldText],
        value: item[fieldValue]
      };

      this.setData({
        currentSelectedId: item[fieldValue],
        loading: true
      });

      this.triggerEvent('load', {
        parentId: item[fieldValue],
        tabIndex: activeTab + 1,
        resolve: (children) => {
          this.setData({ loading: false });

          if (children && children.length > 0) {
            this.data.cacheData[item[fieldValue]] = children;
            newTabs.push({ name: '请选择', value: null });

            this.setData({
              tabs: newTabs,
              activeTab: activeTab + 1,
              currentOptions: children,
              currentSelectedId: null
            });
          } else {
            // 叶子节点：全部选毕
            const pathText = newTabs.map((t) => t.name).join(' / ');
            const selectedValues = newTabs.map((t) => t.value);

            this.setData({
              displayPath: pathText
            });

            this.triggerEvent('change', {
              pathText,
              values: selectedValues,
              lastItem: item
            });
            this.handleClose();
          }
        }
      });
    },

    // 切换 Tab
    handleTabTap(e) {
      const index = e.currentTarget.dataset.index;
      if (index === this.data.activeTab) return;

      const { tabs } = this.data;
      const parentId = index === 0 ? null : tabs[index - 1].value;

      this.fetchLevelData(parentId, index);
      this.setData({
        currentSelectedId: tabs[index].value
      });
    }
  }
});