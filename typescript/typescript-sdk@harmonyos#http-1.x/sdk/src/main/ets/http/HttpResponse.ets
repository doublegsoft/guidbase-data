/**
 * Generic API response wrapper.
 *
 * Usage:
 *   const res: ApiResponse<Demo> = await DemoService.getById(1)
 *   if (res.code === 0) { console.log(res.data.text1) }
 */
export interface HttpResponse<T> {

  /** Business status code. 0 = success, non-zero = error. */
  code: number

  /** Human-readable message from server. */
  message: string
  
  /** Payload returned by the server. */
  data: T
}
