# Resume of Ivan Muratov

Made with [JSON Resume](https://jsonresume.org) and hosted on [GitHub Pages](https://binakot.github.io/resume).

## Build

```bash
npm install
./build.sh
```

`build.sh` exports `resume.json` with the **slick** theme, applies an `http`→`https` hotfix, and injects the **Certificates** and **Projects** sections (which the slick theme does not render natively). All résumé data lives in `resume.json`; the round avatar is `avatar.jpg`.

Theme: [jsonresume-theme-slick](https://www.npmjs.com/package/jsonresume-theme-slick).

Inspired by https://github.com/BretFisher/resume.
