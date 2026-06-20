#!/usr/bin/env bash
# Reproducible build for the JSON Resume page.
# Exports resume.json with the `slick` theme, applies an https hotfix, and
# injects the Certificates and Projects sections (slick does not render them natively).
set -euo pipefail
cd "$(dirname "$0")"
npx resume export index.html --theme slick
python3 - <<'PY'
import io,json
R=json.load(open("resume.json",encoding="utf-8"))
def sec(idv,icon,title,items):
    return ('\n\t<section id="%s" class="row">\n\t\t<div class="col-sm-4">\n\t\t\t<div class="row">\n'
            '\t\t\t\t<div class="col-xs-2">\n\t\t\t\t\t<icon class="large %s"></icon>\n\t\t\t\t</div>\n'
            '\t\t\t\t<div class="col-xs-10">\n\t\t\t\t\t<h2 class="section-title">%s</h2>\n\t\t\t\t</div>\n'
            '\t\t\t</div>\n\t\t</div>\n\t\t<div class="col-sm-8">%s\n\t\t</div>\n\t</section>\n'%(idv,icon,title,items))
ci="".join('\n\t\t\t<div class="item">\n\t\t\t\t<h3 class="title">%s</h3>\n'
    '\t\t\t\t<div class="awarder">\n\t\t\t\t\t<p class="lead">%s</p>\n\t\t\t\t</div>\n'
    '\t\t\t\t<div class="date">%s</div>\n\t\t\t</div>'%(c["name"],c.get("issuer",""),c.get("date","")) for c in R.get("certificates",[]))
pi="".join('\n\t\t\t<div class="item">\n\t\t\t\t<div class="name">\n\t\t\t\t\t<h3>%s</h3>\n\t\t\t\t</div>\n'
    '\t\t\t\t<div class="publisher">\n\t\t\t\t\t<p class="lead">%s</p>\n\t\t\t\t</div>\n'
    '\t\t\t\t<div class="website">\n\t\t\t\t\t<a href="%s">Link</a>\n\t\t\t\t</div>\n\t\t\t</div>'%(p["name"],p.get("description",""),p.get("url","")) for p in R.get("projects",[]))
s=io.open("index.html",encoding="utf-8").read()
if R.get("certificates") and '<section id="certificates"' not in s:
    a='\t<section id="publications" class="row">'
    if a in s: s=s.replace(a, sec("certificates","entypo-ribbon","Certificates",ci)+a,1)
if R.get("projects") and '<section id="projects"' not in s:
    a='\t<section id="skills" class="row">'
    if a in s: s=s.replace(a, sec("projects","entypo-rocket","Projects",pi)+a,1)
s=s.replace("http://bootswatch.com/lumen/bootstrap.min.css","https://bootswatch.com/4/lumen/bootstrap.min.css")
s=s.replace("http://fonts.googleapis.com/css?family=Roboto:500,300","https://fonts.googleapis.com/css?family=Roboto:500,300")
io.open("index.html","w",encoding="utf-8").write(s)
print("post-processed: certificates + projects injected, https hotfix applied")
PY
echo "Built index.html (slick + certificates/projects + https)."
