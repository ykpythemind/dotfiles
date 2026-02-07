---
name: manage-pull-request
description: Manage (create, update) a git pull request
version: 1.0.0
---

- Git Commitが終わったらPull Requestを作成する
- そのブランチに対してPull Requestが作成されていない場合は作成する
- 使うコマンド： `gh pr create --draft`
