package gdscript.completion.utilities.models

import com.fasterxml.jackson.annotation.JsonProperty

data class Method(
    val name: String,
    @JsonProperty("return") val returnType: Return?,
    val description: String?
)