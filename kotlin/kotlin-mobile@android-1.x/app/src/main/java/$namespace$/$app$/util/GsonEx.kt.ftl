package ${namespace}.${java.nameNamespace(app.name)}.util

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

val gson = Gson()

fun <T> T.toMap(): Map<String, Any?> {
  val json = gson.toJson(this)
  val type = object : TypeToken<Map<String, Any?>>() {}.type
  return gson.fromJson(json, type)
}