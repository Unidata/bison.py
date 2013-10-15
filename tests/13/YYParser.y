%define parser_class_name {YYParser}
%error-verbose
%%

start: 'a' 'b' 'c' ;

%%

class YYLexer (Lexer) :
  def __init__(self) : pass
  def yylex (self) : pass
  def yyerror (self, msg) :
    s = msg
    sys.stderr.write(s+'\n')

def setup() :
  global parser, teststate
  yyerror = YYLexer()
  parser = YYParser(yyerror)
  #parser.setDebugLevel(1)
  teststate = -1

teststatename = ("YYACCEPT","YYABORT","YYERROR","UNKNOWN","YYPUSH_MORE")

def check(teststate, expected, msg) :
  sys.stderr.write("teststate="+teststatename[teststate]
                       +" expected="+teststatename[expected] + '\n')
  if (teststate == expected) :
    return
  sys.stderr.write("unexpected state: "+msg+'\n')
  sys.exit(1)

def main() :
  setup()
  teststate = parser.push_parse(ord('a'), None)
  check(teststate,YYPUSH_MORE,"push_parse('a', None)")

  setup()
  teststate = parser.push_parse(ord('a'), None)
  check(teststate,YYPUSH_MORE,"push_parse('a', None)")
  teststate = parser.push_parse(ord('b'), None)
  check(teststate,YYPUSH_MORE,"push_parse('b', None)")
  teststate = parser.push_parse(ord('c'), None)
  check(teststate,YYPUSH_MORE,"push_parse('c', None)")
  teststate = parser.push_parse(ord('\0'), None)
  check(teststate,YYACCEPT,"push_parse('\\0', None)")

  # Reuse the parser instance and cause a failure
  teststate = parser.push_parse(ord('b'), None)
  check(teststate,YYABORT,"push_parse('b', None)")

  sys.exit(0)

if __name__ == "__main__":
  main()
