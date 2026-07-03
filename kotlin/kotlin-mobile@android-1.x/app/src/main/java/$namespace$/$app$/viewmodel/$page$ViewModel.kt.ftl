package ${namespace}.${java.nameNamespace(app.name)}.viewmodel 

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class ${java.nameType(page.name)}ViewModel : ViewModel() {
    
  private val _uiState = MutableStateFlow<String>("Loading...")
  val uiState: StateFlow<String> = _uiState.asStateFlow()

  fun fetchData() {
    // Launches a coroutine in the ViewModel scope
    viewModelScope.launch {
      try {
        // Simulate a network/API call
        kotlinx.coroutines.delay(1000)
        _uiState.value = "Data successfully fetched!"
      } catch (e: Exception) {
        _uiState.value = "Error fetching data"
      }
    }
  }
}
