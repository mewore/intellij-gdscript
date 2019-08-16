package plugin.parser

import com.intellij.testFramework.ParsingTestCase
import org.antlr.intellij.adaptor.xpath.XPath
import org.junit.Assert
import plugin.GDScript

class GDScriptParserDefinitionTest : ParsingTestCase("", "GDScript", GDScriptParserDefinition()) {

    fun `test function`() {
        val code = """
            func asd(param1, param2)
            """
        assertXPathMatches(code)
    }

    fun `test extends`() {
        val code = """
            # comment
            extends BaseClass # comment after statement
            extends Vector2
            extends "base.gd"
            """
        assertXPathMatches(code)
    }

    fun `test enum`() {
        val code = """
            enum {UNIT_ENEMY, UNIT_ALLY}
            enum Color {RED, GREEN = "message", UNKNOWN = -1}
            """
        assertXPathMatches(code)
    }

    fun `test var export`() {
        val code = """
            var declaration_only
            var declaration_and_initialisation = 1.0
            onready var x = y
            export(int) var volume
            export(int, "Warrior", "Magician", "Thief") var character_class
            export(float, -10.0, PATH = "hello") var parameter = 0.72
        """
        assertXPathMatches(code)
    }

    fun `test var setget`() {
        val code = """
            # setter and getter
            var health = 100 setget set_health, get_health
            # only setter
            var health = 5 setget set_health
            # only getter (see: comma)
            var my_var = 5 setget ,get_health
        """
        assertXPathMatches(code)
    }

    fun `test array init`() {
        val code = """
            var array = ["Hello" + "World", Vector2, MAX_HEALTH]
            array[0] = "Godot"
            array[-1] = MIN_HEALTH
            array[1 + 2] = SomeValue
        """
        assertXPathMatches(code)
    }

    fun `test complex operator expression`() {
        assertXPathMatches("var damage = level + get_weapon_attack(Axe) * skill[STR_INDEX] / 3.14")
    }

    fun `test comment`() {
        val code = """
            # comment
            return null # comment after statement
            """
        assertXPathMatches(code)
    }

    private fun assertXPathMatches(code: String, xpath: String = "/file") {
        myFile = createPsiFile("a", code.trimIndent())
        ensureParsed(myFile)
        val tree = ASTNodePrinter.build(myFile.node)
        val nodes = XPath.findAll(GDScript, myFile, xpath)
        if (nodes.isEmpty())
            Assert.fail("Unsatisfied selector '$xpath'\nCode:\n${myFile.text}\nTree:\n$tree")
        print(tree)
    }

}
