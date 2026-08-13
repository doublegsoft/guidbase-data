<#import "/$/guidbase-tile.ftl" as guidbase_tile>

<!----------------------------------------------------------------------------->
<!--                            SCROLL NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_scroll_navigator_layout navigator indent=0>
${""?left_pad(indent)}ScrollView(.horizontal, showsIndicators: false) {
${""?left_pad(indent)}  HStack(spacing: 0) {
${""?left_pad(indent)}    ForEach(self.${js.nameVariable(navigator.id)}Items, id: \.id) { item in
${""?left_pad(indent)}      VStack(spacing: 0) {
${""?left_pad(indent)}        Text(item.title)
${""?left_pad(indent)}          .font(.system(size: 14, weight: self.activeNavId == item.id ? .bold : .regular))
${""?left_pad(indent)}          .foregroundColor(self.activeNavId == item.id ? Color.primary : Color.textPrimary)
${""?left_pad(indent)}        if self.activeNavId == item.id {
${""?left_pad(indent)}          Color.primary
${""?left_pad(indent)}            .frame(width: 20, height: 2)
${""?left_pad(indent)}            .padding(.top, 4)
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .padding(.horizontal, 16)
${""?left_pad(indent)}      .onTapGesture { 
${""?left_pad(indent)}        self.handle${js.nameType(navigator.id)}Click(id: item.id) 
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<#macro print_scroll_navigator_methods navigator indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}private var ${swift.nameVariable(navigator.id)}: some View {
${""?left_pad(indent)}  VStack(spacing: 10) {
${""?left_pad(indent)}    ScrollView(.horizontal, showsIndicators: false) {
${""?left_pad(indent)}      LazyHStack(spacing: 12) {
${""?left_pad(indent)}        ForEach(Array(carouselItems.enumerated()), id: \.offset) { idx, item in
${""?left_pad(indent)}          carouselCard(item)
${""?left_pad(indent)}          .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 24)
${""?left_pad(indent)}          .scrollTransition { content, phase in
${""?left_pad(indent)}            content
${""?left_pad(indent)}            .scaleEffect(phase.isIdentity ? 1 : 0.92)
${""?left_pad(indent)}            .opacity(phase.isIdentity ? 1 : 0.6)
${""?left_pad(indent)}          }
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .scrollTargetLayout()
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .scrollTargetBehavior(.viewAligned)
${""?left_pad(indent)}    .scrollPosition(id: .init(get: {
${""?left_pad(indent)}      carouselIndex
${""?left_pad(indent)}    }, set: { newIdx in
${""?left_pad(indent)}      if let idx = newIdx { carouselIndex = idx }
${""?left_pad(indent)}    }))
${""?left_pad(indent)}
${""?left_pad(indent)}    // 页面指示器
${""?left_pad(indent)}    HStack(spacing: 6) {
${""?left_pad(indent)}      ForEach(0..<carouselItems.count, id: \.self) { i in
${""?left_pad(indent)}        Capsule()
${""?left_pad(indent)}          .fill(i == carouselIndex ? Color.primary : Color.divider)
${""?left_pad(indent)}          .frame(width: i == carouselIndex ? 16 : 6, height: 6)
${""?left_pad(indent)}          .animation(.spring(response: 0.3), value: carouselIndex)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}private func ${swift.nameVariable(navigator.id)}Item(_ item: CarouselCard) -> some View {
${""?left_pad(indent)}  ZStack(alignment: .bottomLeading) {
${""?left_pad(indent)}    RoundedRectangle(cornerRadius: 16)
${""?left_pad(indent)}      .fill(
${""?left_pad(indent)}        LinearGradient(
${""?left_pad(indent)}          colors: [item.color, item.color.opacity(0.7)],
${""?left_pad(indent)}          startPoint: .topLeading,
${""?left_pad(indent)}          endPoint: .bottomTrailing
${""?left_pad(indent)}        )
${""?left_pad(indent)}      )
${""?left_pad(indent)}
${""?left_pad(indent)}    // 装饰背景图标
${""?left_pad(indent)}    Text(item.icon)
${""?left_pad(indent)}      .font(.system(size: 80))
${""?left_pad(indent)}      .opacity(0.18)
${""?left_pad(indent)}      .rotationEffect(.degrees(10))
${""?left_pad(indent)}      .offset(x: 140, y: -30)
${""?left_pad(indent)}
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 6) {
${""?left_pad(indent)}      Text(item.title)
${""?left_pad(indent)}        .font(.system(size: 20, weight: .bold))
${""?left_pad(indent)}        .foregroundColor(.white)
${""?left_pad(indent)}      Text(item.subtitle)
${""?left_pad(indent)}        .font(.system(size: 13))
${""?left_pad(indent)}        .foregroundColor(.white.opacity(0.85))
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(20)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(height: 140)
${""?left_pad(indent)}  .padding(.horizontal, 16)
${""?left_pad(indent)}  .shadow(color: item.color.opacity(0.2), radius: 8, y: 4)
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                             SLIDE NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_slide_navigator_layout navigator indent=0>
${""?left_pad(indent)}TabView {
${""?left_pad(indent)}  ForEach(self.${js.nameVariable(navigator.id)}Items, id: \.id) { item in
${""?left_pad(indent)}    AsyncImage(url: URL(string: item.imageUrl)) { phase in
${""?left_pad(indent)}      if let image = phase.image {
${""?left_pad(indent)}        image.resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      } else {
${""?left_pad(indent)}        Color.divider
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity, maxHeight: .infinity)
${""?left_pad(indent)}    .clipped()
${""?left_pad(indent)}    .contentShape(Rectangle())
${""?left_pad(indent)}    .onTapGesture { 
${""?left_pad(indent)}      self.handle${js.nameType(navigator.id)}Click(link: item.link) 
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.frame(height: 180)
</#macro>

<!----------------------------------------------------------------------------->
<!--                            BUTTON NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_button_navigator_layout navigator indent=0>
${""?left_pad(indent)}LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 16) {
${""?left_pad(indent)}  ForEach(self.${js.nameVariable(navigator.id)}Items, id: \.id) { item in
${""?left_pad(indent)}    VStack(spacing: 0) {
${""?left_pad(indent)}      AsyncImage(url: URL(string: item.iconUrl)) { phase in
${""?left_pad(indent)}        if let image = phase.image {
${""?left_pad(indent)}          image.resizable()
${""?left_pad(indent)}            .aspectRatio(contentMode: .fit)
${""?left_pad(indent)}        } else {
${""?left_pad(indent)}          Color.gray
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .frame(width: 44, height: 44)
${""?left_pad(indent)}      .padding(.bottom, 8)
${""?left_pad(indent)}      Text(item.title)
${""?left_pad(indent)}        .font(.system(size: 12))
${""?left_pad(indent)}        .foregroundColor(Color.textPrimary)
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .contentShape(Rectangle())
${""?left_pad(indent)}    .onTapGesture { 
${""?left_pad(indent)}      self.handle${js.nameType(navigator.id)}Click(item: item) 
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(.vertical, 8)
${""?left_pad(indent)}.background(Color.surface)
</#macro>

<!----------------------------------------------------------------------------->
<!--                             LIST NAVIGATOR                              -->
<!----------------------------------------------------------------------------->
<#macro print_list_navigator_layout navigator indent=0>
${""?left_pad(indent)}List {
${""?left_pad(indent)}  ForEach(self.${js.nameVariable(navigator.id)}Items, id: \.id) { item in
${""?left_pad(indent)}    HStack(spacing: 0) {
${""?left_pad(indent)}      HStack(spacing: 0) {
${""?left_pad(indent)}        if let icon = item.icon {
${""?left_pad(indent)}          Image(icon)
${""?left_pad(indent)}            .resizable()
${""?left_pad(indent)}            .frame(width: 24, height: 24)
${""?left_pad(indent)}            .padding(.right, 12)
${""?left_pad(indent)}        }
${""?left_pad(indent)}        Text(item.title)
${""?left_pad(indent)}          .font(.system(size: 16))
${""?left_pad(indent)}          .foregroundColor(Color.textPrimary)
${""?left_pad(indent)}      }
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      Text(">")
${""?left_pad(indent)}        .font(.system(size: 16))
${""?left_pad(indent)}        .foregroundColor(Color.textMuted)
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .contentShape(Rectangle())
${""?left_pad(indent)}    .padding(.horizontal, 16)
${""?left_pad(indent)}    .padding(.vertical, 12)
${""?left_pad(indent)}    .background(Color.surface)
${""?left_pad(indent)}    .listRowInsets(EdgeInsets())
${""?left_pad(indent)}    .listRowSeparatorTint(Color.divider)
${""?left_pad(indent)}    .onTapGesture { 
${""?left_pad(indent)}      self.handle${js.nameType(navigator.id)}Click(item: item) 
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.listStyle(.plain)
${""?left_pad(indent)}.background(Color.surface)
</#macro>

<#macro print_list_navigator_methods navigator indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}private var ${swift.nameVariable(navigator.id)}: some View {
${""?left_pad(indent)}  VStack(spacing: 0) {
${""?left_pad(indent)}    ForEach(Array(${swift.nameVariable(navigator.id)}Rows.enumerated()), id: \.element.id) { idx, dept in
${""?left_pad(indent)}      VStack(spacing: 0) {
${""?left_pad(indent)}        HStack(spacing: 10) {
${""?left_pad(indent)}          Text(dept.icon).font(.system(size: 20))
${""?left_pad(indent)}          VStack(alignment: .leading, spacing: 2) {
${""?left_pad(indent)}            Text(dept.name)
${""?left_pad(indent)}              .font(.system(size: 15, weight: .medium))
${""?left_pad(indent)}              .foregroundColor(.textPrimary)
${""?left_pad(indent)}            Text(dept.description)
${""?left_pad(indent)}              .font(.system(size: 11))
${""?left_pad(indent)}              .foregroundColor(.textMuted)
${""?left_pad(indent)}              .lineLimit(1)
${""?left_pad(indent)}          }
${""?left_pad(indent)}          Spacer()
${""?left_pad(indent)}          Image(systemName: "chevron.right")
${""?left_pad(indent)}            .font(.system(size: 12))
${""?left_pad(indent)}            .foregroundColor(.textMuted)
${""?left_pad(indent)}        }
${""?left_pad(indent)}        .padding(14)
${""?left_pad(indent)}
${""?left_pad(indent)}        if idx < min(3, deptTree.count) - 1 {
${""?left_pad(indent)}          Divider().overlay(Color.divider).padding(.leading, 56)
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .background(
${""?left_pad(indent)}        NavigationLink(destination: childListView(dept)) {
${""?left_pad(indent)}          EmptyView()
${""?left_pad(indent)}        }
${""?left_pad(indent)}        .opacity(0)
${""?left_pad(indent)}      )
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .background(Color.surface)
${""?left_pad(indent)}  .clipShape(RoundedRectangle(cornerRadius: 12))
${""?left_pad(indent)}  .shadow(color: .black.opacity(0.03), radius: 6, y: 2)
${""?left_pad(indent)}  .padding(.horizontal, 16)
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                               LIST VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_layout list indent=0>
  <#local url = valuebase.url(list.value("data"))>
  <#local dataObj = model.findObjectByName(url.resource)>
  <#local idAttr = modelbase.get_id_attributes(dataObj)?first>
${""?left_pad(indent)}VStack(spacing: 0) {
${""?left_pad(indent)}  List {
${""?left_pad(indent)}    ForEach(self.${ts.nameVariable(list.id)}Rows, id: \.${modelbase.get_attribute_sql_name(idAttr)}) { row in
${""?left_pad(indent)}      VStack(spacing: 0) {
${""?left_pad(indent)}        tileRow(row)
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .listRowInsets(EdgeInsets())
${""?left_pad(indent)}      .listRowBackground(Color.clear)
${""?left_pad(indent)}      .onTapGesture {
${""?left_pad(indent)}        self.handle${ts.nameType(list.id)}Click(row: row)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}
${""?left_pad(indent)}    if self.isLoading${ts.nameType(list.id)} {
${""?left_pad(indent)}      ProgressView()
${""?left_pad(indent)}        .frame(maxWidth: .infinity, alignment: .center)
${""?left_pad(indent)}        .listRowInsets(EdgeInsets())
${""?left_pad(indent)}        .listRowBackground(Color.clear)
${""?left_pad(indent)}    } else if self.${ts.nameVariable(list.id)}Rows.isEmpty {
${""?left_pad(indent)}      Text("暂无数据")
${""?left_pad(indent)}        .font(.system(size: 14))
${""?left_pad(indent)}        .foregroundColor(Color.textMuted)
${""?left_pad(indent)}        .frame(maxWidth: .infinity, alignment: .center)
${""?left_pad(indent)}        .listRowInsets(EdgeInsets())
${""?left_pad(indent)}        .listRowBackground(Color.clear)
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      Color.clear
${""?left_pad(indent)}        .frame(height: 1)
${""?left_pad(indent)}        .onAppear {
${""?left_pad(indent)}           self.handle${ts.nameType(list.id)}Load()
${""?left_pad(indent)}        }
${""?left_pad(indent)}        .listRowInsets(EdgeInsets())
${""?left_pad(indent)}        .listRowBackground(Color.clear)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .listStyle(.plain)
${""?left_pad(indent)}  .background(Color.background)
${""?left_pad(indent)}  .refreshable {
${""?left_pad(indent)}    await self.handle${ts.nameType(list.id)}Refresh()
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .onAppear {
${""?left_pad(indent)}    Task {
${""?left_pad(indent)}      await self.load${ts.nameType(list.id)}Rows()
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<#macro print_list_view_variables list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${list.id}】列表视图相关变量，包括列表数据、正在刷新、正在加载等变量
${""?left_pad(indent)} */
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var ${ts.nameVariable(list.id)}Rows: [${ts.nameType(url.resource)}] = []
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isRefreshing${ts.nameType(list.id)}: Bool = false
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isLoading${ts.nameType(list.id)}: Bool = false
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var ${ts.nameVariable(list.id)}SearchText: String = ""
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var is${ts.nameType(list.id)}CriteriaShown: Bool = false
${""?left_pad(indent)}@FocusState
${""?left_pad(indent)}private var is${ts.nameType(list.id)}SearchFocused: Bool
</#macro>

<#macro print_list_view_methods list indent=0>
  <#local url = valuebase.url(list.value("data"))>
  <#local next = valuebase.url(list.value("next"))>
  <#local nextPage = guidbase.get_page(app, next.resource)>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}  
${""?left_pad(indent)}func load${ts.nameType(list.id)}Rows() async {
${""?left_pad(indent)}  let result = await SDK.fetch${ts.nameType(inflector.pluralize(url.resource))}(params: [:])
${""?left_pad(indent)}  self.${ts.nameVariable(list.id)}Rows.append(contentsOf: result.data)
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(list.id)}Refresh() async {
${""?left_pad(indent)}  self.isRefreshing${ts.nameType(list.id)} = true
${""?left_pad(indent)}  self.${ts.nameVariable(list.id)}Rows = []
${""?left_pad(indent)}  await self.load${ts.nameType(list.id)}Rows()
${""?left_pad(indent)}  self.isRefreshing${ts.nameType(list.id)} = false
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(list.id)}Load() {
${""?left_pad(indent)}  guard !self.isLoading${ts.nameType(list.id)} else { return }
${""?left_pad(indent)}  self.isLoading${ts.nameType(list.id)} = true
${""?left_pad(indent)}  Task {
${""?left_pad(indent)}    await self.load${ts.nameType(list.id)}Rows()
${""?left_pad(indent)}    self.isLoading${ts.nameType(list.id)} = false
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(list.id)}Click(row: ${ts.nameType(url.resource)}) {
<#--  ${""?left_pad(indent)}  self.router.pushUrl(
${""?left_pad(indent)}    url: "pages/${nextPage.module}/${ts.nameType(nextPage.name)}",
${""?left_pad(indent)}    params: ["${modelbase.get_attribute_sql_name(idAttr)}": row.${modelbase.get_attribute_sql_name(idAttr)}]
${""?left_pad(indent)}  )  -->
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}@ViewBuilder
${""?left_pad(indent)}private func tileRow(_ row: ${ts.nameType(url.resource)}) -> some View {
<#--  ${""?left_pad(indent)}  NavigationLink(destination: ListFormPage()) {  -->
<@guidbase_tile.print_tile_layout widget=list indent=indent+2 />
<#--  ${""?left_pad(indent)}  }
${""?left_pad(indent)}  .buttonStyle(.plain)  -->
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                              SEARCH BOX                                 -->
<!----------------------------------------------------------------------------->
<#macro print_search_box_layout list indent=0>
${""?left_pad(indent)}HStack(spacing: 8) {
${""?left_pad(indent)}  Image(systemName: "magnifyingglass")
${""?left_pad(indent)}    .font(.system(size: 14))
${""?left_pad(indent)}    .foregroundColor(Color.textMuted)
${""?left_pad(indent)}  TextField("搜索", text: $${ts.nameVariable(list.id)}SearchText)
${""?left_pad(indent)}    .font(.system(size: 14))
${""?left_pad(indent)}    .foregroundColor(Color.textPrimary)
${""?left_pad(indent)}    .focused($is${ts.nameType(list.id)}SearchFocused)
${""?left_pad(indent)}    .submitLabel(.search)
${""?left_pad(indent)}    .onSubmit {
${""?left_pad(indent)}      self.handle${ts.nameType(list.id)}Search()
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .onChange(of: self.is${ts.nameType(list.id)}SearchFocused) { focused in
${""?left_pad(indent)}      if focused {
${""?left_pad(indent)}        withAnimation(.easeInOut(duration: 0.25)) {
${""?left_pad(indent)}          self.is${ts.nameType(list.id)}CriteriaShown = true
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  if !self.${ts.nameVariable(list.id)}SearchText.isEmpty {
${""?left_pad(indent)}    Button(action: {
${""?left_pad(indent)}      self.${ts.nameVariable(list.id)}SearchText = ""
${""?left_pad(indent)}    }) {
${""?left_pad(indent)}      Image(systemName: "xmark.circle.fill")
${""?left_pad(indent)}        .font(.system(size: 14))
${""?left_pad(indent)}        .foregroundColor(Color.textMuted)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(.horizontal, 12)
${""?left_pad(indent)}.padding(.vertical, 8)
${""?left_pad(indent)}.background(Color.surface)
</#macro>

<!----------------------------------------------------------------------------->
<!--                            CRITERIA FORM                                -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_layout list indent=0>
${""?left_pad(indent)}if self.is${ts.nameType(list.id)}CriteriaShown {
${""?left_pad(indent)}  VStack(spacing: 0) {
  <#list list_view_criteria_children(list) as child>
<@print_list_view_criteria_input list=list input=child indent=indent+4 />
  </#list>
${""?left_pad(indent)}    HStack(spacing: 12) {
${""?left_pad(indent)}      Button(action: {
${""?left_pad(indent)}        self.handle${ts.nameType(list.id)}Reset()
${""?left_pad(indent)}      }) {
${""?left_pad(indent)}        Text("重置")
${""?left_pad(indent)}          .font(.system(size: 14))
${""?left_pad(indent)}          .foregroundColor(Color.textSecondary)
${""?left_pad(indent)}          .frame(maxWidth: .infinity)
${""?left_pad(indent)}          .padding(.vertical, 10)
${""?left_pad(indent)}          .background(Color.surface)
${""?left_pad(indent)}          .overlay(
${""?left_pad(indent)}            RoundedRectangle(cornerRadius: 8)
${""?left_pad(indent)}              .stroke(Color.divider, lineWidth: 1)
${""?left_pad(indent)}          )
${""?left_pad(indent)}      }
${""?left_pad(indent)}      Button(action: {
${""?left_pad(indent)}        self.handle${ts.nameType(list.id)}Search()
${""?left_pad(indent)}      }) {
${""?left_pad(indent)}        Text("搜索")
${""?left_pad(indent)}          .font(.system(size: 14, weight: .medium))
${""?left_pad(indent)}          .foregroundColor(.white)
${""?left_pad(indent)}          .frame(maxWidth: .infinity)
${""?left_pad(indent)}          .padding(.vertical, 10)
${""?left_pad(indent)}          .background(Color.primary)
${""?left_pad(indent)}          .cornerRadius(8)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(12)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .background(Color.surface)
${""?left_pad(indent)}  .transition(.move(edge: .top).combined(with: .opacity))
${""?left_pad(indent)}}
</#macro>

<#macro print_list_view_criteria_input list input indent=0>
  <#if input.type == "date" || input.type == "datetime">
${""?left_pad(indent)}DateRow(
${""?left_pad(indent)}  label: "${input.title}",
${""?left_pad(indent)}  value: $${ts.nameVariable(list.id)}Criteria${ts.nameType(input.id)}
${""?left_pad(indent)})
  <#elseif input.type == "number">
${""?left_pad(indent)}InputRow(
${""?left_pad(indent)}  label: "${input.title}",
${""?left_pad(indent)}  value: $${ts.nameVariable(list.id)}Criteria${ts.nameType(input.id)},
${""?left_pad(indent)}  keyboardType: .decimalPad
${""?left_pad(indent)})
  <#elseif input.type == "select">
${""?left_pad(indent)}DropdownRow(
${""?left_pad(indent)}  label: "${input.title}",
${""?left_pad(indent)}  value: $${ts.nameVariable(list.id)}Criteria${ts.nameType(input.id)},
${""?left_pad(indent)}  options: self.${ts.nameVariable(input.id)}Options
${""?left_pad(indent)})
  <#elseif input.type == "multiselect">
${""?left_pad(indent)}MultiSelectRow(
${""?left_pad(indent)}  label: "${input.title}",
${""?left_pad(indent)}  value: $${ts.nameVariable(list.id)}Criteria${ts.nameType(input.id)},
${""?left_pad(indent)}  options: self.${ts.nameVariable(input.id)}Options
${""?left_pad(indent)})
  <#else>
${""?left_pad(indent)}InputRow(
${""?left_pad(indent)}  label: "${input.title}",
${""?left_pad(indent)}  value: $${ts.nameVariable(list.id)}Criteria${ts.nameType(input.id)}
${""?left_pad(indent)})
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               GRID VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_grid_view_layout grid indent=0>
  <#local url = valuebase.url(grid.value("data"))>
${""?left_pad(indent)}ScrollView {
${""?left_pad(indent)}  HStack(alignment: .top, spacing: 8) {
${""?left_pad(indent)}    LazyVStack(spacing: 8) {
${""?left_pad(indent)}      ForEach(self.left${ts.nameType(grid.id)}, id: \.id) { row in
${""?left_pad(indent)}        self.build${ts.nameType(grid.id)}Tile(row: row)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    LazyVStack(spacing: 8) {
${""?left_pad(indent)}      ForEach(self.right${ts.nameType(grid.id)}, id: \.id) { row in
${""?left_pad(indent)}        self.build${ts.nameType(grid.id)}Tile(row: row)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(.horizontal, 12)
${""?left_pad(indent)}  .padding(.vertical, 8)
${""?left_pad(indent)}  
${""?left_pad(indent)}  if self.isLoading${ts.nameType(grid.id)} {
${""?left_pad(indent)}    ProgressView()
${""?left_pad(indent)}      .frame(maxWidth: .infinity, alignment: .center)
${""?left_pad(indent)}      .padding(.vertical, 8)
${""?left_pad(indent)}  } else {
${""?left_pad(indent)}    Color.clear
${""?left_pad(indent)}      .frame(height: 1)
${""?left_pad(indent)}      .onAppear {
${""?left_pad(indent)}        self.handle${ts.nameType(grid.id)}Load()
${""?left_pad(indent)}      }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.background(Color.background)
${""?left_pad(indent)}.refreshable {
${""?left_pad(indent)}  await self.handle${ts.nameType(grid.id)}Refresh()
${""?left_pad(indent)}}
</#macro>

<#macro print_grid_view_variables grid indent=0>
  <#local url = valuebase.url(grid.value("data"))>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${grid.id}】列表视图相关变量，包括列表数据、左列数据、右列数据、正在刷新、正在加载等变量
${""?left_pad(indent)} */
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var ${ts.nameVariable(grid.id)}Rows: [${ts.nameType(url.resource)}] = []
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var left${ts.nameType(grid.id)}: [${ts.nameType(url.resource)}] = []
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var right${ts.nameType(grid.id)}: [${ts.nameType(url.resource)}] = []
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isRefreshing${ts.nameType(grid.id)}: Bool = false
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isLoading${ts.nameType(grid.id)}: Bool = false
</#macro>

<#macro print_grid_view_methods grid indent=0>
  <#local url = valuebase.url(grid.value("data"))>
  <#local next = valuebase.url(grid.value("next"))>
  <#local nextPage = guidbase.get_page(app, next.resource)>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}  
${""?left_pad(indent)}func onAppear() {
${""?left_pad(indent)}  Task {
${""?left_pad(indent)}    await self.load${ts.nameType(grid.id)}Rows()
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}  
${""?left_pad(indent)}func load${ts.nameType(grid.id)}Rows() async {
${""?left_pad(indent)}  do {
${""?left_pad(indent)}    let result = try await SDK.fetch${ts.nameType(inflector.pluralize(url.resource))}()
${""?left_pad(indent)}    self.${ts.nameVariable(grid.id)}Rows.append(contentsOf: result.data)
${""?left_pad(indent)}    self.distributeToColumns()
${""?left_pad(indent)}  } catch {
${""?left_pad(indent)}    // handle error
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(grid.id)}Refresh() async {
${""?left_pad(indent)}  self.isRefreshing${ts.nameType(grid.id)} = true
${""?left_pad(indent)}  self.${ts.nameVariable(grid.id)}Rows = []
${""?left_pad(indent)}  await self.load${ts.nameType(grid.id)}Rows()
${""?left_pad(indent)}  self.isRefreshing${ts.nameType(grid.id)} = false
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(grid.id)}Load() {
${""?left_pad(indent)}  guard !self.isLoading${ts.nameType(grid.id)} else { return }
${""?left_pad(indent)}  self.isLoading${ts.nameType(grid.id)} = true
${""?left_pad(indent)}  Task {
${""?left_pad(indent)}    await self.load${ts.nameType(grid.id)}Rows()
${""?left_pad(indent)}    self.isLoading${ts.nameType(grid.id)} = false
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(grid.id)}Click(row: ${ts.nameType(url.resource)}) {
${""?left_pad(indent)}  self.router.pushUrl(
${""?left_pad(indent)}    url: "pages/${nextPage.module}/${ts.nameType(nextPage.name)}",
${""?left_pad(indent)}    params: ["${modelbase.get_attribute_sql_name(idAttr)}": row.${modelbase.get_attribute_sql_name(idAttr)}]
${""?left_pad(indent)}  )
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 贪心分配：每张卡片放到当前总高较短的一列，保持两列视觉平衡。
${""?left_pad(indent)} */
${""?left_pad(indent)}func distributeToColumns() {
${""?left_pad(indent)}  var left: [${ts.nameType(url.resource)}] = []
${""?left_pad(indent)}  var right: [${ts.nameType(url.resource)}] = []
${""?left_pad(indent)}  var leftH: CGFloat = 0
${""?left_pad(indent)}  var rightH: CGFloat = 0
${""?left_pad(indent)}
${""?left_pad(indent)}  for i in 0..<self.${ts.nameVariable(grid.id)}Rows.count {
${""?left_pad(indent)}    let row = self.${ts.nameVariable(grid.id)}Rows[i]
${""?left_pad(indent)}    // 预估高度：丰富卡更高
${""?left_pad(indent)}    let estHeight: CGFloat = (i % 3 == 0) ? 380 : 220
${""?left_pad(indent)}    if leftH <= rightH {
${""?left_pad(indent)}      left.append(row)
${""?left_pad(indent)}      leftH += estHeight
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      right.append(row)
${""?left_pad(indent)}      rightH += estHeight
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}
${""?left_pad(indent)}  self.left${ts.nameType(grid.id)} = left
${""?left_pad(indent)}  self.right${ts.nameType(grid.id)} = right
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}@ViewBuilder
${""?left_pad(indent)}func build${ts.nameType(grid.id)}Tile(row: ${ts.nameType(url.resource)}) -> some View {
<@guidbase_tile.print_tile_layout widget=grid indent=indent+2 /> 
${""?left_pad(indent)}  .onTapGesture {  
${""?left_pad(indent)}    self.handle${ts.nameType(grid.id)}Click(row: row)
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                              ENTRY FORM                                 -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_layout form indent=0>
  <#local url = valuebase.url(form.value("data"))>
${""?left_pad(indent)}ScrollView {  
${""?left_pad(indent)}  VStack(spacing: 16) {
  <#list form.groups() as group>
${""?left_pad(indent)}    self.formSection${group?index + 1}
  </#list>
${""?left_pad(indent)}    HStack {
${""?left_pad(indent)}      Button(action: {
${""?left_pad(indent)}        self.handle${ts.nameType(form.id)}Save()
${""?left_pad(indent)}      }) {
${""?left_pad(indent)}        Text(self.isSaving${ts.nameType(form.id)} ? "保存中..." : "保存")
${""?left_pad(indent)}          .font(.system(size: 15, weight: .bold))
${""?left_pad(indent)}          .foregroundColor(.white)
${""?left_pad(indent)}          .frame(maxWidth: .infinity)
${""?left_pad(indent)}          .padding(.vertical, 12)
${""?left_pad(indent)}          .background(self.isSaving${ts.nameType(form.id)} ? Color.gray : Color.primary)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .disabled(self.isSaving${ts.nameType(form.id)})
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .padding(.horizontal, 20)
${""?left_pad(indent)}    .padding(.top, 12)
${""?left_pad(indent)}    .padding(.bottom, 24)
${""?left_pad(indent)}    .background(Color.surface)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(16)
${""?left_pad(indent)}  .background(Color.surface)
${""?left_pad(indent)}}
</#macro>

<#macro print_entry_form_variables form indent=0>
  <#local url = valuebase.url(form.value("data"))>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${form.id}】输入表单相关变量，包括表单数据、正在加载等变量
${""?left_pad(indent)} */
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var ${ts.nameVariable(form.id)}Data: ${ts.nameType(url.resource)}? = SDK.new${ts.nameType(url.resource)}()
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isLoading${ts.nameType(form.id)}: Bool = false
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isSaving${ts.nameType(form.id)}: Bool = false
  <#list form.inputs as input>
    <#if input.type != "select" && input.type != "multiselect" && input.type != "cascade"><#continue></#if>
${""?left_pad(indent)}@State
    <#if input.value("data")?starts_with("enum")>
${""?left_pad(indent)}private var ${ts.nameVariable(input.id)}Options: [Option] = SDK.get${ts.nameType(input.id)}Options()    
    <#else>
${""?left_pad(indent)}private var ${ts.nameVariable(input.id)}Options: [Option] = []
    </#if>
  </#list>
</#macro>

<#macro print_entry_form_methods form indent=0>
  <#local url = valuebase.url(form.value("data"))>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}  
${""?left_pad(indent)}func onAppear() {
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect") && input.value("data") != "" && !input.value("data")?starts_with("enum")>
      <#local inputUrl = valuebase.url(input.value("data"))>
${""?left_pad(indent)}  Task {   
${""?left_pad(indent)}    let opts = await SDK.fetch${ts.nameType(inputUrl.resource)}AsOptions()
${""?left_pad(indent)}    await MainActor.run {
${""?left_pad(indent)}      self.${ts.nameVariable(input.id)}Options = opts
${""?left_pad(indent)}    }   
${""?left_pad(indent)}  }  
    </#if>
  </#list>  
${""?left_pad(indent)}  Task {
${""?left_pad(indent)}    await self.load${ts.nameType(form.id)}Data(${modelbase.get_attribute_sql_name(idAttr)}: ${modelbase.get_attribute_sql_name(idAttr)})
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}  
${""?left_pad(indent)}func load${ts.nameType(form.id)}Data(${modelbase.get_attribute_sql_name(idAttr)}: ${guidbase4swift.type_attribute_primitive(idAttr)}) async {
${""?left_pad(indent)}  let result = try await SDK.fetch${ts.nameType(url.resource)}(params: ["${modelbase.get_attribute_sql_name(idAttr)}": ${modelbase.get_attribute_sql_name(idAttr)}])
${""?left_pad(indent)}  await MainActor.run {
${""?left_pad(indent)}    self.${ts.nameVariable(form.id)}Data = result
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(form.id)}Save() {
${""?left_pad(indent)}  
${""?left_pad(indent)}}
  <#list form.groups() as group>
${""?left_pad(indent)}
${""?left_pad(indent)}@ViewBuilder
${""?left_pad(indent)}private var formSection${group?index + 1}: some View {
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 12) {
${""?left_pad(indent)}    FormSectionTitle(title: "${group}") 
    <#local rows = form.rows(group, 1)>
    <#list rows as row>
      <#list row as input>
<@print_input_layout input=input indent=indent+4 />         
      </#list>
    </#list>
${""?left_pad(indent)}  }
${""?left_pad(indent)}} 
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                             DISPLAY FORM                                -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_layout form indent=0>
  <#local url = valuebase.url(form.value("data"))>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}ScrollView {  
${""?left_pad(indent)}  VStack(spacing: 16) {
  <#list form.groups() as group>
${""?left_pad(indent)}    self.formSection${group?index + 1}
  </#list>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(16)
${""?left_pad(indent)}  .background(Color.background)
${""?left_pad(indent)}  .cornerRadius(8)
${""?left_pad(indent)}  .onAppear {
${""?left_pad(indent)}    Task {
${""?left_pad(indent)}      await self.load${ts.nameType(form.id)}Data(${modelbase.get_attribute_sql_name(idAttr)}: self.${modelbase.get_attribute_sql_name(idAttr)})
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<#macro print_display_form_variables form indent=0>
  <#local url = valuebase.url(form.value("data"))>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${form.id}】只读表单相关变量，包括表单数据、正在加载等变量
${""?left_pad(indent)} */
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var ${ts.nameVariable(form.id)}Data: ${ts.nameType(url.resource)}? = nil
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var isLoading${ts.nameType(form.id)}: Bool = false
</#macro>

<#macro print_display_form_methods form indent=0>
  <#local url = valuebase.url(form.value("data"))>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}  
${""?left_pad(indent)}func load${ts.nameType(form.id)}Data(${modelbase.get_attribute_sql_name(idAttr)}: ${guidbase4swift.type_attribute_primitive(idAttr)}) async {
${""?left_pad(indent)}  let result = try await SDK.fetch${ts.nameType(url.resource)}(params: ["${modelbase.get_attribute_sql_name(idAttr)}": ${modelbase.get_attribute_sql_name(idAttr)}])
${""?left_pad(indent)}  await MainActor.run {
${""?left_pad(indent)}    self.${ts.nameVariable(form.id)}Data = result
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
  <#list form.groups() as group>
${""?left_pad(indent)}
${""?left_pad(indent)}@ViewBuilder
${""?left_pad(indent)}private var formSection${group?index + 1}: some View {
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 12) {
${""?left_pad(indent)}    FormSectionTitle(title: "${group}") 
    <#local rows = form.rows(group, 1)>
    <#list rows as row>
      <#list row as input>
        <#if input.type == "hidden"><#continue></#if>
<@print_readonly_layout readonly=input indent=indent+6 />
      </#list>
    </#list>
${""?left_pad(indent)}  }
${""?left_pad(indent)}} 
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 MAP                                     -->
<!----------------------------------------------------------------------------->
<#macro print_map_layout map indent=0>
</#macro>

<#macro print_map_methods map indent=0>
${""?left_pad(indent)}private var mapLayer: some View {
${""?left_pad(indent)}  Map(position: $camera, selection: $selectedLocation) {
${""?left_pad(indent)}    ForEach(HospitalLocation.samples) { hospital in
${""?left_pad(indent)}      Annotation(hospital.name, coordinate: hospital.coordinate) {
${""?left_pad(indent)}        VStack(spacing: 2) {
${""?left_pad(indent)}          ZStack {
${""?left_pad(indent)}            Circle()
${""?left_pad(indent)}              .fill(selectedLocation?.id == hospital.id
${""?left_pad(indent)}                ? Color.primary
${""?left_pad(indent)}                : Color.accentRed)
${""?left_pad(indent)}              .frame(width: 36, height: 36)
${""?left_pad(indent)}              .shadow(color: .black.opacity(0.2), radius: 4, y: 2)
${""?left_pad(indent)}
${""?left_pad(indent)}            Image(systemName: "cross.case.fill")
${""?left_pad(indent)}              .font(.system(size: 16))
${""?left_pad(indent)}              .foregroundColor(.white)
${""?left_pad(indent)}          }
${""?left_pad(indent)}
${""?left_pad(indent)}          Text(hospital.shortName)
${""?left_pad(indent)}            .font(.system(size: 10, weight: .bold))
${""?left_pad(indent)}            .foregroundColor(.textPrimary)
${""?left_pad(indent)}            .padding(.horizontal, 6)
${""?left_pad(indent)}            .padding(.vertical, 2)
${""?left_pad(indent)}            .background(.ultraThinMaterial)
${""?left_pad(indent)}            .clipShape(Capsule())
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .tag(hospital)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .mapStyle(.standard(pointsOfInterest: .excludingAll))
${""?left_pad(indent)}  .mapControls {
${""?left_pad(indent)}    MapCompass()
${""?left_pad(indent)}    MapScaleView()
${""?left_pad(indent)}    MapUserLocationButton()
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .ignoresSafeArea(edges: .bottom)
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  3D                                     -->
<!----------------------------------------------------------------------------->
<#macro print_3d_layout scene indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TABS                                    -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_layout tabs indent=0>
${""?left_pad(indent)}TabView(selection: $selected${swift.nameType(tabs.id)}) {
  <#list tabs.children as child>
${""?left_pad(indent)}  VStack {
${""?left_pad(indent)}    // 占位区域，可嵌入自定义 Builder
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .tabItem {
${""?left_pad(indent)}    Text("${child.title}")
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .tag(${child?index})
  </#list>
${""?left_pad(indent)}}
<#--  ${""?left_pad(indent)}.onChange(of: activeTabIndex) { index in 
${""?left_pad(indent)}  self.handle${js.nameType(tabs.id)}Change(index: index) 
${""?left_pad(indent)}}  -->
</#macro>

<#macro print_tabs_variables tabs indent=0>
</#macro>

<#macro print_tabs_methods tabs indent=0>
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var selected${swift.nameType(tabs.id)}: Int = 0
</#macro>

<!----------------------------------------------------------------------------->
<!--                               SEGMENTS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_segments_layout segments indent=0>
${""?left_pad(indent)}HStack(spacing: 2) {
  <#list segments.children as child>
${""?left_pad(indent)}  Button(action: {
${""?left_pad(indent)}    withAnimation(.spring(response: 0.28, dampingFraction: 0.78)) {
${""?left_pad(indent)}      self.selected${js.nameType(segments.id)} = "${child.id?upper_case}"
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }) {
${""?left_pad(indent)}    Text("${child.title}")
${""?left_pad(indent)}      .font(.system(size: 13, weight: self.selected${js.nameType(segments.id)} == "${child.id?upper_case}" ? .semibold : .regular))
${""?left_pad(indent)}      .foregroundColor(self.selected${js.nameType(segments.id)} == "${child.id?upper_case}" ? Color.primary : Color.textSecondary)
${""?left_pad(indent)}      .frame(maxWidth: .infinity)
${""?left_pad(indent)}      .frame(height: 30)
${""?left_pad(indent)}      .background(
${""?left_pad(indent)}        RoundedRectangle(cornerRadius: 8)
${""?left_pad(indent)}          .fill(self.selected${js.nameType(segments.id)} == "${child.id?upper_case}" ? Color.surface : Color.clear)
${""?left_pad(indent)}          .shadow(color: Color.black.opacity(self.selected${js.nameType(segments.id)} == "${child.id?upper_case}" ? 0.06 : 0), radius: 2, x: 0, y: 1)
${""?left_pad(indent)}      )
${""?left_pad(indent)}  }
  </#list>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(3)
${""?left_pad(indent)}.background(Color.divider)
${""?left_pad(indent)}.cornerRadius(11)
${""?left_pad(indent)}.frame(maxWidth: .infinity)
</#macro>

<#macro print_segments_variables segments indent=0>
${""?left_pad(indent)}@State
${""?left_pad(indent)}private var selected${swift.nameType(segments.id)}: String = "${segments.children[0].id?upper_case}"
</#macro>

<#macro print_segments_methods segments indent=0>
  <#list segments.children as child>
${""?left_pad(indent)}
${""?left_pad(indent)}func handle${ts.nameType(child.id)}Click() async {
${""?left_pad(indent)}  self.selected${ts.nameType(segments.id)} = "${child.id?upper_case}"
${""?left_pad(indent)}}
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TILE                                    -->
<!----------------------------------------------------------------------------->
<#macro print_tile_layout tile indent=0>
${""?left_pad(indent)}HStack(spacing: 0) {
${""?left_pad(indent)}  if let imageUrl = self.${js.nameVariable(tile.id)}.image {
${""?left_pad(indent)}    AsyncImage(url: URL(string: imageUrl)) { image in
${""?left_pad(indent)}      image.resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    } placeholder: {
${""?left_pad(indent)}      Color.divider
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(width: 60, height: 60)
${""?left_pad(indent)}    .cornerRadius(4)
${""?left_pad(indent)}    .padding(.right, 12)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
${""?left_pad(indent)}    Text(self.${js.nameVariable(tile.id)}.title)
${""?left_pad(indent)}      .font(.system(size: 16, weight: .bold))
${""?left_pad(indent)}      .foregroundColor(Color.textPrimary)
${""?left_pad(indent)}    if let desc = self.${js.nameVariable(tile.id)}.desc {
${""?left_pad(indent)}      Text(desc)
${""?left_pad(indent)}        .font(.system(size: 12))
${""?left_pad(indent)}        .foregroundColor(Color.textSecondary)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Spacer()
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color.surface)
${""?left_pad(indent)}.cornerRadius(8)
${""?left_pad(indent)}.contentShape(Rectangle())
${""?left_pad(indent)}.onTapGesture { 
${""?left_pad(indent)}  self.handle${js.nameType(tile.id)}Click() 
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTON                                  -->
<!----------------------------------------------------------------------------->
<#macro print_button_layout button indent=0>
${""?left_pad(indent)}Button(action: {
${""?left_pad(indent)}  self.handle${js.nameType(button.id)}Tap()
${""?left_pad(indent)}}) {
${""?left_pad(indent)}  Text("${button.title}")
${""?left_pad(indent)}    .font(.system(size: 16))
${""?left_pad(indent)}    .foregroundColor(Color.surface)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .frame(height: 44)
${""?left_pad(indent)}    .background(Color.primary)
${""?left_pad(indent)}    .cornerRadius(8)
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_input_layout input indent=0>
  <#if input.type == "hidden"><#return></#if>
  <#if input.value("readonly") == "true">
<@print_readonly_layout readonly=input indent=indent />
    <#return>
  </#if>
  <#if input.type == "date">
${""?left_pad(indent)}DateRow(
${""?left_pad(indent)}  label: "${input.title}", 
${""?left_pad(indent)}  value: .constant(self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)}),
${""?left_pad(indent)}  onSelect: { v in 
${""?left_pad(indent)}    var temp = self.${ts.nameVariable(input.container.id)}Data
${""?left_pad(indent)}    temp?.${ts.nameVariable(input.id)} = v
${""?left_pad(indent)}    self.${ts.nameVariable(input.container.id)}Data = temp
${""?left_pad(indent)}  } 
${""?left_pad(indent)})
  <#elseif input.type == "select">
${""?left_pad(indent)}DropdownRow(
${""?left_pad(indent)}  label: "${input.title}", 
${""?left_pad(indent)}  value: .constant(String(describing: self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)}?.description ?? "")),
${""?left_pad(indent)}  options: self.${ts.nameVariable(input.id)}Options,
    <#if input.value("data")?starts_with("enum[") || input.value("data") == "">
${""?left_pad(indent)}  onSelect: { v in self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)} = v } 
    <#else>
${""?left_pad(indent)}  onSelect: { v in self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)} = Int(v) ?? 0 }           
    </#if>
${""?left_pad(indent)})
  <#elseif input.type == "multiselect">
${""?left_pad(indent)}MultiSelectRow(
${""?left_pad(indent)}  label: "${input.title}", 
${""?left_pad(indent)}  value: .constant(String(describing: self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)} ?? "")),
${""?left_pad(indent)}  options: self.${ts.nameVariable(input.id)}Options,
${""?left_pad(indent)}  onSelect: { v in self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)} = v }         
${""?left_pad(indent)})
  <#elseif input.type == "number">
${""?left_pad(indent)}InputRow(
${""?left_pad(indent)}  label: "${input.title}", 
${""?left_pad(indent)}  value: .constant(self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)}?.description ?? ""),
${""?left_pad(indent)}  onChange: { v in 
${""?left_pad(indent)}    if var temp = self.${ts.nameVariable(input.container.id)}Data {
${""?left_pad(indent)}      temp.${ts.nameVariable(input.id)} = Double(v) ?? 0.0
${""?left_pad(indent)}      self.${ts.nameVariable(input.container.id)}Data = temp
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)})
  <#elseif input.type == "text">
${""?left_pad(indent)}InputRow(
${""?left_pad(indent)}  label: "${input.title}", 
${""?left_pad(indent)}  value: .constant(String(describing: self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)} ?? "")),
${""?left_pad(indent)}  onChange: { v in self.${ts.nameVariable(input.container.id)}Data?.${ts.nameVariable(input.id)} = v }
${""?left_pad(indent)})
  </#if>   
</#macro>

<#macro print_input_variables input indent=0>
</#macro>

<#macro print_readonly_layout readonly indent=0>
  <#if readonly.type == "hidden"><#return></#if>
${""?left_pad(indent)}ReadonlyRow(
${""?left_pad(indent)}  label: "${readonly.title}", 
  <#if readonly.type == "datetime">
${""?left_pad(indent)}  value: FormatUtils.Date.toYMDHMS(self.${ts.nameVariable(readonly.container.id)}Data?.${ts.nameVariable(readonly.id)})     
  <#elseif readonly.type == "date">
${""?left_pad(indent)}  value: FormatUtils.Date.toYMD(self.${ts.nameVariable(readonly.container.id)}Data?.${ts.nameVariable(readonly.id)})     
  <#elseif readonly.type == "time">
${""?left_pad(indent)}  value: FormatUtils.Date.toHM(self.${ts.nameVariable(readonly.container.id)}Data?.${ts.nameVariable(readonly.id)})   
  <#elseif readonly.type == "number">
${""?left_pad(indent)}  value: FormatUtils.Number.toDecimal(self.${ts.nameVariable(readonly.container.id)}Data?.${ts.nameVariable(readonly.id)}) 
  <#else>
${""?left_pad(indent)}  value: String(describing: self.${ts.nameVariable(readonly.container.id)}Data?.${ts.nameVariable(readonly.id)}?.description ?? "")
  </#if>
${""?left_pad(indent)})  
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 WIDGET                                  -->
<!----------------------------------------------------------------------------->
<#macro print_widget_layout widget indent=0>
  <#if widget.type == "scroll_navigator">
<@print_scroll_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "slide_navigator">
<@print_slide_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "button_navigator">
<@print_button_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "list_navigator">
<@print_list_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_list_view_layout list=widget indent=indent />
  <#elseif widget.type == "grid_view">
<@print_grid_view_layout grid=widget indent=indent />
  <#elseif widget.type == "entry_form">
<@print_entry_form_layout form=widget indent=indent />
  <#elseif widget.type == "criteria_form">
<@print_criteria_form_layout form=widget indent=indent />
  <#elseif widget.type == "display_form">
<@print_display_form_layout form=widget indent=indent />
  <#elseif widget.type == "tabs">
<@print_tabs_layout tabs=widget indent=indent />
  <#elseif widget.type == "segments">
<@print_segments_layout segments=widget indent=indent />
  <#elseif widget.type == "tile">
<@print_tile_layout tile=widget indent=indent />
  <#elseif widget.type == "button">
<@print_button_layout button=widget indent=indent />
  <#elseif widget.type == "input">
<@print_input_layout input=widget indent=indent />
  </#if>
</#macro>

<#macro print_widget_variables widget indent=0>
  <#if widget.type == "scroll_navigator">
<@print_scroll_navigator_variables navigator=widget indent=indent />
  <#elseif widget.type == "slide_navigator">
<@print_slide_navigator_variables navigator=widget indent=indent />
  <#elseif widget.type == "button_navigator">
<@print_button_navigator_variables navigator=widget indent=indent />
  <#elseif widget.type == "list_navigator">
<@print_list_navigator_variables navigator=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_list_view_variables list=widget indent=indent />
  <#elseif widget.type == "grid_view">
<@print_grid_view_variables grid=widget indent=indent />  
  <#elseif widget.type == "entry_form">
<@print_entry_form_variables form=widget indent=indent />  
  <#elseif widget.type == "criteria_form">
<@print_criteria_form_variables form=widget indent=indent />  
  <#elseif widget.type == "display_form">
<@print_display_form_variables form=widget indent=indent />  
  <#elseif widget.type == "tabs">
<@print_tabs_variables tabs=widget indent=indent />
  <#elseif widget.type == "segments">
<@print_segments_variables segments=widget indent=indent />
  <#elseif widget.type == "button">
<@print_button_variables button=widget indent=indent />
  <#elseif widget.type == "input">
<@print_input_variables input=widget indent=indent />
  </#if>
</#macro>

<#macro print_widget_methods widget indent=0>
  <#if widget.type == "scroll_navigator">
<@print_scroll_navigator_methods navigator=widget indent=indent />
  <#elseif widget.type == "slide_navigator">
<@print_slide_navigator_methods navigator=widget indent=indent />
  <#elseif widget.type == "button_navigator">
<@print_button_navigator_methods navigator=widget indent=indent />
  <#elseif widget.type == "list_navigator">
<@print_list_navigator_methods navigator=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_list_view_methods list=widget indent=indent />
  <#elseif widget.type == "grid_view">
<@print_grid_view_methods grid=widget indent=indent />  
  <#elseif widget.type == "entry_form">
<@print_entry_form_methods form=widget indent=indent />  
  <#elseif widget.type == "criteria_form">
<@print_criteria_form_methods form=widget indent=indent />  
  <#elseif widget.type == "display_form">
<@print_display_form_methods form=widget indent=indent />  
  <#elseif widget.type == "tabs">
<@print_tabs_methods tabs=widget indent=indent />
  <#elseif widget.type == "segments">
<@print_segments_methods segments=widget indent=indent />
  <#elseif widget.type == "tile">
<@print_tile_methods tile=widget indent=indent />
  <#elseif widget.type == "button">
<@print_button_methods button=widget indent=indent />
  <#elseif widget.type == "input">
<@print_input_methods input=widget indent=indent />
  </#if>
</#macro>
<!----------------------------------------------------------------------------->
<!--                                  PAGE                                   -->
<!----------------------------------------------------------------------------->
<#macro print_page_layout page indent=0>
  <#list page.children as child>
<@print_widget_layout widget=child indent=indent />   
  </#list>
</#macro>

<#macro print_page_variables page indent=0>
  <#list page.children as child>
<@print_widget_variables widget=child indent=indent />   
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.children as child>
<@print_widget_methods widget=child indent=indent />   
  </#list>
</#macro>