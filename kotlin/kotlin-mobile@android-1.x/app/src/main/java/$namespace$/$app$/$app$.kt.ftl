<#if license??>
${java.license(license)}
</#if>
package ${namespace}.${java.nameNamespace(app.name)}

import android.app.Application

class ${java.nameType(app.name)} : Application() {

  companion object {
    lateinit var instance: ${java.nameType(app.name)}
      private set
  }

  var userInfo: Any? = null
  var isLoggedIn = false
  val apiBaseUrl = "https://api.example.com"

  override fun onCreate() {
    super.onCreate()
    instance = this
  }
}
