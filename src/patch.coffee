esprima = require 'esprima'
escodegen = require 'escodegen'
eswalk = require 'esprima-walk'
esquery = require 'esquery'
estemplate = require 'estemplate'

parseExpr = (exprStr) -> esprima.parse(exprStr).body[0].expression
tmplExpr = (template) -> ->
  template.apply(null, arguments).body[0].expression
genOpt =
  format:
    compact: true

QUERY = "ExpressionStatement > LogicalExpression[operator='&&']"
PATTERN = ///
  (1)\s* # 1
  >\s*
  (\w+)\s* # E
  &&\s*
  \(\s*
    \2\s* # E
    =\s*
    \1\s* #1
  \)
///

patch = (src) ->
  srcTree = esprima.parse src
  eswalk.walkAddParent srcTree, (->)
  exprs = esquery.match srcTree, esquery.parse QUERY
  # console.log exprs
  for expr in exprs
    exprStr = escodegen.generate expr.parent, genOpt
    #console.log exprStr
    if match = exprStr.match PATTERN
      expr.right = expr.left
      console.log escodegen.generate expr.parent
  srcMod1 = escodegen.generate srcTree
  srcMod2 = srcMod1.replace /localStorage/g, 'fuckLocalStorage'
  srcMod3 = """
  window.fuckLocalStorage = {};
  #{srcMod2}
  """

module.exports = patch
