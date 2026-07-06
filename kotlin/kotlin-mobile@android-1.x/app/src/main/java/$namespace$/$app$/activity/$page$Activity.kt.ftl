<#if license??>
${java.license(license)}
</#if>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
<#assign pageParams = guidbase.get_page_params(page)>
package ${namespace}.${java.nameNamespace(app.name)}.activity

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.lifecycle.AbstractSavedStateViewModelFactory
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import ${namespace}.${java.nameNamespace(app.name)}.sdk.repository.*
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.*
import ${namespace}.${java.nameNamespace(app.name)}.ui.screens.${java.nameType(page.name)}Screen
import ${namespace}.${java.nameNamespace(app.name)}.viewmodel.*

class ${java.nameType(page.name)}Activity : ComponentActivity() {

  private val viewModel: ${java.nameType(page.name)}ViewModel by lazy {
    val args = Bundle().apply {
<#list pageParams as param>
      putString("${java.nameVariable(param)}", intent.getStringExtra("${java.nameVariable(param)}"))
</#list>         
    }
    val repository = MemoryRepository()
    val factory = object : AbstractSavedStateViewModelFactory(this@${java.nameType(page.name)}Activity, args) {
      @Suppress("UNCHECKED_CAST")
      override fun <T : ViewModel> create(
        key: String,
        modelClass: Class<T>,
        handle: SavedStateHandle
      ): T = ${java.nameType(page.name)}ViewModel(repository, handle) as T
    }
    ViewModelProvider(this, factory)[${java.nameType(page.name)}ViewModel::class.java]
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)  
    setContent {
      Theme {
        ${java.nameType(page.name)}Screen(
          viewModel = viewModel,       
          onBack = { finish() }
        )
      }
    }
  }

}
