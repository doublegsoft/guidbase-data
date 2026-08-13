import Foundation

// MARK: - 统一格式化工具命名空间
public enum FormatUtils {
  
  // ==========================================
  // MARK: - 1. 日期格式化 (Date to String)
  // ==========================================
  public enum Date {
    
    // 静态 Formatter 实例，保证单例复用性能
    private static let ymdFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
    
    private static let ymdHmsFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
    
    private static let hmFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
    
    private static let iso8601Formatter: ISO8601DateFormatter = {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [.withInternetDateTime]
      return formatter
    }()
    
    private static let relativeFormatter: RelativeDateTimeFormatter = {
      let formatter = RelativeDateTimeFormatter()
      formatter.unitsStyle = .full
      return formatter
    }()
    
    private static let localizedDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      formatter.locale = Locale.current
      return formatter
    }()
    
    // --- 便捷调用函数 ---
    
    /// 返回 "yyyy-MM-dd" (例如: "2026-08-11")，参数为空则返回 ""
    public static func toYMD(_ date: Foundation.Date?) -> String {
      guard let date = date else { return "" }
      return ymdFormatter.string(from: date)
    }
    
    /// 返回 "yyyy-MM-dd HH:mm:ss" (例如: "2026-08-11 14:30:00")，参数为空则返回 ""
    public static func toYMDHMS(_ date: Foundation.Date?) -> String {
      guard let date = date else { return "" }
      return ymdHmsFormatter.string(from: date)
    }
    
    /// 返回 "HH:mm" (例如: "14:30")，参数为空则返回 ""
    public static func toHM(_ date: Foundation.Date?) -> String {
      guard let date = date else { return "" }
      return hmFormatter.string(from: date)
    }
    
    /// 返回 ISO8601 格式字符串 (例如: "2026-08-11T06:30:00Z")，参数为空则返回 ""
    public static func toISO8601(_ date: Foundation.Date?) -> String {
      guard let date = date else { return "" }
      return iso8601Formatter.string(from: date)
    }
    
    /// 返回相对时间 (例如: "2小时前", "昨天")，参数为空则返回 ""
    public static func toRelative(_ date: Foundation.Date?, relativeTo: Foundation.Date = Foundation.Date()) -> String {
      guard let date = date else { return "" }
      return relativeFormatter.localizedString(for: date, relativeTo: relativeTo)
    }
    
    /// 返回系统本地化格式的日期 (例如中文环境下: "2026年8月11日")，参数为空则返回 ""
    public static func toLocalizedDate(_ date: Foundation.Date?) -> String {
      guard let date = date else { return "" }
      return localizedDateFormatter.string(from: date)
    }
  }
  
  // ==========================================
  // MARK: - 2. 数字格式化 (Number to String)
  // ==========================================
  public enum Number {
    
    private static let decimalFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
    }()
    
    private static let currencyFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.locale = Locale.current
      return formatter
    }()
    
    private static let percentFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .percent
      return formatter
    }()
    
    // --- 便捷调用函数 ---
    
    /// 带千分位分隔符的数字，默认保留2位小数 (例如: 12345.6 -> "12,345.60")，参数为空则返回 ""
    public static func toDecimal(_ value: Double?, decimals: Int = 2) -> String {
      guard let value = value else { return "" }
      decimalFormatter.minimumFractionDigits = decimals
      decimalFormatter.maximumFractionDigits = decimals
      return decimalFormatter.string(from: NSNumber(value: value)) ?? String(format: "%.\(decimals)f", value)
    }
    
    /// 本地货币格式，自动匹配系统地区符号 (例如: 99.9 -> "￥99.90")，参数为空则返回 ""
    public static func toCurrency(_ value: Double?) -> String {
      guard let value = value else { return "" }
      return currencyFormatter.string(from: NSNumber(value: value)) ?? String(format: "%.2f", value)
    }
    
    /// 百分比格式，默认保留小数点后 0 到 2 位 (例如: 0.1256 -> "12.56%")，参数为空则返回 ""
    public static func toPercent(_ value: Double?, minDecimals: Int = 0, maxDecimals: Int = 2) -> String {
      guard let value = value else { return "" }
      percentFormatter.minimumFractionDigits = minDecimals
      percentFormatter.maximumFractionDigits = maxDecimals
      return percentFormatter.string(from: NSNumber(value: value)) ?? "\(value * 100)%"
    }
  }
  
  // ==========================================
  // MARK: - 3. 文件大小格式化 (Bytes to String)
  // ==========================================
  public enum File {
    
    private static let byteCountFormatter: ByteCountFormatter = {
      let formatter = ByteCountFormatter()
      formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
      formatter.countStyle = .file
      return formatter
    }()
    
    // --- 便捷调用函数 ---
    
    /// 字节大小转可读字符串 (例如: 153400000 -> "153.4 MB")，参数为空则返回 ""
    public static func toReadableSize(_ bytes: Int64?) -> String {
      guard let bytes = bytes else { return "" }
      return byteCountFormatter.string(fromByteCount: bytes)
    }
  }
  
  // ==========================================
  // MARK: - 4. 时长格式化 (Seconds to String)
  // ==========================================
  public enum Duration {
    
    private static let timeComponentsFormatter: DateComponentsFormatter = {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.hour, .minute, .second]
      formatter.zeroFormattingBehavior = .pad
      return formatter
    }()
    
    // --- 便捷调用函数 ---
    
    /// 将秒数转换为播放时长格式 (例如: 3665 -> "1:01:05")，参数为空则返回 ""
    public static func toHMS(_ seconds: TimeInterval?) -> String {
      guard let seconds = seconds else { return "" }
      return timeComponentsFormatter.string(from: seconds) ?? "00:00"
    }
  }
}