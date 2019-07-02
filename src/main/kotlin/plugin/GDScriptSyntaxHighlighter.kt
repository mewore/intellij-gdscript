package plugin

import com.intellij.lexer.Lexer
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors
import com.intellij.openapi.editor.colors.TextAttributesKey
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase
import com.intellij.psi.tree.IElementType
import org.antlr.intellij.adaptor.lexer.ANTLRLexerAdaptor
import org.antlr.intellij.adaptor.lexer.TokenIElementType
import plugin.parser.GDScriptLexer
import plugin.parser.GDScriptLexer.*

typealias DefaultColor = DefaultLanguageHighlighterColors

class GDScriptSyntaxHighlighter : SyntaxHighlighterBase() {

    override fun getHighlightingLexer(): Lexer {
        val lexer = GDScriptLexer(null)
        return ANTLRLexerAdaptor(GDScript, lexer)
    }

    override fun getTokenHighlights(type: IElementType): Array<out TextAttributesKey> {
        if (type !is TokenIElementType)
            return emptyArray()
        return when (type.antlrTokenType) {
            IDENTIFIER -> arrayOf(DefaultColor.IDENTIFIER)
            NUMBER -> arrayOf(DefaultColor.NUMBER)
            STRING -> arrayOf(DefaultColor.STRING)
            else -> emptyArray()
        }
    }

}
