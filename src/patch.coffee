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

QUERY = "AssignmentExpression[operator='=']"
PATTERN = ///
  (\w+)\s* # newScale
  =\s*
  Math\.pow\(\s*
    Math\.min\(\s*
      ([\d\.]+)\s* # 64
      /\s*
      \1\s* # newScale
      ,\s*
      ([\d\.]+)\s* # 1
    \)\s*
    ,\s*
    ([\d\.]+)\s* # 0.4
  \)\s*
///
TMPL = tmplExpr estemplate.compile '''
  (<%= orig %>) / window.agarZoom
'''

patch = (src) ->
  srcTree = esprima.parse src
  eswalk.walkAddParent srcTree, (->)
  exprs = esquery.match srcTree, esquery.parse QUERY
  for expr in exprs
    exprStr = escodegen.generate expr.parent, genOpt
    if match = exprStr.match PATTERN
      newScale = match[1]
      expr.right = TMPL orig: expr.right
      # console.log escodegen.generate expr.parent
  escodegen.generate srcTree

module.exports = patch
