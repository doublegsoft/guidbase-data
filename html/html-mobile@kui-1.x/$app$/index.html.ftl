<#assign componentPages = []>
<#list pages as page>
  <#if page.options?? && page.options.isComponent?? && page.options.isComponent == 'T'>
    <#assign componentPages = componentPages + [page]>
  </#if>
</#list>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, maximum-scale=1">
  <title>${app.name}</title>
  <style>
    html, body {
      -ms-overflow-style: none;
      scrollbar-width: none;
      overflow-y: scroll;
      overscroll-behavior: contain;
    }

    body::-webkit-scrollbar {
      display: none;
    }
  </style>
  <link href="/3rd/font-awesome/css/all.min.css" rel="stylesheet">
  <link href="/3rd/animation/animate.min.css" rel="stylesheet">
  <link href="/3rd/material-icons/material-icons.css" rel="stylesheet">
  <link href="/3rd/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="/3rd/viewerjs/viewer.min.css" rel="stylesheet">
  <link href="/3rd/videojs/video-js.min.css" rel="stylesheet">
  <link href="/3rd/videojs/videojs-mobile-ui.css" rel="stylesheet">
  <link href="/css/kui/kui-all.mobile.min.css" rel="stylesheet">
  <link href="/${app.name}/css/${app.name}.css" rel="stylesheet">

  <script src="/3rd/jquery/jquery-3.2.1.min.js"></script>
  <script src="/3rd/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/3rd/moment/moment.min.js"></script>
  <script src="/3rd/handlebars/handlebars-v4.0.11.js"></script>
  <script src="/3rd/rxjs/rxjs.umd.js"></script>
  <script src="/3rd/rxjs/rxjs-pubsub.js"></script>
  <script src="/3rd/viewerjs/viewer.js"></script>
  <script src="/3rd/videojs/video.min.js"></script>
  <script src="/3rd/videojs/videojs-mobile-ui.min.js"></script>
  <script src="/3rd/mobile/rolldate.js"></script>
  <script src="/3rd/swiper/swiper-bundle.min.js"></script>
  <script src="/3rd/iSlider/iSlider.js"></script>
  <script src="/3rd/echarts/echarts.simple.min.js"></script>

  <script src="/js/kui/kui-all.mobile.min.js"></script>
  <script src="/${app.name}/js/${app.name}.test.js"></script>
</head>
<body>
<header class="header-bar">
  <div class="left">
    <span class="button icon material-icons">home</span>
  </div>
  <div class="center">
    <h1 class="title">首页</h1>
  </div>
</header>
<div widget-id="widgetRefresh" class="pull-to-refresh out">
  <i class="fas fa-spinner fa-spin font-48 text-gray m-auto"></i>
</div>
<main></main>
<footer>
  <div class="bottom-navigator">
    <div class="active-0">
<#list componentPages as page>
  <#if page?index == 0>
      <label widget-id="button${js.nameType(page.uri)}" class="active" style="flex: 0 0 ${100 / componentPages?size}%;">
  <#else>
      <label widget-id="button${js.nameType(page.uri)}" style="flex: 0 0 ${100 / componentPages?size}%;">
  </#if>
        <i class="fas fa-home" style="left: -2px;"></i>
        <span>${page.title}</span>
      </label>
</#list>
      <span style="width: ${100 / componentPages?size}%;"></span>
    </div>
  </div>
</footer>
</body>
</html>
<script>
const PAGE_OFFSET = 136;
function PageIndex() {

}

PageIndex.prototype.initialize = async function (params) {
  let main = document.querySelector('main');
  let footer = document.querySelector('footer');
  dom.init(this, footer);

  main.style.height = (window.innerHeight - 0) + 'px';

<#list componentPages as page>
  dom.bind(this.button${js.nameType(page.uri)}, 'click', ev => {
    this.button${js.nameType(page.uri)}.parentElement.className = 'active-${page?index}';
    this.button${js.nameType(page.uri)}.parentElement.querySelectorAll('label').forEach(el => {
      el.className = '';
    });
    this.button${js.nameType(page.uri)}.classList.add('active');
    kuim.navigateTo('mhtml/${page.uri?replace(app.name + "/", "")}.html', {
      title: '${page.title}',
      icon: '<i class="fas fa-home text-white button icon"></i>',
    }, true);
  });
</#list>

  // 底部导航
  let navbar = document.querySelector(".bottom-bar")
  let navbarItems = document.querySelectorAll("li", navbar);

  navbarItems.forEach((li, index) => {
    li.addEventListener("click" , e =>{
      e.preventDefault();
      navbar.querySelector(".active").classList.remove("active");
      li.classList.add("active");

      const indicator = document.querySelector(".indicator");
      indicator.style.transform = `translateX(calc(${r"$"}{li.offsetLeft}px + 0px))`;
    });
    if (index == 0) {
      const indicator = document.querySelector(".indicator");
      indicator.style.transform = `translateX(calc(${r"$"}{li.offsetLeft}px + 0px))`;
    }
  });
};

PageIndex.prototype.show = async function (params) {
  this.initialize(params);
<#list componentPages as page>
  <#if page?index == 0>
  this.button${js.nameType(page.uri)}.click();
  </#if>
</#list>
};

pageIndex = new PageIndex();
pageIndex.show({});
</script>