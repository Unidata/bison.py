/* Infix notation calculator--calc.  */
%name-prefix "Calc"
%define parser_class_name {Calc}
%locations

%code imports {
import os
import token
import re
import math
import string
}



/* Bison Declarations */
%token <Integer> NUM "number"
%type  <Integer> exp

%nonassoc '=' /* comparison            */
%left '-' '+'
%left '*' '/'
%left NEG     /* negation--unary minus */
%right '^'    /* exponentiation        */

/* Grammar follows */
%%
input:
  line
| input line
;

line:
  '\n'
| exp '\n'
        {sys.stdout.write("total = " + str(int($1)) +'\n')}
| error '\n'
;

exp:
  NUM                { $$ = $1}
| exp '=' exp
{
if ($1 != $3) :
  yyerror (@$,
           "calc: error: " + str($1) + " != " + str($3));
}
| exp '+' exp
    { $$ = $1 + $3 }
| exp '-' exp
    { $$ = $1 - $3 }
| exp '*' exp
    { $$ = $1 * $3 }
| exp '/' exp
    { $$ = $1 / $3 }
| '-' exp  %prec NEG
    { $$ = -$2 }
| exp '^' exp
    { $$ = math.pow($1,$3) }
| '(' exp ')'        { $$ = $2}
| '(' error ')'      { $$ = (1111)}
| '!'
       {
       $$ = (0)
       return YYERROR
       }
| '-' error
    {
        $$ = (0)
        return YYERROR
    }
;


%%

def tokenizer(text) :
  # Append a zero character to signal EOF
  text += '\0'
  tokens = []
  line = 1
  row = 0
  index = 0
  while True :
    c = text[index]
    if c == '\0' : break
    elif c == ' ' :
      row += 1
      index += 1
      continue
    elif c == '\n' :
      line += 1
      row = 0
      tokens.append((token.NEWLINE, c, (line, row), (line,row+1)))
    elif string.find("-+=*^()!",c) >= 0 :
      tokens.append((token.OP, c, (line, row), (line,row+1)))
    elif string.find("0123456789",c) >= 0 :
      saveline = line
      saverow = row
      number = c
      while True :
        index += 1
        row += 1
        c = text[index]
        if string.find("0123456789",c) < 0 : break;
        number += c
      # end while
      index -= 1 # backup
      row -= 1
      tokens.append((token.NUMBER,number,(saveline,saverow),(line,row)))
    else :
      tokens.append((token.NAME,c,(line,row),(line,row+1)))
    index += 1
    row += 1
  # end while
  assert c == '\0'
  tokens.append((token.ENDMARKER,'\0',(line,row),(line,row)))
  return tokens


class YYLexer(Lexer) :

  def __init__ (self) :

    self.yypos = Position (1, 0)

    self.tokens = tokenizer(sys.stdin.read())
    self.ntokens = len(self.tokens)
    self.index = 0

  def yyerror (self, location, msg) :
    s = msg

    if location is not None :
      s = str(location) + ": " + s
    sys.stderr.write(s+'\n')

  def yylex (self) :
    while (True) :
      if (self.index >= self.ntokens) :
        return (EOF, None)
      type, text, start, end = self.tokens[self.index]
      self.index += 1
      self.yypos = Position (start[0], start[1]+1)
      if type == token.NEWLINE :
        return (ord('\n'), None)
      elif type == token.NUMBER :
        return (NUM, int(text))
      elif type == token.OP :
        return (ord(text[0]), None)
      elif type == token.NAME : # Return the first character
        return (ord(text[0]), None)
      elif type == token.ENDMARKER : # EOF
        return (EOF,None)
      else :
        pass
  # end yylex

  def getStartPos(self) :
    return self.yypos

  def getEndPos(self) :
     return self.yypos




class Position :

  def __init__ (self, l, t) :
    self.line = l
    self.token = t

  def __str__ (self) :
    return str(self.line) + '.' + str(self.token)

  def lineno (self) :
    return self.line

  def token (self) :
    return self.token

  def __eq__(self, other):
    if isinstance(other,Position):
      return self.line == other.line and self.token == other.token
    return NotImplemented

  def __ne__(self, other):
    result = (self == other)
    if result is NotImplemented:
      return result
    return not result



def main () :
  calc = Calc(YYLexer())
  calc.setDebugLevel(1)
  calc.parse()

if __name__ == "__main__" :
  main()

