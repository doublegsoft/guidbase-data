<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
      content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, target-densityDpi=device-dpi">

<title>引力世界后台管理系统</title>
<link rel="icon" href="/img/gtgx/favicon.ico" sizes="16x16" type="image/png">
<link href="3rd/font-awesome/css/all.min.css" rel="stylesheet">
<link href="3rd/font-awesome/css/v4-shims.css" rel="stylesheet">
<link href="3rd/material-icons/material-icons.css" rel="stylesheet">
<link href="3rd/material-icons/material-symbols.css" rel="stylesheet">
<link href="3rd/animation/animate.min.css" rel="stylesheet">
<link href="3rd/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet">
<link href="3rd/bootstrap-datetimepicker/css/bootstrap-datetimepicker-standalone.css" rel="stylesheet">
<link href="3rd/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
<link href="3rd/bootstrap-lightbox/ekko-lightbox.css" rel="stylesheet">
<link href="3rd/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet">
<link href="3rd/pureScriptSelect/style.css" rel="stylesheet">
<link href="3rd/viewerjs/viewer.css" rel="stylesheet">
<link href="3rd/codemirror/codemirror.css" rel="stylesheet">
<link href="3rd/tagify/tagify.css" rel="stylesheet">
<link href="3rd/trumbowyg/ui/trumbowyg.min.css" rel="stylesheet">
<link href="3rd/trumbowyg/plugins/table/ui/trumbowyg.table.min.css" rel="stylesheet">
<link href="3rd/recogito-js-1.8.2/recogito.min.css" rel="stylesheet">
<link rel="stylesheet" href="3rd/bpnm-js-9.4.0/assets/bpmn-js.css" type="text/css">
<link rel="stylesheet" href="3rd/bpnm-js-9.4.0/assets/diagram-js.css">
<link rel="stylesheet" href="3rd/bpnm-js-9.4.0/assets/bpmn-font/css/bpmn.css">
<link href="3rd/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<link href="3rd/select2/dist/css/select2.css" rel="stylesheet">
<link href="3rd/daterangepicker/daterangepicker.css" rel="stylesheet">
<link href="3rd/gosheet/gosheet.min.css" rel="stylesheet">
<link href="3rd/quill/quill.snow.css" rel="stylesheet">
<link href="css/kui/kui-all.min.css" rel="stylesheet">
<style>
  #loader-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1000;
  }

  #loader {
    display: block;
    position: relative;
    left: 50%;
    top: 50%;
    width: 150px;
    height: 150px;
    margin: -75px 0 0 -75px;
    border-radius: 50%;
    border: 3px solid transparent;
    border-top-color: #3498db;

    -webkit-animation: spin 2s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
    animation: spin 2s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */

    z-index: 1001;
  }

  #loader:before {
    content: "";
    position: absolute;
    top: 5px;
    left: 5px;
    right: 5px;
    bottom: 5px;
    border-radius: 50%;
    border: 3px solid transparent;
    border-top-color: #e74c3c;

    -webkit-animation: spin 3s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
    animation: spin 3s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
  }

  #loader:after {
    content: "";
    position: absolute;
    top: 15px;
    left: 15px;
    right: 15px;
    bottom: 15px;
    border-radius: 50%;
    border: 3px solid transparent;
    border-top-color: #f9c922;

    -webkit-animation: spin 1.5s linear infinite; /* Chrome, Opera 15+, Safari 5+ */
    animation: spin 1.5s linear infinite; /* Chrome, Firefox 16+, IE 10+, Opera */
  }

  @-webkit-keyframes spin {
    0% {
      -webkit-transform: rotate(0deg); /* Chrome, Opera 15+, Safari 3.1+ */
      -ms-transform: rotate(0deg); /* IE 9 */
      transform: rotate(0deg); /* Firefox 16+, IE 10+, Opera */
    }
    100% {
      -webkit-transform: rotate(360deg); /* Chrome, Opera 15+, Safari 3.1+ */
      -ms-transform: rotate(360deg); /* IE 9 */
      transform: rotate(360deg); /* Firefox 16+, IE 10+, Opera */
    }
  }

  @keyframes spin {
    0% {
      -webkit-transform: rotate(0deg); /* Chrome, Opera 15+, Safari 3.1+ */
      -ms-transform: rotate(0deg); /* IE 9 */
      transform: rotate(0deg); /* Firefox 16+, IE 10+, Opera */
    }
    100% {
      -webkit-transform: rotate(360deg); /* Chrome, Opera 15+, Safari 3.1+ */
      -ms-transform: rotate(360deg); /* IE 9 */
      transform: rotate(360deg); /* Firefox 16+, IE 10+, Opera */
    }
  }

  #loader-wrapper .loader-section {
    position: fixed;
    top: 0;
    width: 51%;
    height: 100%;
    z-index: 1000;
    -webkit-transform: translateX(0); /* Chrome, Opera 15+, Safari 3.1+ */
    -ms-transform: translateX(0); /* IE 9 */
    transform: translateX(0); /* Firefox 16+, IE 10+, Opera */
  }

  #loader-wrapper .loader-section.section-left {
    left: 0;
  }

  #loader-wrapper .loader-section.section-right {
    right: 0;
  }

  /* Loaded */
  .loaded #loader-wrapper .loader-section.section-left {
    -webkit-transform: translateX(-100%); /* Chrome, Opera 15+, Safari 3.1+ */
    -ms-transform: translateX(-100%); /* IE 9 */
    transform: translateX(-100%); /* Firefox 16+, IE 10+, Opera */

    -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
    transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
  }

  .loaded #loader-wrapper .loader-section.section-right {
    -webkit-transform: translateX(100%); /* Chrome, Opera 15+, Safari 3.1+ */
    -ms-transform: translateX(100%); /* IE 9 */
    transform: translateX(100%); /* Firefox 16+, IE 10+, Opera */

    -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
    transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
  }

  .loaded #loader {
    opacity: 0;
    -webkit-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
  }

  .loaded #loader-wrapper {
    visibility: hidden;

    -webkit-transform: translateY(-100%); /* Chrome, Opera 15+, Safari 3.1+ */
    -ms-transform: translateY(-100%); /* IE 9 */
    transform: translateY(-100%); /* Firefox 16+, IE 10+, Opera */

    -webkit-transition: all 0.3s 1s ease-out;
    transition: all 0.3s 1s ease-out;
  }
</style>
</head>

<body id="body" class="app header-fixed sidebar-fixed aside-menu-fixed sidebar-lg-show"
      style="overflow: hidden!important; background-color: white">
<div id="loader-wrapper">
  <div id="loader"></div>
  <div class="loader-section section-left"></div>
  <div class="loader-section section-right"></div>
</div>
</body>
</html>

<script src="3rd/jquery/jquery-3.2.1.min.js"></script>
<script src="3rd/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="3rd/moment/moment.min.js"></script>
<script src="3rd/rxjs/rxjs.umd.js"></script>
<script src="3rd/rxjs/rxjs-pubsub.js"></script>

<script async src="3rd/echarts/echarts.min.js"></script>
<script async src="3rd/layer/layer.js"></script>
<script src="3rd/handlebars/handlebars-v4.0.11.js"></script>
<script async src="3rd/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script async src="3rd/bootstrap-datetimepicker/js/zh-cn.js"></script>
<script async src="3rd/daterangepicker/daterangepicker.js"></script>
<script async src="3rd/perfect-scrollbar/js/perfect-scrollbar.min.js"></script>
<script async src="3rd/select2/dist/js/select2.full.js"></script>
<script async src="3rd/pureScriptSelect/script.js"></script>
<script async src="3rd/viewerjs/viewer.js"></script>
<script src="3rd/clapr-0.4.7/clappr.min.js"></script>
<script src="3rd/codemirror/codemirror.js"></script>
<script src="3rd/codemirror/addon/placeholder.js"></script>
<script src="3rd/codemirror/mode/javascript/javascript.js"></script>
<script src="3rd/codemirror/mode/groovy/groovy.js"></script>
<script async src="3rd/resizesensor/ElementQueries.js"></script>
<script async src="3rd/resizesensor/ResizeSensor.js"></script>
<script async src="3rd/showdown/showdown.min.js"></script>
<script async src="3rd/gridstack/gridstack-h5.js"></script>
<script async src="3rd/tagify/tagify.min.js"></script>
<script src="3rd/popper/popper.min.js"></script>
<script src="3rd/tippy/tippy.min.js"></script>
<script src="/3rd/fullcalendar-6.1.8/dist/index.global.min.js"></script>

<script async src="3rd/highlight/highlight.min.js"></script>
<script async src="3rd/quill/quill.min.js"></script>
<!--<script src="3rd/x-spreadsheet/xspreadsheet.js"></script>-->
<!--<script src="3rd/x-spreadsheet/zh-cn.js"></script>-->
<script src="3rd/trumbowyg/trumbowyg.js"></script>
<script src="3rd/trumbowyg/plugins/table/trumbowyg.table.min.js"></script>
<script src="3rd/trumbowyg/langs/zh_cn.min.js"></script>
<script src="3rd/docx2html/docx2html.min.js"></script>
<script src="3rd/bpnm-js-9.4.0/bpmn-modeler.production.min.js"></script>

<!-- 自主开源作为第三方 -->
<script>module = {exports: {}};</script>
<script src="3rd/gosheet/gosheet.min.js"></script>

<script src="js/kui/kui-all.js"></script>
<script src="js/juno/stdbiz.js"></script>

<script>
PubSub = RxJsPubSub.create();

setTimeout(() => {
  ajax.view({
    url: 'html/${app.name}/main.html',
    containerId: 'body',
    empty: false,
    data: {},
    success: function () {
      document.body.classList.add('loaded');
    }
  });
}, 1000);
</script>

