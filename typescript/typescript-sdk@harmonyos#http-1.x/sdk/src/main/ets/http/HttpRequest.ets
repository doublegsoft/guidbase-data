import http from '@ohos.net.http'

/**
 * Options passed through to every {@link ApiClient} request.
 */
export interface HttpRequestOptions {

  /** Override the default base URL for this single request. */
  baseUrl?: string

  /** URL path suffix appended to baseUrl, e.g. "/api/demo/list". */
  path: string

  /** HTTP method. Defaults to "GET". */
  method?: http.RequestMethod

  /** Query parameters appended as `?key=value&...`. */
  params?: Record<string, string | number | boolean>

  /** Request body (JSON-serialised automatically for POST/PUT). */
  body?: Object | string | ArrayBuffer

  /** Extra headers merged on top of the defaults. */
  headers?: Record<string, string>

  /** Per-request connect timeout in ms (overrides global). */
  connectTimeout?: number

  /** Per-request read timeout in ms (overrides global). */
  readTimeout?: number
}
