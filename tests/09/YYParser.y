%token <object>END
%token <File> FILE
%type <File> file1 file2
%type <object> start

%%
start: file1 ;
file1: file2 END {$$=$2}
file2: FILE {$$=$1}
%%
