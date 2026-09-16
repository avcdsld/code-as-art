git checkout -b elsewhere

sed -i '' '/TODO/d' $(git ls-files)

git add .

git commit -m "what a happy life"

git push -u origin elsewhere

git reset --soft HEAD^

git commit --allow-empty -m "what a happy life"

git push -f

git checkout main

git push origin -d elsewhere
