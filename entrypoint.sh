#!/bin/sh

git clone https://d-woegerbauer:$GITHUB_TOKEN@github.com/pcode-at/ecoled-shopify-store.git
cd ecoled-shopify-store
git config user.name "d-woegerbauer"
git config user.email "david.woegerbauer@pcode.at"
git fetch
git checkout github-action-updates
git pull --rebase
cd "$THEME_PATH"
curl -s https://shopify.github.io/themekit/scripts/install.py | sudo python
theme configure --password="$SHOPIFY_PRODUCTION_PASSWORD" --store="$SHOPIFY_PRODUCTION_STORE_URL" --themeid="$SHOPIFY_PREPRODUCTION_THEME_ID"
theme download --no-ignore config/settings_data.json locales/*
git add config/settings_data.json locales/*
git diff --quiet && git diff --staged --quiet || git commit -am 'Updated settings_data.json and locales directory'
git push origin github-action-updates
git checkout develop
git merge github-action-updates -m="Update shopify configuration"
git push origin develop
theme configure --password="$SHOPIFY_DEVELOP_PASSWORD" --store="$SHOPIFY_DEVELOP_STORE_URL" --themeid="$SHOPIFY_DEVELOP_THEME_ID"
theme deploy --no-ignore --allow-live