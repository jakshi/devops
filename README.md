# verydevops.com (retired)

This site has been retired. All content has either moved to
[lysenko.dev](https://lysenko.dev/) or been dropped as obsolete.

The blog used to live on this branch as a Hugo site (Hugo + hugo-octopress
theme, deployed via Travis CI to `gh-pages`). The full Hugo source is preserved
on the [`archive`](https://github.com/jakshi/devops/tree/archive) branch.

`master` now serves three files via GitHub Pages:

- `CNAME` — keeps `verydevops.com` pointing here while DNS is in place.
- `index.html` — redirects to `lysenko.dev`, preserving the request path.
- `404.html` — does the same for any unmatched route. Migrated posts have
  matching aliases on `lysenko.dev` so old `/post/<slug>` URLs land on the
  new article.

When DNS is unconfigured, this repo can be archived too.
