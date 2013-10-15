%debug
%token-table
%token END "end"

%initial-action {    # Watch the indent
    sys.stdout.write("Initial action invoked\n")
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
  def yyerror (self,  s) :
    sys.stderr.write ( s + '\n')
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
if __name__ == "__main__" : main()
