/**
 * Global SDK configuration — singleton.
 *
 * Set these once during app startup (e.g. in {@code onCreate} or
 * {@code onWindowStageCreate}) and every subsequent API call picks them up.
 *
 * Example:
 *   ApiConfig.baseUrl = 'https://api.example.com'
 *   ApiConfig.timeout = 15000
 *   ApiConfig.defaultHeaders['Authorization'] = 'Bearer <token>'
 */
export class HttpConfig {
  /** Root URL for all API requests. Must include protocol (https://). */
  static baseUrl: string = ''

  /** Default connect + read timeout in milliseconds. */
  static timeout: number = 10000

  /** Headers sent with every request unless overridden. */
  static defaultHeaders: Record<string, string> = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  }

  /**
   * Callback invoked on every non-0 business-code response so the app can
   * show a unified error toast / redirect to login, etc.
   */
  static onBusinessError?: (code: number, message: string) => void
}
