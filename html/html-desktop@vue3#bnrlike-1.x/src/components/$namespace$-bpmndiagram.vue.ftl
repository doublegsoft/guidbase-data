<template>
  <div class="bpmn-container" ref="containerRef"></div>
</template>

<script setup>
import { ref, watch, onMounted, onBeforeUnmount } from 'vue';
import BpmnModeler from 'bpmn-js/lib/Modeler';
import BpmnViewer from 'bpmn-js/lib/NavigatedViewer';

// 样式引入（也可以放到 main.js 全局引入）
import 'bpmn-js/dist/assets/diagram-js.css';
import 'bpmn-js/dist/assets/bpmn-js.css';
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css';

const props = defineProps({
  // 支持 v-model 绑定 BPMN XML 字符串
  modelValue: {
    type: String,
    default: '',
  },
  // 是否只读模式（只读时使用 NavigatedViewer）
  readOnly: {
    type: Boolean,
    default: false,
  },
  // 扩展模块（如自定义 palette、contextPad、propertiesPanel）
  additionalModules: {
    type: Array,
    default: () => [],
  },
  // 扩展元模型（如 camunda / flowable descriptor）
  moddleExtensions: {
    type: Object,
    default: () => ({}),
  },
  // 导入后是否自动居中适配画布
  autoFit: {
    type: Boolean,
    default: true,
  },
});

const emit = defineEmits([
  'update:modelValue',
  'change',            // 图形发生变化时触发，参数为最新 xml
  'loaded',            // XML 导入成功
  'error',             // XML 导入或导出失败
  'selection-changed', // 选中节点变化（常用于联动右侧属性栏）
  'element-click',     // 点击节点
]);

const containerRef = ref(null);

// 注意：不要使用 ref/reactive 包裹 bpmn 实例
let bpmnInstance = null;
// 记录最近一次内部产出的 XML，用于防止 v-model 循环导入
let lastInternalXml = '';

// 初始化或重建实例
function initInstance() {
  destroyInstance();

  const Engine = props.readOnly ? BpmnViewer : BpmnModeler;
  bpmnInstance = new Engine({
    container: containerRef.value,
    additionalModules: props.additionalModules,
    moddleExtensions: props.moddleExtensions,
  });

  bindEvents();

  if (props.modelValue) {
    importXML(props.modelValue);
  } else if (!props.readOnly) {
    createNewDiagram();
  }
}

// 绑定内部事件
function bindEvents() {
  if (!bpmnInstance) return;

  // 监听选中元素变化
  bpmnInstance.on('selection.changed', (e) => {
    emit('selection-changed', e.newSelection);
  });

  // 监听节点点击
  bpmnInstance.on('element.click', (e) => {
    emit('element-click', e.element);
  });

  // 仅编辑模式监听画布修改
  if (!props.readOnly) {
    bpmnInstance.on('commandStack.changed', async () => {
      try {
        const { xml } = await bpmnInstance.saveXML({ format: true });
        lastInternalXml = xml;
        emit('update:modelValue', xml);
        emit('change', xml);
      } catch (err) {
        emit('error', err);
      }
    });
  }
}

// 导入 XML
async function importXML(xml) {
  if (!bpmnInstance || !xml) return;
  try {
    const { warnings } = await bpmnInstance.importXML(xml);
    lastInternalXml = xml;
    if (props.autoFit) {
      fitViewport();
    }
    emit('loaded', { warnings });
  } catch (err) {
    emit('error', err);
  }
}

// 创建空白流程图（含默认开始节点）
async function createNewDiagram() {
  if (!bpmnInstance || props.readOnly) return;
  try {
    await bpmnInstance.createDiagram();
    const { xml } = await bpmnInstance.saveXML({ format: true });
    lastInternalXml = xml;
    if (props.autoFit) {
      fitViewport();
    }
    emit('update:modelValue', xml);
    emit('loaded', { warnings: [] });
  } catch (err) {
    emit('error', err);
  }
}

// 导出 XML
async function saveXML(options = { format: true }) {
  if (!bpmnInstance) return null;
  const { xml } = await bpmnInstance.saveXML(options);
  return xml;
}

// 导出 SVG
async function saveSVG() {
  if (!bpmnInstance) return null;
  const { svg } = await bpmnInstance.saveSVG();
  return svg;
}

// 适配视口居中
function fitViewport() {
  bpmnInstance?.get('canvas').zoom('fit-viewport');
}

// 缩放（如 1.0, 1.2, 0.8）
function zoom(scale) {
  bpmnInstance?.get('canvas').zoom(scale);
}

// 撤销 / 重做
function undo() {
  bpmnInstance?.get('commandStack').undo();
}

function redo() {
  bpmnInstance?.get('commandStack').redo();
}

// 获取原始 bpmn-js 实例（方便做高级自定义操作）
function getInstance() {
  return bpmnInstance;
}

function destroyInstance() {
  if (bpmnInstance) {
    bpmnInstance.destroy();
    bpmnInstance = null;
  }
}

// 监听外部传入的 XML 变化
watch(
  () => props.modelValue,
  (newXml) => {
    // 如果是由内部编辑同步出去的值，跳过重复导入
    if (!newXml || newXml === lastInternalXml) return;
    importXML(newXml);
  }
);

// 监听只读模式切换
watch(
  () => props.readOnly,
  () => {
    initInstance();
  }
);

onMounted(() => {
  initInstance();
});

onBeforeUnmount(() => {
  destroyInstance();
});

// 暴露给父组件调用的方法
defineExpose({
  importXML,
  createNewDiagram,
  saveXML,
  saveSVG,
  fitViewport,
  zoom,
  undo,
  redo,
  getInstance,
});
</script>

<style scoped>
.bpmn-container {
  width: 100%;
  height: 100%;
  background-color: #ffffff;
}

/* 隐藏右下角 bpmn.io logo */
:deep(.bjs-powered-by) {
  display: none;
}
</style>