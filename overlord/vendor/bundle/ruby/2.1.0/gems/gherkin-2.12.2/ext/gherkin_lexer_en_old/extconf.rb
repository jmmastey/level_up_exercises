require 'mkmf'
CONFIG['warnflags'].gsub!(/-Wshorten-64-to-32/, '') if CONFIG['warnflags']
$CFLAGS << ' -O0 -Wall' if CONFIG['CC'] =~ /gcc|clang/
dir_config("gherkin_lexer_en_old")
have_library("c", "main")
create_makefile("gherkin_lexer_en_old")
