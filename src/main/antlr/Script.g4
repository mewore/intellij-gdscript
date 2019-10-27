grammar Script;

import Core;

file: NL* statement? ((NL | SEMICOLON)+ statement)* (NL | SEMICOLON)* EOF;

statement: (var_statement | const_statement | func_statement | for_statement | while_statement | class_statement | extends_statement | class_name_statement | enum_statement | if_statement | elif_statement | else_statement | return_statement | signal_statement | assign_statement | match_statement | match_entry_statement | expression | PASS | BREAK | CONTINUE | TOOL | LINE_COMMENT) LINE_COMMENT?;
var_statement: (PUPPET | MASTER)? (EXPORT (PARENTHES_LEFT arguments PARENTHES_RIGHT)?)? ONREADY? VAR IDENTIFIER (COLON type)? (ASSIGN expression)? (SETGET IDENTIFIER? (COMMA IDENTIFIER)?)?;
const_statement: CONST IDENTIFIER (COLON type)? ASSIGN expression;
func_statement: (STATIC | PUPPET | MASTER | SYNC | REMOTE)? FUNC IDENTIFIER PARENTHES_LEFT func_argument? (COMMA func_argument)* PARENTHES_RIGHT (ARROW type)? COLON;
func_argument: IDENTIFIER (COLON type)? (ASSIGN expression)?;
for_statement: FOR expression COLON;
while_statement: WHILE expression COLON;
class_statement: CLASS IDENTIFIER (EXTENDS type)? COLON;
extends_statement: EXTENDS (type | string) (DOT type)*;
class_name_statement: CLASS_NAME IDENTIFIER;
enum_statement: ENUM IDENTIFIER? BRACE_LEFT NL* enum_entry (COMMA NL* enum_entry)* BRACE_RIGHT;
enum_entry: IDENTIFIER (ASSIGN NUMBER)? NL*;
if_statement: IF expression COLON statement?;
elif_statement: ELIF expression COLON statement?;
else_statement: ELSE COLON statement?;
return_statement: RETURN expression?;
signal_statement: SIGNAL IDENTIFIER (PARENTHES_LEFT arguments PARENTHES_RIGHT)?;
assign_statement: expression (ASSIGN) expression;
match_statement: MATCH expression COLON;
match_entry_statement: expression COLON;

expression: value ((operator value) | (type_operator (type | invoke)))*;
operator: MINUS | OTHER_OPERATORS | COMPARE | AND | OR | IN | DOT | IF | ELSE;
type_operator: AS | IS;
value: (MINUS | NOT | NOT_BITWISE | NOT_BOOLEAN)? (IDENTIFIER | NODE | TRUE | FALSE | SELF | NULL | NUMBER | string | array | dictionary | dictionary_lua | invoke | subscribe | in_braces | type);
array: BRACKET_LEFT arguments BRACKET_RIGHT;
dictionary: BRACE_LEFT NL* dictionary_entry? (COMMA NL* dictionary_entry)* BRACE_RIGHT;
dictionary_entry: (string | NUMBER) COLON expression NL*;
dictionary_lua: BRACE_LEFT NL* dictionary_lua_entry? (COMMA NL* dictionary_lua_entry)* BRACE_RIGHT;
dictionary_lua_entry: IDENTIFIER ASSIGN expression NL*;
invoke: DOT? (IDENTIFIER | primitive) PARENTHES_LEFT arguments PARENTHES_RIGHT;
subscribe: IDENTIFIER (BRACKET_LEFT expression BRACKET_RIGHT)+;
in_braces: PARENTHES_LEFT expression PARENTHES_RIGHT;
arguments: NL* expression? NL* (COMMA NL* expression)* NL*;
type: IDENTIFIER | primitive;
string: STRING | STRING_MULTILINE | STRING_APHOSTROPHE;
primitive: BOOL | INT | FLOAT | VOID;

REMOTE: 'remote';
PUPPET: 'puppet';
MASTER: 'master';
SYNC: 'sync';
REMOTESYNC: 'remotesync';
MASTERSYNC: 'mastersync';
PUPPETSYNC: 'puppetsync';
MATCH: 'match';
EXPORT: 'export';
ONREADY: 'onready';
VAR: 'var';
SETGET: 'setget';
CONST: 'const';
STATIC: 'static';
FUNC: 'func';
FOR: 'for';
WHILE: 'while';
CLASS: 'class';
EXTENDS: 'extends';
CLASS_NAME: 'class_name';
ENUM: 'enum';
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
RETURN: 'return';
PASS: 'pass';
TOOL: 'tool';
SIGNAL: 'signal';
BREAK: 'break';
CONTINUE: 'continue';

NOT: 'not';
AND: 'and';
OR: 'or';
IN: 'in';
IS: 'is';
AS: 'as';
SELF: 'self';
NULL: 'null';
TRUE: 'true';
FALSE: 'false';
BOOL: 'bool';
INT: 'int';
FLOAT: 'float';
VOID: 'void';

ASSIGN: '=' | ':='| '+=' | '-=' | '*=' | '/=' | '%=' | '&=' | '|=';
ARROW: '->';
MINUS: '-';
OTHER_OPERATORS: '+' | '*' | '/' | '%' | '<<' | '>>' | '&' | '^' | '|' | '&&' | '||';
COMPARE: '<' | '>' | '==' | '!=' | '>=' | '<=';
NOT_BITWISE: '~';
NOT_BOOLEAN: '!';
SEMICOLON: ';';
NODE: '$' ((LOWER_CASE | UPPER_CASE | DIGIT | '/')* | STRING);
STRING: '"' (~["\n])* '"';
STRING_APHOSTROPHE: '\'' (~['\n])* '\'';
STRING_MULTILINE: '"""' .*? '"""';
LINE_COMMENT: '#' ~[\n]*;


