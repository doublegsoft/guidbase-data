package ${namespace}.${java.nameNamespace(app.name)}.sdk.repository

import java.io.IOException
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody

import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*
import ${namespace}.${java.nameNamespace(app.name)}.model.*
import ${namespace}.${java.nameNamespace(app.name)}.util.*

class RemoteRepository : Repository {

  private val BASE_URL = "https://placeholder.api.com/"

  private val okHttpClient = OkHttpClient()

  private val gson = Gson()
<#assign visited_objects = {}>
<#list app.pages as page>  
  <#list page.containers as container>
    <#if container.value("data") == ""><#continue></#if>
    <#assign url = valuebase.url(container.value("data"))>
    <#if visited_objects[url.resource]??><#continue></#if>
    <#assign visited_objects += { (url.resource): url }>

  /**
   * 获取【${url.resource?upper_case}】唯一数据。
   */  
  override suspend fun fetch${java.nameType(url.resource)}(params: ${java.nameType(url.resource)}Query?): ${java.nameType(url.resource)}? {
    return withContext(Dispatchers.IO) {
      val payload = params.toMap().toMutableMap()
      payload["start"] = 0
      payload["limit"] = 1
      postAndParseOne("/${url.resource}/find", payload, ${java.nameType(url.resource)}::class.java)
    }
  }

  /**
   * 获取【${url.resource?upper_case}】集合数据。
   */  
  override suspend fun fetch${java.nameType(inflector.pluralize(url.resource))}(params: ${java.nameType(url.resource)}Query?, start: Int, limit: Int): Pagination<${java.nameType(url.resource)}> {
    return withContext(Dispatchers.IO) {
      val payload = params.toMap().toMutableMap()
      payload["start"] = start
      payload["limit"] = limit
      postAndParseMore("/${url.resource}/find", payload, ${java.nameType(url.resource)}::class.java)
    }
  }
  </#list>
</#list>
<#list app.pages as page>
  <#list page.inputs as input>
    <#if input.value("data") == "" || input.value("data")?starts_with("enum[")><#continue></#if>
    <#assign url = valuebase.url(input.value("data"))>
    <#assign valueField = page.value("value", "value")>
    <#assign labelField = page.value("label", "label")>
  
  /**
   * 获取【${input.title}】选项数据。
   */
  override suspend fun fetch${java.nameType(url.resource)}AsOptions(): List<Option> {
    return withContext(Dispatchers.IO) {
      val payload = mapOf(
        "start" to 0,
        "limit" to -1
      )
      val page = postAndParseMore("/${url.resource}/find", payload, ${java.nameType(url.resource)}::class.java)
      page.data.map { model ->
        Option(
          value = model.${java.nameVariable(valueField)}?.toString() ?: "",
          label = model.${java.nameVariable(labelField)} ?: ""
        )
      }
    }
  }
  </#list>
</#list>

  private suspend fun <T> postAndParseMore(
    path: String,
    payload: Map<String, Any?>,
    modelClass: Class<T>
  ): Pagination<T> {
    return withContext(Dispatchers.IO) {
      val jsonString = gson.toJson(payload)
      val mediaType = "application/json; charset=utf-8".toMediaType()
      val requestBody = jsonString.toRequestBody(mediaType)
      val request = Request.Builder()
        .url(BASE_URL + path)
        .post(requestBody)
        .build()
      okHttpClient.newCall(request).execute().use { response ->
        if (!response.isSuccessful) {
          throw IOException("Unexpected HTTP code: ${r"${"}response.code}")
        }

        val bodyString = response.body?.string() ?: throw IOException("Response body is empty")
        val mapType = object : TypeToken<Map<String, Any?>>() {}.type
        val responseMap: Map<String, Any?> = gson.fromJson(bodyString, mapType)
        
        val total = (responseMap["total"] as? Double)?.toInt() ?: 0
        val rawList = responseMap["data"] as? List<Any?> ?: emptyList<Any?>()
        
        val parsedList = rawList.map { item ->
          val itemJson = gson.toJson(item)
          gson.fromJson(itemJson, modelClass)
        }
        Pagination(parsedList, total)
      }
    }
  }

  private suspend fun <T> postAndParseOne(
    path: String,
    payload: Map<String, Any?>,
    modelClass: Class<T>
  ): T {
    return withContext(Dispatchers.IO) {
      val jsonString = gson.toJson(payload)
      val mediaType = "application/json; charset=utf-8".toMediaType()
      val requestBody = jsonString.toRequestBody(mediaType)
      val request = Request.Builder()
        .url(BASE_URL + path)
        .post(requestBody)
        .build()

      okHttpClient.newCall(request).execute().use { response ->
        if (!response.isSuccessful) {
          throw IOException("Unexpected HTTP code: ${r"${"}response.code}")
        }

        val bodyString = response.body?.string() ?: throw IOException("Response body is empty")
        val mapType = object : TypeToken<Map<String, Any?>>() {}.type
        val responseMap: Map<String, Any?> = gson.fromJson(bodyString, mapType)
        
        // 提取单对象数据并转换为对应的类
        val rawData = responseMap["data"] ?: throw IOException("Data field is missing")
        val itemJson = gson.toJson(rawData)
        gson.fromJson(itemJson, modelClass)
      }
    }
  }
}