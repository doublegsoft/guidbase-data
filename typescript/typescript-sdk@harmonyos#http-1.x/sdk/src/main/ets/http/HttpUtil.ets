import http from '@ohos.net.http'
import { HttpClient } from './HttpClient'
import { HttpResponse } from './HttpResponse'
import { HttpRequestOptions } from './HttpRequest'

/**
 * GET request.
 * @param path    URL path, e.g. "/api/demo/list"
 * @param params  Optional query parameters
 */
export function httpGet<T>(path: string, params?: Record<string, string | number | boolean>): Promise<HttpResponse<T>> {
  const opts: HttpRequestOptions = { path, method: http.RequestMethod.GET, params }
  return HttpClient.request<T>(opts)
}

/**
 * POST request.
 * @param path  URL path
 * @param body  Request body (object or string)
 */
export function httpPost<T>(path: string, body?: Object | string): Promise<HttpResponse<T>> {
  const opts: HttpRequestOptions = { path, method: http.RequestMethod.POST, body }
  return HttpClient.request<T>(opts)
}

/**
 * PUT request.
 * @param path  URL path
 * @param body  Request body (object or string)
 */
export function httpPut<T>(path: string, body?: Object | string): Promise<HttpResponse<T>> {
  const opts: HttpRequestOptions = { path, method: http.RequestMethod.PUT, body }
  return HttpClient.request<T>(opts)
}

/**
 * DELETE request.
 * @param path  URL path
 * @param params  Optional query parameters
 */
export function httpDelete<T>(path: string, params?: Record<string, string | number | boolean>): Promise<HttpResponse<T>> {
  const opts: HttpRequestOptions = { path, method: http.RequestMethod.DELETE, params }
  return HttpClient.request<T>(opts)
}
