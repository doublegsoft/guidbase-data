import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [{
<#list app.pages as page>    
    path: '/${js.nameFile(page.id)}',
    name: '${js.nameFile(page.id)}',
    component: () => import('@/pages/${js.nameFile(page.module)}/${js.nameFile(page.id)}.vue')
  <#if page?index != 0>
  },{
  </#if>  
</#list>
  }]
})

export default router