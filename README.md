RubyParserCombinator
====================

Rubyによる使いやすいパーサーコンビネーターを目指します。

以下のような拡張BNFを、

Value ← [0-9]+ / '(' Expr ')'
Product ← Value (('*' / '/') Value)*
Sum ← Product (('+' / '-') Product)*
Expr ← Sum

以下のようなRubyプログラムで実装できます。

expr = nil
value = grammar{ /[0-9]+/ / ('(' + expr + ')') }
product = value + ('*' / '/' + value).*
sum = product + ('+' / '-' + product).*
expr = sum
