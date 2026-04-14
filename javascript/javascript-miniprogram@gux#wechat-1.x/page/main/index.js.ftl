<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${js.license(license)}
</#if>
const { ${namespace} } = require("../../sdk/${app.name}");
Page({

  data: {
    
    activeIndex: 0,
  
    entries: [{    
<#list guidbase.get_navigable_pages(app) as nav>   
    <#if nav?index != 0>
    },{
    </#if>
      icon: "gx-i gx-i-home",
      text: "${nav.options["title"]!"标题"}",
</#list>      
<#--
      icon: "gx-i gx-i-comment",
      text: "索引",
    },{
      icon: "gx-i gx-i-user",
      text: "我的",
-->      
    }],
  },

  onShow() {

  },

  doTabBarActiveChanged(ev) {
    wx.setNavigationBarTitle({
      title: ev.detail.text,
    });
    this.setData({
      activeIndex: ev.detail.activeIndex,
    });
    let nav = this.selectComponent("#nav-" + ev.detail.activeIndex);
    nav.show();
  },
  
})