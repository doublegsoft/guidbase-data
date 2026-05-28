export const MODULE_LIST = [
  { key: 'customer', label: '客户服务' },
  { key: 'meter',    label: '用电管理' },
  { key: 'billing',  label: '计量计费' },
  { key: 'payment',  label: '缴费收款' },
  { key: 'inspect',  label: '稽查管理' },
  { key: 'report',   label: '报表统计' },
  { key: 'system',   label: '系统管理' },
]

export const MENUS = {
  customer: {
    label: '客户服务',
    sections: [
      { title: '客户档案', items: [
        { id: 'cust-query',  label: '客户查询',          path: '/person/list' },
        { id: 'account',     label: '账户管理',     path: '/account/list' },
        { id: 'premise',     label: '用电地址', path: '/premise/list' },
        { id: 'sa',          label: '服务协议',         path: '/service_agreement/list'},
        { id: 'meter-point', label: '计量点',           path: '/customer/meter'},
      ]},
      { title: '服务管理', items: [
        { id: 'order',     label: '工单管理', path: '/customer/order',     badge: '7' },
        { id: 'complaint', label: '投诉管理', path: '/customer/complaint' },
        { id: 'appoint',   label: '预约服务', path: '/customer/appoint' },
      ]},
      { title: '快捷功能', items: [
        { id: 'new-cust', label: '新建客户档案', path: '/customer/new' },
        { id: 'merge',    label: '合并账户',     path: '/customer/merge' },
        { id: 'batch',    label: '批量查询',     path: '/customer/batch' },
        { id: 'workbench',label: '柜员工作台',   path: '/workbench' },
      ]},
    ],
  },
  meter: {
    label: '用电管理',
    sections: [
      { title: '计量管理', items: [
        { id: 'meter-list',  label: '计量点列表', path: '/meter/list' },
        { id: 'meter-read',  label: '抄表管理',   path: '/meter/read' },
        { id: 'meter-check', label: '计量检定',   path: '/meter/check' },
      ]},
    ],
  },
  billing: {
    label: '计量计费',
    sections: [
      { title: '账务管理', items: [
        { id: 'bill',    label: '账单查询',   path: '/billing/bill' },
        { id: 'pay',     label: '缴费记录',   path: '/billing/pay' },
        { id: 'fine',    label: '违约金管理', path: '/billing/fine' },
        { id: 'refund',  label: '退费申请',   path: '/billing/refund' },
        { id: 'deposit', label: '押金管理',   path: '/billing/deposit' },
      ]},
    ],
  },
  payment: {
    label: '缴费收款',
    sections: [
      { title: '收款业务', items: [
        { id: 'pay-counter', label: '柜台收款',   path: '/payment/counter' },
        { id: 'pay-online',  label: '网上缴费',   path: '/payment/online' },
        { id: 'pay-auto',    label: '自动扣费',   path: '/payment/auto' },
        { id: 'pay-batch',   label: '批量代扣',   path: '/payment/batch' },
        { id: 'pay-pos',     label: 'POS 机收款', path: '/payment/pos' },
      ]},
      { title: '退费管理', items: [
        { id: 'refund-apply', label: '退费申请', path: '/payment/refund-apply' },
        { id: 'refund-audit', label: '退费审核', path: '/payment/refund-audit', badge: '2' },
        { id: 'refund-exec',  label: '退费执行', path: '/payment/refund-exec' },
      ]},
      { title: '对账管理', items: [
        { id: 'recon-daily',   label: '日对账',   path: '/payment/recon-daily' },
        { id: 'recon-channel', label: '渠道对账', path: '/payment/recon-channel' },
        { id: 'recon-diff',    label: '差异处理', path: '/payment/recon-diff' },
        { id: 'recon-report',  label: '对账报表', path: '/payment/recon-report' },
      ]},
      { title: '票据管理', items: [
        { id: 'receipt-print', label: '收据打印', path: '/payment/receipt-print' },
        { id: 'receipt-void',  label: '收据作废', path: '/payment/receipt-void' },
        { id: 'invoice',       label: '发票管理', path: '/payment/invoice' },
      ]},
    ],
  },
  inspect: {
    label: '稽查管理',
    sections: [
      { title: '现场稽查', items: [
        { id: 'insp-task',   label: '稽查任务', path: '/inspect/task' },
        { id: 'insp-plan',   label: '稽查计划', path: '/inspect/plan' },
        { id: 'insp-record', label: '稽查记录', path: '/inspect/record' },
        { id: 'insp-photo',  label: '现场照片', path: '/inspect/photo' },
      ]},
      { title: '违章处理', items: [
        { id: 'vio-list',    label: '违章列表', path: '/inspect/violation', badge: '3' },
        { id: 'vio-steal',   label: '窃电处理', path: '/inspect/steal' },
        { id: 'vio-illegal', label: '违规用电', path: '/inspect/illegal' },
        { id: 'vio-penalty', label: '罚款追缴', path: '/inspect/penalty' },
      ]},
      { title: '稽查统计', items: [
        { id: 'insp-stat', label: '任务完成率', path: '/inspect/stat' },
        { id: 'insp-rank', label: '人员绩效',   path: '/inspect/rank' },
        { id: 'insp-area', label: '区域分析',   path: '/inspect/area' },
      ]},
    ],
  },
  report: {
    label: '报表统计',
    sections: [
      { title: '营销报表', items: [
        { id: 'rpt-cust',   label: '客户增减报表', path: '/report/customer' },
        { id: 'rpt-sa',     label: '服务协议报表', path: '/report/sa' },
        { id: 'rpt-elec',   label: '用电量统计',   path: '/report/electricity' },
        { id: 'rpt-income', label: '电费收入统计', path: '/report/income' },
      ]},
      { title: '账务报表', items: [
        { id: 'rpt-bill',   label: '账单汇总报表', path: '/report/bill' },
        { id: 'rpt-arrear', label: '欠费分析报表', path: '/report/arrear' },
        { id: 'rpt-pay',    label: '缴费渠道分析', path: '/report/pay-channel' },
        { id: 'rpt-fine',   label: '违约金报表',   path: '/report/fine' },
      ]},
      { title: '综合分析', items: [
        { id: 'rpt-kpi',     label: 'KPI 指标看板', path: '/report/kpi' },
        { id: 'rpt-trend',   label: '用电趋势分析', path: '/report/trend' },
        { id: 'rpt-compare', label: '同期对比分析', path: '/report/compare' },
        { id: 'rpt-export',  label: '报表导出中心', path: '/report/export' },
        { id: 'rpt-ledger',  label: '电费账本',     path: '/report/ledger' },
      ]},
    ],
  },
  system: {
    label: '系统管理',
    sections: [
      { title: '系统配置', items: [
        { id: 'user', label: '用户管理', path: '/system/user' },
        { id: 'role', label: '角色权限', path: '/system/role' },
        { id: 'dict', label: '数据字典', path: '/system/dict' },
        { id: 'log',  label: '操作日志', path: '/system/log' },
      ]},
    ],
  },
}
