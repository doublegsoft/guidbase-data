import SwiftUI
import PhotosUI
import AVFoundation

/**
 * 将任意值格式化为安全显示的字符串，过滤 null/undefined/NaN。
 */
func fmtVal(_ v: Any?) -> String {
  guard let v = v else { return "" }
  let str = String(describing: v)
  if str == "null" || str == "nil" || str == "NaN" { return "" }
  if let d = v as? Double, d.isNaN { return "" }
  if let f = v as? Float, f.isNaN { return "" }
  return str
}

// 模拟外部引入的主题结构
struct Theme {
  static let TOPBAR_HEIGHT: CGFloat = 56
  static let FONT_FAMILY: String = ""
  static let radius_sm: CGFloat = 4
}

/**
 * 1. Navbar Component (导航栏：支持首页模式 / 子页返回模式)
 *
 * 首页模式（navTitle 为空，默认）：
 *   左侧=logo，右侧=操作入口
 *
 * 子页模式（设置 navTitle）：
 *   左侧=返回按钮 + 页面标题，右侧=操作入口
 */
struct Navbar<RightSlot: View>: View {
  var logoText: String = "entry_form"
  var logoEmText: String = "【主系统】"
  
  var navTitle: String = ""
  var showBack: Bool = false
  
  var customRightSlot: (() -> RightSlot)? = nil
  var onBack: (() -> Void)? = nil

  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        if !navTitle.isEmpty {
          // ======== 子页导航模式 ========
          if showBack {
            Button(action: {
              onBack?()
            }) {
              Text("←")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.trailing, 12)
            }
          }
          AdaptiveText(
            value: navTitle,
            fontSize: 17,
            fontColor: .white,
            fontWeight: .bold,
            fontFamily: Theme.FONT_FAMILY
          )
        } else {
          // ======== 首页模式 ========
          HStack(spacing: 0) {
            AdaptiveText(
              value: logoText,
              fontSize: 15,
              fontColor: .white,
              fontWeight: .bold,
              fontFamily: Theme.FONT_FAMILY
            )
            AdaptiveText(
              value: logoEmText,
              fontSize: 15,
              fontColor: Color.secondary,
              fontWeight: .bold,
              fontFamily: Theme.FONT_FAMILY
            )
          }
          .padding(.trailing, 16)
          .overlay(
            Rectangle()
              .frame(width: 1)
              .foregroundColor(Color.white.opacity(0.2)),
            alignment: .trailing
          )
        }

        Spacer()

        // Right slot
        if let customRightSlot = customRightSlot {
          customRightSlot()
        } else if navTitle.isEmpty {
          // 仅首页模式显示默认操作入口
          HStack(spacing: 14) {
            AdaptiveText(
              value: "管理员",
              fontSize: 12,
              fontColor: .white
            )
            AdaptiveText(
              value: "安全退出",
              fontSize: 12,
              fontColor: Color.secondary
            )
          }
        }
      }
      .frame(height: Theme.TOPBAR_HEIGHT)
      .padding(.horizontal, 20)
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 44) // 状态栏区域保护
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color.headerGradientStart,
          Color.headerGradientStart,
          Color.headerGradientEnd,
          Color.headerGradientStart
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
    )
    .overlay(
      Rectangle()
        .frame(height: 3)
        .foregroundColor(Color.secondary),
      alignment: .bottom
    )
    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 3)
  }
}

/**
 * 2. Tag / Badge (高饱和度标签)
 */
struct Tag: View {
  var text: String = "标签"
  var variant: String = "neutral" // success | danger | warning | primary | neutral

  private var bg: Color {
    switch variant {
    case "success": return Color.statusAvailable.opacity(0.08)
    case "danger": return Color.accentRed.opacity(0.08)
    case "warning": return Color.accentOrange.opacity(0.08)
    case "primary": return Color.primary.opacity(0.08)
    default: return Color.background
    }
  }

  private var textColor: Color {
    switch variant {
    case "success": return Color.statusAvailable
    case "danger": return Color.accentRed
    case "warning": return Color.accentOrange
    case "primary": return Color.primary
    default: return Color.textMuted
    }
  }

  private var border: Color {
    switch variant {
    case "success": return Color.statusAvailable.opacity(0.2)
    case "danger": return Color.accentRed.opacity(0.2)
    case "warning": return Color.accentOrange.opacity(0.2)
    case "primary": return Color.primary.opacity(0.2)
    default: return Color.divider
    }
  }

  var body: some View {
    Text(text)
      .font(.system(size: 10, weight: .bold))
      .foregroundColor(textColor)
      .padding(.horizontal, 6)
      .padding(.vertical, 2)
      .background(bg)
      .cornerRadius(Theme.radius_sm)
      .overlay(
        RoundedRectangle(cornerRadius: Theme.radius_sm)
          .stroke(border, lineWidth: 1)
      )
  }
}

/**
 * AdaptiveText - 自适应单行文本
 */
struct AdaptiveText: View {
  var value: Any?
  var fontSize: CGFloat = 16
  var fontColor: Color = Color.textPrimary
  var fontWeight: Font.Weight = .regular
  var fontFamily: String = ""
  var textAlign: TextAlignment = .leading

  var body: some View {
    Text(fmtVal(value))
      .font(fontFamily.isEmpty ? .system(size: fontSize, weight: fontWeight) : .custom(fontFamily, size: fontSize).weight(fontWeight))
      .foregroundColor(fontColor)
      .multilineTextAlignment(textAlign)
      .lineLimit(1)
      .truncationMode(.tail)
  }
}

struct FormRow: Identifiable, Hashable {
  let id = UUID()
  var label: String
  var value: String
  var isTag: Bool? = false
}

/**
 * FormSection - 表单数据段落
 */
struct FormSection: View {
  var title: String = ""
  var rows: [FormRow] = []

  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 8) {
        RoundedRectangle(cornerRadius: Theme.radius_sm)
          .fill(Color.primary)
          .frame(width: 4, height: 14)
        Text(title)
          .font(.system(size: 13, weight: .bold))
          .foregroundColor(Color.primary)
        Spacer()
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 8)
      .background(Color.primary.opacity(0.06))
      .overlay(
        Rectangle().frame(height: 1).foregroundColor(Color.primary.opacity(0.2)),
        alignment: .bottom
      )

      // 表单项
      VStack(spacing: 0) {
        ForEach(rows) { row in
          HStack(spacing: 0) {
            // Label
            Text(row.label)
              .font(.system(size: 13, weight: .bold))
              .foregroundColor(Color.textSecondary)
              .frame(width: 72, alignment: .leading)

            // Value
            if row.isTag ?? false {
              Tag(text: row.value, variant: "primary")
            } else {
              AdaptiveText(
                value: row.value,
                fontSize: 14,
                fontColor: Color.textPrimary,
                fontWeight: .bold
              )
            }
            Spacer()
          }
          .padding(.horizontal, 12)
          .padding(.vertical, 10)
          .background(Color.surface)
          .overlay(
            Rectangle().frame(height: 1).foregroundColor(Color.divider),
            alignment: .bottom
          )
        }
      }
    }
    .frame(maxWidth: .infinity)
    .background(Color.surface)
    .cornerRadius(Theme.radius_sm)
    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    .overlay(
      RoundedRectangle(cornerRadius: Theme.radius_sm)
        .stroke(Color.divider, lineWidth: 1)
    )
    .padding(.top, 12)
  }
}

/**
 * FormSectionTitle - 表单纯段落标题
 */
struct FormSectionTitle: View {
  var title: String = ""

  var body: some View {
    HStack(spacing: 8) {
      RoundedRectangle(cornerRadius: 2)
        .fill(Color.primary)
        .frame(width: 4, height: 14)
      Text(title)
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(Color.primary)
      Spacer()
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * Avatar - 圆形字母缩写头像
 */
struct Avatar: View {
  var text: String? = ""
  var avatarSize: CGFloat = 48

  private var initial: String {
    if let t = text, !t.isEmpty {
      return String(t.prefix(1))
    }
    return "?"
  }

  var body: some View {
    Text(initial)
      .font(.system(size: avatarSize / 2.5, weight: .bold))
      .foregroundColor(.white)
      .frame(width: avatarSize, height: avatarSize)
      .background(
        LinearGradient(
          gradient: Gradient(colors: [
            Color.headerGradientStart,
            Color.primary
          ]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
      .cornerRadius(avatarSize / 2)
  }
}

/**
 * InputRow - 文本输入组件
 */
struct InputRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var keyboardType: UIKeyboardType = .default
  var isMultiline: Bool = false
  var onChange: ((String) -> Void)? = nil

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      TextField("请输入" + label, text: $value,
        prompt: Text("请输入" + label)
        .font(.system(size: 14))
        .foregroundColor(Color.textMuted)
      )
        .font(.system(size: 14))
        .foregroundColor(Color.textPrimary)
        .padding(.leading, 16) 
        .keyboardType(keyboardType)
        .disabled(readonly)
        .onChange(of: value) { newValue in
          onChange?(newValue)
        }
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * DateRow - 日期选择组件（自带 action sheet，使用 presentationDetents 约束高度）
 */
struct DateRow: View {
  var label: String = ""
  @Binding var value: Date?
  var readonly: Bool = false
  var onSelect: ((Date) -> Void)? = nil

  @State private var showPicker = false
  @State private var selectedDate = Date()

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)

      Text(value == nil ? "请选择" + label : DateUtils.yyyymmdd.string(from: value!))
        .font(.system(size: 14))
        .foregroundColor(value == nil ? Color.textMuted : Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 17)

      Text("📅")
        .font(.system(size: 16))
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .contentShape(Rectangle())
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .onTapGesture {
      if !readonly {
        if let v = value { selectedDate = v }
        showPicker = true
      }
    }
    .sheet(isPresented: $showPicker) {
      VStack(spacing: 0) {
        DatePicker("选择\(label)", selection: $selectedDate, displayedComponents: .date)
          .datePickerStyle(.graphical)
          .padding(.horizontal, 16)
        HStack(spacing: 12) {
          Button(action: { showPicker = false }) {
            Text("取消")
              .font(.system(size: 14))
              .foregroundColor(Color.textSecondary)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 10)
              .background(Color.primary.opacity(0.06))
              .cornerRadius(8)
          }
          Button(action: {
            onSelect?(selectedDate)
            showPicker = false
          }) {
            Text("确定")
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(.white)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 10)
              .background(Color.primary)
              .cornerRadius(8)
          }
        }
        .padding(16)
      }
      .presentationDetents([.height(480)])
      .presentationDragIndicator(.hidden)
    }
  }
}

/**
 * DropdownRow - 单选下拉框（采用系统原生 Menu）
 */
struct DropdownRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var options: [Option] = []
  var onSelect: ((String) -> Void)? = nil

  private var currentLabel: String {
    if value.isEmpty || value == "null" { return "" }
    return options.first(where: { $0.value == value })?.label ?? value
  }

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      if readonly {
        Text(currentLabel.isEmpty ? "请选择" + label : currentLabel)
          .font(.system(size: 14))
          .foregroundColor(value.isEmpty || value == "null" ? Color.textMuted : Color.textPrimary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 17)
      } else {
        Menu {
          ForEach(options, id: \.self) { opt in
            Button(opt.label) {
              value = opt.value
              onSelect?(opt.value)
            }
          }
        } label: {
          Text(currentLabel.isEmpty ? "请选择" + label : currentLabel)
            .font(.system(size: 14))
            .foregroundColor(value.isEmpty || value == "null" ? Color.textMuted : Color.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 17)
        }
      }
      
      Text("▼")
        .font(.system(size: 12))
        .foregroundColor(Color.textSecondary)
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * TimeRow - 时间选择组件（纯展示行，选中逻辑由外部 BottomPanel 处理）
 */
struct TimeRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var onTap: (() -> Void)? = nil

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)

      Text(value.isEmpty ? "请选择" + label : value)
        .font(.system(size: 14))
        .foregroundColor(value.isEmpty ? Color.textMuted : Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 17)

      Text("🕐")
        .font(.system(size: 16))
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .contentShape(Rectangle())
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .onTapGesture {
      if !readonly { onTap?() }
    }
  }
}

/**
 * CascadeRow - 级联选择器（单级联动下拉映射）
 */
struct CascadeRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var options: [String] = []
  var onSelect: ((String) -> Void)? = nil

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      if readonly {
        Text(value.isEmpty ? "请选择" + label : value)
          .font(.system(size: 14))
          .foregroundColor(value.isEmpty ? Color.textMuted : Color.textPrimary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 17)
      } else {
        Menu {
          ForEach(options, id: \.self) { opt in
            Button(opt) {
              value = opt
              onSelect?(opt)
            }
          }
        } label: {
          Text(value.isEmpty ? "请选择" + label : value)
            .font(.system(size: 14))
            .foregroundColor(value.isEmpty ? Color.textMuted : Color.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 17)
        }
      }
      
      Text("🔗")
        .font(.system(size: 14))
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * MultiSelectDialog - 多选底栏对话框，包含 Checkbox 列表 + 操作栏
 */
struct MultiSelectDialog: View {
  var title: String = "请选择"
  var options: [Option] = []
  var initialSelected: [String] = []
  var onConfirm: ((String) -> Void)? = nil
  var onClose: () -> Void

  @State private var checked: [String] = []

  init(title: String, options: [Option], initialSelected: [String], onConfirm: ((String) -> Void)?, onClose: @escaping () -> Void) {
    self.title = title
    self.options = options
    self.initialSelected = initialSelected
    self.onConfirm = onConfirm
    self.onClose = onClose
    self._checked = State(initialValue: initialSelected)
  }

  private func isChecked(_ val: String) -> Bool {
    checked.contains(val)
  }

  private func toggle(_ val: String) {
    if let idx = checked.firstIndex(of: val) {
      checked.remove(at: idx)
    } else {
      checked.append(val)
    }
  }

  private func selectAll() {
    checked = options.map { $0.value }
  }

  private func deselectAll() {
    checked.removeAll()
  }

  var body: some View {
    VStack(spacing: 0) {
      // ---- 标题栏 ----
      HStack {
        Text(title)
          .font(.system(size: 16, weight: .bold))
          .foregroundColor(Color.textPrimary)
        Spacer()
        Button("确定") {
          onConfirm?(checked.joined(separator: ","))
          onClose()
        }
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(Color.primary)
      }
      .padding(.horizontal, 16)
      .padding(.top, 14)
      .padding(.bottom, 10)
      .overlay(
        Rectangle().frame(height: 1).foregroundColor(Color.divider),
        alignment: .bottom
      )

      // ---- 快捷操作 ----
      HStack(spacing: 12) {
        Button(action: selectAll) {
          Text("全选")
            .font(.system(size: 12))
            .foregroundColor(Color.primary)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .overlay(
              RoundedRectangle(cornerRadius: 4)
                .stroke(Color.primary, lineWidth: 1)
            )
        }
        Button(action: deselectAll) {
          Text("取消全选")
            .font(.system(size: 12))
            .foregroundColor(Color.textSecondary)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .overlay(
              RoundedRectangle(cornerRadius: 4)
                .stroke(Color.divider, lineWidth: 1)
            )
        }
        Spacer()
        Text("已选 \(checked.count)/\(options.count)")
          .font(.system(size: 12))
          .foregroundColor(Color.textSecondary)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)

      // ---- 选项列表 ----
      ScrollView {
        VStack(spacing: 0) {
          ForEach(options, id: \.self) { opt in
            HStack {
              Image(systemName: isChecked(opt.value) ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked(opt.value) ? Color.primary : .gray)
              Text(opt.label)
                .font(.system(size: 14))
                .foregroundColor(Color.textPrimary)
                .padding(.leading, 8)
              Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
            .onTapGesture {
              toggle(opt.value)
            }
            .overlay(
              Rectangle().frame(height: 1).foregroundColor(Color.divider),
              alignment: .bottom
            )
          }
        }
      }
    }
    .background(Color.surface)
    .cornerRadius(16)
  }
}

/**
 * MultiSelectRow - 复杂流多选标签栏组件
 */
struct MultiSelectRow: View {
  var label: String = ""
  @Binding var value: String // 逗号分隔的已选值串
  var readonly: Bool = false
  var options: [Option] = []
  var onSelect: ((String) -> Void)? = nil

  @State private var showDialog = false

  private var selectedItems: [String] {
    if value.isEmpty { return [] }
    return value.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
  }

  private func getLabel(_ val: String) -> String {
    options.first(where: { $0.value == val })?.label ?? val
  }

  private func removeItem(_ item: String) {
    let next = selectedItems.filter { $0 != item }
    let result = next.joined(separator: ",")
    value = result
    onSelect?(result)
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .top, spacing: 16) {
        Text(label)
          .font(.system(size: 13, weight: .bold))
          .foregroundColor(Color.textSecondary)
          .frame(width: 56, alignment: .leading)
          .padding(.top, 4)
        
        if !selectedItems.isEmpty {
          FlowLayout(spacing: 6) {
            ForEach(selectedItems, id: \.self) { item in
              HStack(spacing: 4) {
                Text(getLabel(item))
                  .font(.system(size: 12))
                  .foregroundColor(Color.primary)
                  .lineLimit(1)
                Text("×")
                  .font(.system(size: 14, weight: .bold))
                  .foregroundColor(Color.primary)
                  .onTapGesture {
                    removeItem(item)
                  }
              }
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(Color.primary.opacity(0.08))
              .cornerRadius(4)
              .overlay(
                RoundedRectangle(cornerRadius: 4)
                  .stroke(Color.primary.opacity(0.2), lineWidth: 1)
              )
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        } else {
          Text("请选择" + label)
            .font(.system(size: 14))
            .foregroundColor(Color.textMuted)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 17)
        }
        
        Spacer()
        
        Text("›")
          .font(.system(size: 20, weight: .bold))
          .foregroundColor(Color.textSecondary)
          .padding(.leading, 4)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
    }
    .frame(minHeight: 48)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .onTapGesture {
      if !readonly && !options.isEmpty {
        showDialog = true
      }
    }
    .sheet(isPresented: $showDialog) {
      MultiSelectDialog(
        title: "请选择" + label,
        options: options,
        initialSelected: selectedItems,
        onConfirm: { res in
          value = res
          onSelect?(res)
        },
        onClose: { showDialog = false }
      )
    }
  }
}

/**
 * 标签流自动包裹引擎组件 (FlowLayout)
 */
struct FlowLayout: Layout {
  var spacing: CGFloat

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    var width: CGFloat = 0
    var height: CGFloat = 0
    var currentX: CGFloat = 0
    var currentY: CGFloat = 0
    var maxRowHeight: CGFloat = 0
    let maxW = proposal.width ?? .infinity

    for size in sizes {
      if currentX + size.width > maxW {
        currentX = 0
        currentY += maxRowHeight + spacing
        maxRowHeight = 0
      }
      currentX += size.width + spacing
      maxRowHeight = max(maxRowHeight, size.height)
      width = max(width, currentX)
      height = max(height, currentY + maxRowHeight)
    }
    return CGSize(width: width, height: height)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    var currentX: CGFloat = bounds.minX
    var currentY: CGFloat = bounds.minY
    var maxRowHeight: CGFloat = 0
    let maxW = bounds.width

    for index in subviews.indices {
      let size = sizes[index]
      if currentX + size.width > maxW + bounds.minX {
        currentX = bounds.minX
        currentY += maxRowHeight + spacing
        maxRowHeight = 0
      }
      subviews[index].place(at: CGPoint(x: currentX, y: currentY), proposal: .unspecified)
      currentX += size.width + spacing
      maxRowHeight = max(maxRowHeight, size.height)
    }
  }
}

/**
 * TagInputRow - 标签输入行组件
 */
struct TagInputRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var onChange: ((String) -> Void)? = nil

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      TextField("输入标签(逗号分隔)", text: $value)
        .font(.system(size: 14))
        .foregroundColor(Color.textPrimary)
        .disabled(readonly)
        .onChange(of: value) { newValue in
          onChange?(newValue)
        }
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * TextAreaRow - 长文本段落输入组件
 */
struct TextAreaRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var onChange: ((String) -> Void)? = nil

  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
        .padding(.top, 10)
      
      TextEditor(text: $value)
        .font(.system(size: 14))
        .foregroundColor(Color.textPrimary)
        .frame(minHeight: 52)
        .disabled(readonly)
        .onChange(of: value) { newValue in
          if newValue.count > 500 {
            value = String(newValue.prefix(500))
          }
          onChange?(value)
        }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
    .frame(minHeight: 72)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * ImagePickerRow - 多图片选择组件，支持展示多张缩略图、添加、删除
 */
struct ImagePickerRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var maxCount: Int = 9
  var onSelect: ((String) -> Void)? = nil

  @State private var loadedImages: [UIImage] = []
  @State private var selectedItems: [PhotosPickerItem] = []

  private var imageCount: Int {
    if value.isEmpty { return 0 }
    return value.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }.count
  }

  private func loadImage(from item: PhotosPickerItem) async {
    if let data = try? await item.loadTransferable(type: Data.self),
       let image = UIImage(data: data) {
      await MainActor.run {
        if loadedImages.count < maxCount {
          loadedImages.append(image)
          let nextIndex = loadedImages.count
          let newValue = value.isEmpty ? "image_\(nextIndex)" : value + ",image_\(nextIndex)"
          value = newValue
          onSelect?(newValue)
        }
      }
    }
  }

  private func removeImage(at index: Int) {
    loadedImages.remove(at: index)
    let parts = value.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
    var newParts = parts
    if index < newParts.count {
      newParts.remove(at: index)
    }
    let newValue = newParts.joined(separator: ",")
    value = newValue
    onSelect?(newValue)
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .top, spacing: 16) {
        Text(label)
          .font(.system(size: 13, weight: .bold))
          .foregroundColor(Color.textSecondary)
          .frame(width: 56, alignment: .leading)
          .padding(.top, 4)

        if !loadedImages.isEmpty {
          FlowLayout(spacing: 8) {
            ForEach(Array(loadedImages.enumerated()), id: \.offset) { index, img in
              ZStack(alignment: .topTrailing) {
                Image(uiImage: img)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 64, height: 64)
                  .clipShape(RoundedRectangle(cornerRadius: 6))
                  .overlay(
                    RoundedRectangle(cornerRadius: 6)
                      .stroke(Color.divider, lineWidth: 1)
                  )

                // 删除按钮
                if !readonly {
                  Button(action: { removeImage(at: index) }) {
                    Image(systemName: "xmark.circle.fill")
                      .font(.system(size: 18))
                      .foregroundColor(.white)
                      .background(Color.black.opacity(0.5))
                      .clipShape(Circle())
                  }
                  .offset(x: 6, y: -6)
                }
              }
            }

            // 添加按钮
            if !readonly && loadedImages.count < maxCount {
              PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: maxCount - loadedImages.count,
                matching: .images
              ) {
                ZStack {
                  RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.primary.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                    .frame(width: 64, height: 64)
                  VStack(spacing: 2) {
                    Image(systemName: "plus")
                      .font(.system(size: 18, weight: .medium))
                      .foregroundColor(Color.primary)
                    Text("添加")
                      .font(.system(size: 10))
                      .foregroundColor(Color.primary)
                  }
                }
              }
              .onChange(of: selectedItems) { newItems in
                Task {
                  for item in newItems {
                    await loadImage(from: item)
                  }
                  selectedItems = []
                }
              }
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        } else {
          // 空状态也显示选择方框
          if !readonly {
            PhotosPicker(
              selection: $selectedItems,
              maxSelectionCount: maxCount,
              matching: .images
            ) {
              ZStack {
                RoundedRectangle(cornerRadius: 6)
                  .stroke(Color.primary.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                  .frame(width: 64, height: 64)
                VStack(spacing: 2) {
                  Image(systemName: "plus")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.primary)
                  Text("添加")
                    .font(.system(size: 10))
                    .foregroundColor(Color.primary)
                }
              }
            }
            .onChange(of: selectedItems) { newItems in
              Task {
                for item in newItems {
                  await loadImage(from: item)
                }
                selectedItems = []
              }
            }
          } else {
            Text("暂无" + label)
              .font(.system(size: 14))
              .foregroundColor(Color.textMuted)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 17)
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
    }
    .frame(minHeight: 48)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * VideoPickerRow - 模拟视频选择组件
 */
struct VideoPickerRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var onSelect: ((String) -> Void)? = nil

  private var fileList: [String] {
    if value.isEmpty { return [] }
    return value.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
  }

  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
        .padding(.top, 2)
      
      if !fileList.isEmpty {
        VStack(alignment: .leading, spacing: 4) {
          ForEach(fileList, id: \.self) { file in
            HStack(spacing: 4) {
              Text("🎬").font(.system(size: 10))
              Text(file)
                .font(.system(size: 12))
                .foregroundColor(Color.textPrimary)
                .lineLimit(1)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.accentOrange.opacity(0.08))
            .cornerRadius(Theme.radius_sm)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      } else {
        Text("请选择" + label)
          .font(.system(size: 14))
          .foregroundColor(Color.textMuted)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 17)
      }
      Text("▶️")
        .font(.system(size: 14))
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
    .frame(minHeight: 48)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .onTapGesture {
      if readonly { return }
      onSelect?("示例视频1.mp4")
    }
  }
}

/**
 * FilePickerRow - 模拟文件选择组件
 */
struct FilePickerRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var onSelect: ((String) -> Void)? = nil

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      Text(value.isEmpty ? "请选择" + label : value)
        .font(.system(size: 14))
        .foregroundColor(value.isEmpty ? Color.textMuted : Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 17)
      
      Text("📎")
        .font(.system(size: 16))
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .onTapGesture {
      if readonly { return }
      onSelect?("示例文档1.pdf")
    }
  }
}

/**
 * AvatarPickerRow - 模拟头像选择组件
 */
struct AvatarPickerRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var onSelect: ((String) -> Void)? = nil

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      if !value.isEmpty {
        Avatar(text: value, avatarSize: 36)
      } else {
        Text("❓")
          .font(.system(size: 20))
          .frame(width: 36, height: 36)
          .background(Color.divider)
          .cornerRadius(18)
          .multilineTextAlignment(.center)
      }
      
      Text(value.isEmpty ? "请选择" + label : "点击更换")
        .font(.system(size: 14))
        .foregroundColor(value.isEmpty ? Color.textMuted : Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 12)
      
      Text("📷")
        .font(.system(size: 16))
    }
    .frame(height: 56)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .onTapGesture {
      if readonly { return }
      onSelect?("A")
    }
  }
}

/**
 * ReadonlyRow - 只读属性展示组件
 */
struct ReadonlyRow: View {
  var label: String = ""
  var value: String = ""

  var body: some View {
    HStack(spacing: 16) {
      Text(label)
        .font(.system(size: 13, weight: .bold))
        .foregroundColor(Color.textSecondary)
        .frame(width: 56, alignment: .leading)
      
      Text(fmtVal(value).isEmpty ? "-" : fmtVal(value))
        .font(.system(size: 14))
        .foregroundColor(Color.textPrimary)
        .padding(.leading, 17)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(height: 48)
    .padding(.horizontal, 16)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
  }
}

/**
 * LoadingFooter - 加载状态页脚
 */
struct LoadingFooter: View {
  var isLoading: Bool = false
  var hasData: Bool = true

  var body: some View {
    HStack(spacing: 8) {
      if isLoading {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
        Text("加载中...")
          .font(.system(size: 13))
          .foregroundColor(Color.textSecondary)
      } else {
        Text(hasData ? "上拉加载更多" : "")
          .font(.system(size: 13))
          .foregroundColor(Color.textSecondary)
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 12)
    .background(Color.background)
  }
}

/**
 * AudioRecordRow - 录音录入组件，支持录音、试听、删除
 */
struct AudioRecordRow: View {
  var label: String = ""
  @Binding var value: String
  var readonly: Bool = false
  var maxCount: Int = 5
  var maxDuration: TimeInterval = 60
  var onSelect: ((String) -> Void)? = nil

  @State private var isRecording = false
  @State private var recordingDuration: TimeInterval = 0
  @State private var audioRecorder: AVAudioRecorder?
  @State private var audioPlayer: AVAudioPlayer?
  @State private var playingIndex: Int? = nil
  @State private var recordingTimer: Timer?
  @State private var playTimer: Timer?
  @State private var playProgress: TimeInterval = 0
  @State private var recordedFiles: [(url: URL, duration: TimeInterval)] = []
  @State private var showPermissionAlert = false

  private var recordingCount: Int {
    if value.isEmpty { return 0 }
    return value.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }.count
  }

  private func formatDuration(_ seconds: TimeInterval) -> String {
    let m = Int(seconds) / 60
    let s = Int(seconds) % 60
    return String(format: "%d:%02d", m, s)
  }

  private func requestPermissionAndRecord() {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
      try session.setActive(true)
    } catch {
      return
    }

    AVAudioSession.sharedInstance().requestRecordPermission { granted in
      DispatchQueue.main.async {
        if granted {
          startRecording()
        } else {
          showPermissionAlert = true
        }
      }
    }
  }

  private func startRecording() {
    guard recordedFiles.count < maxCount else { return }

    let fileName = "audio_\(Date().timeIntervalSince1970).m4a"
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

    let settings: [String: Any] = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 44100.0,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]

    do {
      let recorder = try AVAudioRecorder(url: fileURL, settings: settings)
      recorder.record()
      audioRecorder = recorder
      isRecording = true
      recordingDuration = 0

      recordingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
        recordingDuration += 0.1
        if recordingDuration >= maxDuration {
          stopRecording()
        }
      }
    } catch {
      // 录音启动失败
    }
  }

  private func stopRecording() {
    audioRecorder?.stop()
    recordingTimer?.invalidate()
    recordingTimer = nil
    isRecording = false

    if let url = audioRecorder?.url {
      let asset = AVURLAsset(url: url)
      let duration = CMTimeGetSeconds(asset.duration)
      let dur = duration.isNaN || duration.isInfinite ? recordingDuration : max(duration, 0.5)
      recordedFiles.append((url: url, duration: dur))

      let fileName = url.lastPathComponent
      let newValue = value.isEmpty ? fileName : value + ",\(fileName)"
      value = newValue
      onSelect?(newValue)
    }
    audioRecorder = nil
  }

  private func togglePlayback(at index: Int) {
    if playingIndex == index {
      // 暂停当前播放
      audioPlayer?.pause()
      playTimer?.invalidate()
      playTimer = nil
      playingIndex = nil
    } else {
      // 停止之前的播放
      audioPlayer?.stop()
      playTimer?.invalidate()
      playTimer = nil

      let file = recordedFiles[index]
      do {
        let player = try AVAudioPlayer(contentsOf: file.url)
        player.play()
        audioPlayer = player
        playingIndex = index
        playProgress = 0

        playTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
          if let p = audioPlayer, p.isPlaying {
            playProgress = p.currentTime
          } else {
            playTimer?.invalidate()
            playTimer = nil
            playingIndex = nil
            playProgress = 0
          }
        }
      } catch {
        // 播放失败
      }
    }
  }

  private func deleteRecording(at index: Int) {
    // 如果正在播放该条，先停止
    if playingIndex == index {
      audioPlayer?.stop()
      playTimer?.invalidate()
      playTimer = nil
      playingIndex = nil
    }

    let file = recordedFiles[index]
    try? FileManager.default.removeItem(at: file.url)
    recordedFiles.remove(at: index)

    let parts = value.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
    var newParts = parts
    if index < newParts.count {
      newParts.remove(at: index)
    }
    let newValue = newParts.joined(separator: ",")
    value = newValue
    onSelect?(newValue)
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .top, spacing: 16) {
        Text(label)
          .font(.system(size: 13, weight: .bold))
          .foregroundColor(Color.textSecondary)
          .frame(width: 56, alignment: .leading)
          .padding(.top, 4)

        VStack(alignment: .leading, spacing: 8) {
          // ---- 操作栏 ----
          HStack(spacing: 8) {
            if isRecording {
              // 录音中状态
              HStack(spacing: 6) {
                Circle()
                  .fill(Color.accentRed)
                  .frame(width: 8, height: 8)
                  .scaleEffect(isRecording ? 1.2 : 0.8)
                  .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isRecording)

                Text(formatDuration(recordingDuration))
                  .font(.system(size: 13, weight: .medium, design: .monospaced))
                  .foregroundColor(Color.accentRed)
              }
              .padding(.horizontal, 10)
              .padding(.vertical, 6)
              .background(Color.accentRed.opacity(0.08))
              .cornerRadius(6)

              Spacer()

              Button(action: stopRecording) {
                HStack(spacing: 4) {
                  Image(systemName: "stop.fill")
                    .font(.system(size: 12))
                  Text("停止")
                    .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.accentRed)
                .cornerRadius(6)
              }
            } else if !readonly {
              // 未录音状态：录音按钮
              Button(action: requestPermissionAndRecord) {
                HStack(spacing: 4) {
                  Image(systemName: "mic.fill")
                    .font(.system(size: 12))
                  Text("录音")
                    .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(recordedFiles.count >= maxCount ? Color.gray : Color.primary)
                .cornerRadius(6)
              }
              .disabled(recordedFiles.count >= maxCount)

              Spacer()

              Text("\(recordedFiles.count)/\(maxCount)")
                .font(.system(size: 12))
                .foregroundColor(Color.textMuted)
            }
          }

          // ---- 录音列表 ----
          if !recordedFiles.isEmpty {
            VStack(spacing: 4) {
              ForEach(Array(recordedFiles.enumerated()), id: \.offset) { index, file in
                HStack(spacing: 8) {
                  // 播放/暂停按钮
                  Button(action: { togglePlayback(at: index) }) {
                    Image(systemName: playingIndex == index ? "pause.circle.fill" : "play.circle.fill")
                      .font(.system(size: 22))
                      .foregroundColor(playingIndex == index ? Color.accentOrange : Color.primary)
                  }

                  // 波形条
                  VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 2) {
                      ForEach(0..<12, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 1)
                          .fill(playingIndex == index ? Color.accentOrange : Color.primary.opacity(0.4))
                          .frame(width: 2, height: CGFloat.random(in: 4...14))
                      }
                    }
                    .frame(height: 14)

                    // 进度条
                    if playingIndex == index {
                      GeometryReader { geo in
                        let ratio = file.duration > 0 ? CGFloat(playProgress / file.duration) : 0
                        RoundedRectangle(cornerRadius: 2)
                          .fill(Color.accentOrange)
                          .frame(width: geo.size.width * ratio, height: 3)
                      }
                      .frame(height: 3)
                    }
                  }
                  .frame(maxWidth: .infinity)

                  // 时长
                  Text(formatDuration(file.duration))
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(Color.textMuted)

                  // 删除
                  if !readonly {
                    Button(action: { deleteRecording(at: index) }) {
                      Image(systemName: "trash")
                        .font(.system(size: 13))
                        .foregroundColor(Color.textMuted)
                    }
                  }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.primary.opacity(0.04))
                .cornerRadius(8)
              }
            }
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
    }
    .frame(minHeight: 48)
    .overlay(
      Rectangle().frame(height: 1).foregroundColor(Color.divider),
      alignment: .bottom
    )
    .alert("麦克风权限", isPresented: $showPermissionAlert) {
      Button("前往设置") {
        if let url = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(url)
        }
      }
      Button("取消", role: .cancel) {}
    } message: {
      Text("请在系统设置中开启麦克风权限以使用录音功能。")
    }
  }
}

/**
 * BottomPanel - 自定义底部弹出面板，只覆盖底部，不覆盖全屏
 */
struct BottomPanel<Content: View>: View {
  @Binding var isPresented: Bool
  var height: CGFloat = 300
  @ViewBuilder var content: () -> Content

  var body: some View {
    ZStack {
      if isPresented {
        Color.black.opacity(0.3)
          .ignoresSafeArea()
          .onTapGesture { dismiss() }
          .transition(.opacity)

        VStack(spacing: 0) {
          Spacer()
          VStack(spacing: 0) {
            // 顶部把手
            RoundedRectangle(cornerRadius: 3)
              .fill(Color.gray.opacity(0.4))
              .frame(width: 36, height: 5)
              .padding(.top, 10)
              .padding(.bottom, 6)

            content()
              .padding(.bottom, 20)
          }
          .frame(maxWidth: .infinity)
          .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
              .fill(Color.white)
              .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -5)
          )
          .offset(y: isPresented ? 0 : height)
        }
        .ignoresSafeArea(edges: .bottom)
        .transition(.move(edge: .bottom))
      }
    }
    .animation(.easeInOut(duration: 0.25), value: isPresented)
  }

  private func dismiss() {
    withAnimation(.easeInOut(duration: 0.2)) { isPresented = false }
  }
}
