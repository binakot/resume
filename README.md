# Resume of Ivan Muratov

Made with http://jsonresume.org and hosted by http://github.com

Want to make your own resume from JSON?

```bash
npm install resume-cli jsonresume-theme-slick
resume init
resume export index.html --theme slick
```

A little hotfix of styles: replace two links in html head section of exported `index.html`:

```html
# from
<link href="http://bootswatch.com/lumen/bootstrap.min.css" rel="stylesheet">
<link href='http://fonts.googleapis.com/css?family=Roboto:500,300' rel='stylesheet' type='text/css'>

# to
<link href="https://bootswatch.com/4/lumen/bootstrap.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Roboto:500,300' rel='stylesheet' type='text/css'>
```

Inspired by https://github.com/BretFisher/resume.
