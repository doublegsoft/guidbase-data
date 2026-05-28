<style>
  body {
    background: #f3f5fa !important;
  }
  .nav-tabs .nav-link.head-link {
    padding-top: 12px;
    color: white;
    height: 100%;
  }

  .nav-tabs .nav-link.head-link:hover {
    color: white;
  }

  .nav-tabs .nav-link.head-link.active {
    color: rgb(240, 108, 53);
    background-color: white;
    border-radius: unset !important;
  }


  .nav-tabs .nav-link.head-link.active:hover {
    color: rgb(240, 108, 53);
  }

  .dropdown-menu .head-link {
    background-color: rgb(240, 108, 53);
    color: white !important;
    border-radius: unset !important;
  }

  .dropdown-menu .head-link i {
    background-color: rgb(240, 108, 53);
    color: white !important;
  }

  .dropdown-menu .head-link.active {
    color: rgb(240, 108, 53) !important;
    background-color: white;
    border-radius: unset !important;
  }

  .dropdown-menu .head-link.active i {
    color: rgb(240, 108, 53) !important;
    background-color: white;
  }

  .nav-tabs .nav-link {
    font-size: 16px;
    font-weight: bold;
  }

  .dropdown-menu .dropdown-item {
    font-size: 16px;
    font-weight: bold;
  }

  .remind-bubble {
    display: none;
    position: absolute;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    background: red;
    color: #fff;
    top: -10px;
    font-size: 12px;
    line-height: 16px;
    text-align: center;
    right: 4px;
  }

  .button-chat .active {
    display: block;
  }

  .dropdown-toggle::after {
    background: url('img/gtgx/down.png') no-repeat;
    width: 11px;
    height: 7px;
    background-size: cover;
    margin-left: 10px;
    border: 0;
    transition: transform .3s;
  }

  .show .dropdown-toggle::after {
    transform: rotate(-180deg);
  }

  .top-icon {
    width: 22px;
    height: 22px;
  }

  .sidebar {
    color: #959CA5;
    background: #F3F5FA;
  }

  .sidebar .nav {
    background: #2B3A4B;
    color: #959CA5;
  }

  .sidebar .nav-link, .sidebar .nav-dropdown.open .nav-link, .sidebar-nav .nav-item:hover > a.nav-link {
    color: #959CA5;
    background: transparent;
    padding: 14px 0 14px 20px;
  }

  .sidebar .nav, .sidebar .sidebar-nav {
    width: 220px;
  }

  .fa-circle:before {
    content: "";
    position: absolute;
    width: 6px;
    height: 6px;
    background: #888888;
    border-radius: 50%;
  }

  .sidebar .nav-dropdown.open {
    background: transparent;
  }

  .sidebar-nav .isClickBg:hover a.nav-link, .sidebar-nav .isClickBg, sidebar-nav .isClickBg a.nav-link {
    background: #3C70F5 !important;
    color: #fff;
    position: relative;
  }

  .isClickBg a::before {
    position: absolute;
    content: "";
    width: 10px;
    height: 100%;
    background: var(--color-info);
    left: 0;
    top: 0;
  }

  .isClickBg .fa-circle:before {
    background: #fff;
  }

  .sidebar .nav-link:hover, .isClickBg .nav-link span {
    color: #fff;
    background: #3C70F5;
  }

  .sidebar .nav-link:hover.nav-dropdown-toggle::before {
    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 11 14'%3E%3Cpath fill='%2373818f' d='M9.148 2.352l-4.148 4.148 4.148 4.148q0.148 0.148 0.148 0.352t-0.148 0.352l-1.297 1.297q-0.148 0.148-0.352 0.148t-0.352-0.148l-5.797-5.797q-0.148-0.148-0.148-0.352t0.148-0.352l5.797-5.797q0.148-0.148 0.352-0.148t0.352 0.148l1.297 1.297q0.148 0.148 0.148 0.352t-0.148 0.352z'/%3E%3C/svg%3E");
  }

  .sidebar .nav-dropdown-toggle::before {
    transform: rotate(-180deg);
  }

  @-webkit-keyframes swinging {
    0% {
      -webkit-transform: rotate(10deg);
    }
    50% {
      -webkit-transform: rotate(-5deg)
    }
    100% {
      -webkit-transform: rotate(10deg);
    }
  }

  @keyframes swinging {
    0% {
      transform: rotate(10deg);
    }
    50% {
      transform: rotate(-5deg)
    }
    100% {
      transform: rotate(10deg);
    }
  }

  img.swing {
    -webkit-transform-origin: 50% 0;
    transform-origin: 50% 0;
    -webkit-animation: swinging 0.3s ease-in-out forwards infinite;
    animation: swinging 0.3s ease-in-out forwards infinite;
  }

  .btn-toggler {
    background: #2B3A4B;
  }

</style>
<div style="display: flex;">
  <a class="navbar-brand" href="#" style="width:220px;display: flex;align-items: center;background: #2B3A4B;margin-right: 0;justify-content: center;border-bottom: 1px solid rgba(255,255,255,0.2);">
    <img class="navbar-brand-full" src="img/gtgx/test/top-logo.png" height="33px">
  </a>

  <header id="header" class="app-header navbar"
          style="flex: 1;background:#fff;border-bottom: none;height: 66px;padding: 0 40px;box-shadow: 0px 25px 50px 0px rgba(0,0,0,0.04);">
    <ul class="nav navbar-nav">
      <li class="nav-item d-md-down-none">
        <a widget-id="buttonChat" class="nav-link font-lg button-chat ab-chat indicator"
           style="color: #fff;position: relative;" href="#">
          <img src="img/gtgx/search.png" class="top-icon"/>
        </a>
      </li>
      <li class="nav-item d-md-down-none d-flex justify-content-center">
        <a widget-id="buttonNotif" class="nav-link font-lg" style="color: #fff; width: 24px; position: relative;"
           data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
        <span style="position: absolute; right: 0; top: 0; background: var(--color-error);
                     width: 6px; height: 6px; border-radius: 9999px; display: none;"></span>
          <img src="img/gtgx/remind.png" class="top-icon red-spot"/>
        </a>
        <audio widget-id="audioNotif" src="img/ring.mp3" id="newComeAudio" hidden="true" loop="true"></audio>
        <div widget-id="widgetMessage" class="dropdown-menu dropdown-menu-right">

        </div>
      </li>
      <li class="nav-item dropdown ml-3 mr-1">
        <a class="nav-link dropdown-toggle font-lg" style="color: #333;display: flex;align-items: center;"
           data-toggle="dropdown" href="#" role="button"
           aria-haspopup="true" aria-expanded="false">
          <img widget-id="avatar" src="img/user.png" class="avatar"
               style="width: 40px;height: 40px;box-shadow:none;background: #F7F7F6;border: 1px solid #EEEEEE;"/>
          <span widget-id="textUsername" style="font-size: 16px;font-weight: 500;padding-left: 10px"></span>
        </a>
        <div class="dropdown-menu dropdown-menu-right">
          <a class="dropdown-item text-dark font-15" href="javascript:changePassword();">
            <i class="fas fa-lock"></i>修改密码
          </a>
          <div class="divider"></div>
          <a class="dropdown-item text-dark font-15" href="javascript:logout()">
            <i class="fa fa-sign-out-alt"></i>退出
          </a>
        </div>
      </li>
    </ul>
    <!--  <button class="navbar-toggler sidebar-toggler d-md-down-none text-white" type="button">-->
    <!--    <i class="fas fa-bars"></i>-->
    <!--  </button>-->
  </header>
</div>
<div class="app-body">
  <!-- side menu -->
  <div class="sidebar" style="height: calc(100vh - 60px);">
    <nav id="sidemenu" class="sidebar-nav"></nav>
  </div>

  <!-- Main content -->
  <main class="main header-fixed" style="overflow-y: hidden; margin-left: 220px;">
    <div id="container"
         style="width: 100%; overflow-y: auto;height: calc(100vh - 60px) !important;background: white;"></div>
  </main>
  <aside class="aside-menu"></aside>
  <div id="timChat"></div>
  <div id="tooltip"></div>
</div>

<!-- menu template -->
<script id="sidemenu-template" type="text/x-handlebars-template">
  <ul class="nav">
    {{#if home}}
      <li class="nav-item" data-title="{{home.functionName}}">
        <a widget-id='home' class="nav-link"
           href="javascript:ajax.view({title: '{{{functionName}}}', url:'{{{home.entryPoint}}}', containerId: 'container'});">
          {{{home.icon}}}<span>{{home.functionName}}</span>
        </a>
      </li>
    {{/if}}
    {{#each groups}}
      <!--li class="nav-title">{{functionName}}</li-->
      {{#each children}}
        {{#if entryPoint}}
          <li class="nav-item" data-title="{{functionName}}">
            <a class="nav-link" widget-id="Index{{functionId}}"
               href="javascript:ajax.view({title: '{{{functionName}}}', url:'{{{entryPoint}}}', containerId: 'container'});">
              {{{icon}}}<span>{{functionName}}</span>
            </a>
          </li>
        {{else}}
          <li class="nav-item nav-dropdown" data-title="{{functionName}}">
            <a class="nav-link nav-dropdown-toggle" title="{{functionName}}" href="#">
              {{{icon}}}<span>{{functionName}}</span>
            </a>
            <ul class="nav-dropdown-items">
              {{#each children}}
                <li class="nav-item" data-title="{{functionName}}">
                  <a class="nav-link" title="{{functionName}}"
                     href="javascript:ajax.view({title: '{{{functionName}}}', url:'{{{entryPoint}}}', containerId: 'container'});">
                    <span style="padding-left: 16px"></span>
                    {{{icon}}}<span>{{functionName}}</span>
                  </a>
                </li>
              {{/each}}
            </ul>
          </li>
        {{/if}}
      {{/each}}
    {{/each}}
  </ul>
</script>

<script>
// 加载系统菜单
xhr.post({
  url: HOST + '/api/v3/common/script/stdbiz-ex/sam/menu',
  data: {
    userId: window.user.userId
  },
  success: function (resp) {
    if (resp.error) {
      dialog.error(resp.error.message);
      return;
    }
    let source = document.getElementById('sidemenu-template').innerHTML;
    let template = Handlebars.compile(source);
    let html = template(resp.data);
    $('#sidemenu').append(html);
    $('#sidemenu .nav-item').on('click', function (e) {
      let childs = $('#sidemenu').find('.nav-item');
      if ($(this)[0].className.indexOf('nav-dropdown') == -1) {//排除多级菜单的里面的父级
        for (let i = 0; i < childs.length; i++) {
          let item = $(childs[i]);
          if (item[0].className.indexOf('isClickBg') > -1) {
            item.removeClass('isClickBg');
          }
        }
        $(this).addClass('isClickBg');
      }
    })
    // 由于后加载数据，所以事件无法由bootstrap加载，只能自己加载
    $('#sidemenu .nav-dropdown>a').on('click', function (e) {
      // let dropdown = $(e.target).parent();
      let dropdown = $(this).parent();
      if (dropdown.hasClass('open')) {
        dropdown.removeClass('open');
      } else {
        dropdown.addClass('open');
      }
    })
    let home = dom.find('[widget-id=home]');
    if (home) {
      home.click();
    }
    self.leftMenuTooltip = function () {
      //左边菜单tooltip
      $('#sidemenu .nav-link').on('mouseover', function (e) {
        let y = parseInt(e.pageY / 60) * 60 + 6 + 5;
        let x = $('.sidebar').width();
        this.myTitle = ($(this).parent())[0].dataset.title;
        let tooltip = `<div id='tplink' style="top:${y}px;left:${x}px;">${this.myTitle}</div>`;
        $('.sidebar').append(tooltip);
      }).mouseout(function () {
        $("#tplink").remove();    //移除
      }).mousemove(function (e) {
        let y = parseInt(e.pageY / 60) * 60 + 6 + 5;
        let x = $('.sidebar').width();
        this.myTitle = ($(this).parent())[0].dataset.title;
        let tooltip = `<div id='tplink' style="top:${y}px;left:${x}px;">${this.myTitle}</div>`;
      })
    }

  }
});

// 重算容器高度
dom.height('#container', 0, document.body);
dom.find('#sidemenu').style.height = dom.find('#container').style.height;
</script>