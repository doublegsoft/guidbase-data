<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>

<#if widgetType == 'Separator'>
<strong>${properties.title!'这里是标题'}</strong>
<div class="ml-auto">
  <#list properties.actions![] as action>
  <a widget-id="${action.id!'buttonTodo'}" class="btn-link pointer">${action.title!'按钮'}</a>
  </#list>
</div>
<#elseif widgetType == 'TitleBar'>
<strong>${properties.title!'这里是标题'}</strong>
<div class="card-header-actions">
  <#list properties.actions![] as action>
  <button class="btn btn-primary pointer btn-add mr-2" widget-id="${action.id!'buttonTodo'}">${action.title!'按钮'}</button>
  </#list>
</div>
<#elseif widgetType == 'AOW'>
<div class="col-md-6">
  <div widget-id="widgetArticle" class="full-width"></div>
</div>
<div widget-id="widgetPreview" class="col-md-6 d-flex position-relative">
</div>
<#elseif widgetType == 'SURD'>
<div class="col-24-16" style="overflow: hidden;">
  <div widget-id="widgetDesigner" class="row mx-0"></div>
</div>
<div widget-id="widgetPreview" class="col-24-08 d-flex" style="overflow: hidden;"></div>
<#elseif widgetType == 'GIM'>
<div widget-id="widgetChat" class="row ml-0 mr-0 ab-chat overflow-hidden">
  <div class="col-md-4 pr-0">
    <div class="search" style="margin: 6px 12px;">
      <input type="text" name="" placeholder="搜索">
      <a href="#"><i class="fas fa-search"></i></a>
    </div>
    <ul widget-id="widgetContacts" class="list-group radius-less"></ul>
  </div>
  <div class="col-md-8 position-relative">
    <div widget-id="widgetContact" class="contact d-flex">
      <div class="avatar bg-info ml-3">
        <div widget-id="textInitialAvatar" class="initial font-18 font-weight-bold"
             style="left: 50%; position: absolute; top: 50%;transform: translate(-50%, -50%);"></div>
      </div>
      <div style="margin-left: 20px; padding-top: 8px;">
        <strong widget-id="textName" class="name font-18" widget-model-variable="userType"></strong>
        <div widget-id="textStatus" class="seen on" widget-model-variable="status"></div>
      </div>
    </div>
    <ul widget-id="widgetConversation" class="conversation"></ul>
    <div class="pr-2 pl-2">
      <input name="fileImage" type="file" style="display: none" accept=".jpg, .png, .jpeg, .gif, .bmp, .tif, .tiff|image/*">
      <textarea widget-id="longtextMessage" disabled class="form-control" rows="2"
                placeholder="这里输入消息内容..."  style="resize:none;"></textarea>
      <div>
        <a widget-id="buttonImage" class="btn btn-link pointer disabled">
          <i class="far fa-image text-info font-20"></i>
        </a>
        <a widget-id="buttonRecord" class="btn btn-link pointer disabled">
          <i class="fas fa-microphone text-info font-20"></i>
        </a>
        <a widget-id="buttonPatient" class="btn btn-link pointer disabled">
          <i class="fas fa-address-book text-info font-20"></i>
        </a>
        <a widget-id="buttonSend" class="btn text-info font-16 font-weight-bold disabled" style="float: right;">发送</a>
      </div>
    </div>
  </div>
</div>
</#if>
