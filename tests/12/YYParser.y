%code lexer {

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

}
%token END "end"
%%
start: END {pass};
