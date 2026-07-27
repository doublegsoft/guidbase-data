import http from '@ohos.net.http'
import { HttpConfig } from './HttpConfig'
import { HttpResponse } from './HttpResponse'
import { HttpRequestOptions } from './HttpRequest'

/**
 * Core HTTP client that wraps {@link @ohos.net.http}.
 *
 * Handles:
 *  - URL assembly (baseUrl + path + query params)
 *  - Default header injection
 *  - JSON serialisation / deserialisation
 *  - Uniform error wrapping
 *
 * Usage:
 *   const res = await HttpClient.request<Demo[]>({ path: '/api/demos' })
 */
export class HttpClient {
  /**
   * Execute an HTTP request and return the typed response body.
   *
   * @throws An {@link Error} if the network call itself fails (no internet, timeout, etc.).
   *         Business errors (code != 0) are returned normally — check {@code res.code}.
   */
  static async request<T>(opts: HttpRequestOptions): Promise<HttpResponse<T>> {
    const client = http.createHttp()
    try {
      const url = HttpClient.buildUrl(opts)
      const method = opts.method ?? http.RequestMethod.GET

      const mergedHeaders: Record<string, string> = HttpConfig.defaultHeaders
      if (opts.headers) {
        const keys = Object.keys(opts.headers)
        for (let i = 0; i < keys.length; i++) {
          mergedHeaders[keys[i]] = opts.headers[keys[i]]
        }
      }

      let extraData: string | undefined = undefined
      if (opts.body != null) {
        extraData = typeof opts.body === 'string' ? opts.body as string : JSON.stringify(opts.body)
      }

      const rawResponse = await client.request(url, {
        method: method,
        header: mergedHeaders,
        extraData: extraData,
        connectTimeout: opts.connectTimeout ?? HttpConfig.timeout,
        readTimeout: opts.readTimeout ?? HttpConfig.timeout
      })

      const body = HttpClient.parseBody<T>(rawResponse)

      // Fire global business-error hook if configured
      if (body.code !== 0 && HttpConfig.onBusinessError) {
        HttpConfig.onBusinessError(body.code, body.message)
      }

      return body
    } finally {
      client.destroy()
    }
  }

  // ── private helpers ────────────────────────────────────

  /** Assemble the full URL from options. */
  private static buildUrl(opts: HttpRequestOptions): string {
    const base = opts.baseUrl ?? HttpConfig.baseUrl
    let url = `${base}${opts.path}`

    if (opts.params) {
      const entries = Object.entries(opts.params)
      let qs = ''
      for (let i = 0; i < entries.length; i++) {
        const entry = entries[i]
        if (i > 0) qs += '&'
        qs += encodeURIComponent(entry[0]) + '=' + encodeURIComponent(String(entry[1]))
      }
      if (qs) url += '?' + qs
    }
    return url
  }

  /** Parse the raw HTTP result into the typed {@link ApiResponse}. */
  private static parseBody<T>(raw: http.HttpResponse): HttpResponse<T> {
    const text = raw.result != null ? String(raw.result) : '{}'

    // The response is JSON — try to parse it
    const json: Record<string, Object> = JSON.parse(text) as Record<string, Object>

    const code: number = (json['code'] as number) ?? -1
    const message: string = (json['message'] as string) ?? ''
    const data: T = json['data'] as T
    return { code: code, message: message, data: data }
  }
}
