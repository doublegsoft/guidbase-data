<#if license??>
${java.license(license)}
</#if>
package ${namespace}.${java.nameNamespace(app.name)}.activity

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchTheme
import ${namespace}.${java.nameNamespace(app.name)}.ui.screens.${java.nameType(page.name)}Screen

class ${java.nameType(page.name)}Activity : ComponentActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContent {
      NavyPitchTheme {
        ${java.nameType(page.name)}Screen(onBack = { finish() })
      }
    }
  }
}
