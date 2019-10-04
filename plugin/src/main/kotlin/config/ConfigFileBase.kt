package config

import com.intellij.extapi.psi.PsiFileBase
import com.intellij.psi.FileViewProvider
import org.antlr.intellij.adaptor.psi.ScopeNode

class ConfigFileBase(viewProvider: FileViewProvider) : PsiFileBase(viewProvider, ConfigLanguage) {

    override fun getFileType() = ConfigFileType

    override fun getIcon(flags: Int) = ConfigFileType.icon

    override fun getContext(): ScopeNode? = null

}