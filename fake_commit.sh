#!/bin/bash
set -euo pipefail

# === 可修改的参数 ===
branch="main"                       # 目标分支（根据你远程仓库默认分支改成 main 或 master）
start_date="2023-09-13"             # 开始日期（示例：两年前）
end_date="$(date +%Y-%m-%d)"        # 结束日期（今天）
GIT_AUTHOR_NAME="CMXX648"           # 请改成你的 GitHub 名
GIT_AUTHOR_EMAIL="1499263566@qq.com"  # 请改成你在 GitHub 上的 email（使提交关联到你账号）

# 提交消息池（可按需修改）
messages=("fix bug" "update docs" "add feature" "refactor code" "improve performance" "update config")

# 确保处于仓库根目录
if [ ! -d ".git" ]; then
  echo "错误：当前目录不是 Git 仓库（.git 不存在）。请先 git clone 或 git init 并设置 remote。"
  exit 1
fi

current_month_start="$start_date"

while [[ "$current_month_start" < "$end_date" ]]; do
  month=$(date -d "$current_month_start" +%Y-%m)
  # 生成 2~3 次提交（更真实）
  num_commits=$(( (RANDOM % 2) + 2 ))

  for ((i=1; i<=num_commits; i++)); do
    # 当月随机一天（1~28）
    day=$(( (RANDOM % 28) + 1 ))
    commit_date_date="$month-$(printf "%02d" "$day")"

    # 如果生成的日期超出今天，则跳过
    if [[ "$commit_date_date" > "$end_date" ]]; then
      continue
    fi

    # 设定完整时间（加上时区偏移，避免 Git 解析歧义）
    commit_date="$commit_date_date 12:00:00 +08:00"

    # 导出作者/提交者信息与时间
    export GIT_AUTHOR_DATE="$commit_date"
    export GIT_COMMITTER_DATE="$commit_date"
    export GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME"
    export GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL"
    export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
    export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

    # 在仓库内某个文件写入并提交（避免污染其他目录）
    echo "${messages[$RANDOM % ${#messages[@]}]} on $commit_date_date" >> fake_history.log
    git add fake_history.log

    git commit -m "Fake: ${messages[$RANDOM % ${#messages[@]}]} on $commit_date_date" --author="$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
  done

  # 下一个月
  current_month_start=$(date -d "$month-01 +1 month" +%Y-%m-%d)
done

# 强制推送到远程（重写历史）
git push origin "$branch" --force
echo "完成：历史已伪造并强制推送到 origin/$branch（注意远程 push 时间仍为当前真实时间）"

