<#if license??>
${java.license(license)}
</#if>
package ${namespace}.${java.nameNamespace(app.name)}.activity

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import ${namespace}.${java.nameNamespace(app.name)}.sdk.repository.*
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.*
import ${namespace}.${java.nameNamespace(app.name)}.ui.screens.${java.nameType(page.name)}Screen
import ${namespace}.${java.nameNamespace(app.name)}.viewmodel.*

class ${java.nameType(page.name)}Activity : ComponentActivity() {

  private val viewModel: ${java.nameType(page.name)}ViewModel by lazy {
    val repository = MemoryRepository()
    val factory = object : ViewModelProvider.Factory {
      override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return ${java.nameType(page.name)}ViewModel(repository) as T
      }
    }
    ViewModelProvider(this, factory)[${java.nameType(page.name)}ViewModel::class.java]
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    val demoId = intent.getStringExtra("demo_id")
    setContent {
      Theme {
        ${java.nameType(page.name)}Screen(
          viewModel = viewModel,
          demoId = demoId,
          onBack = { finish() }
        )
      }
    }
  }

}
