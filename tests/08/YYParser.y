%debug
%token-table
%token END "end"

%define api.location.type {MyLoc}
%define api.position.type {MyPos}
%locations
%code {

class MyPos :

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
    if isinstance(other,MyPos):
      return self.line == other.line and self.token == other.token
    return NotImplemented

  def __ne__(self, other):
    result = (self == other)
    if result is NotImplemented:
      return result
    return not result


}


%%
start: END
{pass}
;
%%
class YYLexer :

  # Minimal lexer
  def __init__(self):
    self.count=0
  def getStartPos(self) : return Position(0,0)
  def getEndPos(self) : return Position(0,0)
  def yyerror (self, loc , s) :
    sys.stderr.write (str(loc) + ": " + s + '\n')
  def yylex (self) :
    if self.count == 0 :
      token = (END, None)
    else :
      token = (EOF, None)
    self.count += 1
    return token


def main() :
  p = YYParser(YYLexer())
  p.parse()

