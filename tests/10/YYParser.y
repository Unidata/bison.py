%lex-param { s }
%code lexer {
  def __init__(self, s) :
    self.Input = s
    self.Position = 0
  def yyerror(self,s):
    sys.stderr.write (s+'\n')
  def yylex(self) :
    if (self.Position >= len(self.Input)) :
      result = (EOF,None)
    else :
      # Remember: we must return an integer, not a character
      # (= string of length 1)
      result = (ord(self.Input[self.Position]),None)
      self.Position += 1
    return result
}
%%
input:
  'a' 'a'
;
%%
def main ():
  p = YYParser (sys.argv[1])
  p.parse ();
if __name__ == "__main__" :
  main()
