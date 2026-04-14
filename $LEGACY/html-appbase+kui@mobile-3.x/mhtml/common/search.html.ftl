<div id="pageCommonSearch" class="mobile page" style="background: var(--color-white);">
	<div class="d-flex align-items-center full-width"
			 style="height: 45px; background: #f8f8f8;">
		<div class="d-flex align-items-center full-width"
				 style="width: 320px;height: 32px;margin-left: 4px;background: #e5e5e5;">
			<div style="flex: 10;">
				<p style="width: 40px; height: 100%;
								  text-align: center;
								  margin-bottom: unset;
								  margin-top: unset;
								  margin-right: 12px;
								  border-right: 1px solid #5f646e;">宝贝</p>
			</div>
			<div style="flex: 50;">
				<input type="text" placeholder="请输入内容" autocomplete="off"
				       style="border: none;
											-webkit-tap-highlight-color: rgba(255,0,0,0);
											outline: none;
											-webkit-appearance: none;
											width: 9.16rem;
											height: 100%;
											background-color: #e5e5e5;"/>
			</div>
		</div>
		<div style="flex: 2;
								display: inline-block;
								width: 36px;
								font-size: 16px;
								text-align: center;">搜索</div>
	</div>
	<div id='content'>
		<div style="padding: 6px;">
			<div style="margin: 12px 6px;">
				<p style="font-size: 16px; font-weight: bold;display: inline-block; width: 120px; margin: unset;">历史搜索</p>
				<div style="float: right;">
					<i class="far fa-trash-alt"></i>
				</div>
			</div>
			<div widget-id="widgetHistory" style='width:100%'>
			</div>
		</div>
		<div style="padding: 6px;">
			<div style="margin: 12px 6px;">
				<p style="font-size: 16px; font-weight: bold;display: inline-block; width: 120px; margin: unset;">搜索发现</p>
				<div style="float: right;">
					<i class="far fa-eye"></i>
				</div>
			</div>
			<div widget-id="widgetFrequent" style='width:100%'>
			</div>
		</div>
	</div>
</div>

<script>
function PageCommonSearch() {
	this.page = dom.find('#pageCommonSearch');
}

PageCommonSearch.prototype.initialize = async function (params) {
	dom.init(this, this.page);
	let data = await xhr.promise({
		url: ${app.name}.URL_${app.name?upper_case}_COMMON_SEARCH,
		params: {}
	});
	for (let i = 0; i < data.history.length; i++) {
		let text = data.history[i].text;
		let el = dom.element(`
			<span style="display: inline-block;
									 height: 32px;
									 margin: 2px 4px;
									 padding: 0 8px;
									 text-align: center;
									 line-height: 32px;
									 background: #f5f5f5;">${r"$"}{text}</span>
		`);
		this.widgetHistory.appendChild(el);
	}
	for (let i = 0; i < data.frequent.length; i++) {
		let text = data.frequent[i].text;
		let el = dom.element(`
			<span style="display: inline-block;
									 height: 32px;
									 margin: 2px 4px;
									 padding: 0 8px;
									 text-align: center;
									 line-height: 32px;
									 background: #f5f5f5;">${r"$"}{text}</span>
		`);
		this.widgetFrequent.appendChild(el);
	}
};

PageCommonSearch.prototype.show = function (params) {
	this.initialize(params);
};

pageCommonSearch = new PageCommonSearch();
</script>