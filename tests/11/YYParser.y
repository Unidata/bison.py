%code imports {
pass # %code imports
}
%code top {
pass # %code top
}
%code requires{
pass # %code requires
}
%code provides {
pass # %code provides
}
%code {
pass # %code 1
}
%code {
pass # %code 2
}
%%
start: 'a' 'b' 'c' {pass};
%%
pass # %code epilogue
