#!/bin/bash
# 每日日记自动生成脚本
# 用法: 配合 cron 在每晚 23:50 运行
# crontab -e 添加: 50 23 * * * /home/user/DailyDiary/write_diary.sh

DATE=$(date +%Y-%m-%d)
DIARY_DIR="/home/user/DailyDiary/diary"
DIARY_FILE="$DIARY_DIR/$DATE.md"

# 如果今天的日记已经存在，跳过
if [ -f "$DIARY_FILE" ]; then
    echo "今天的日记已存在: $DIARY_FILE"
    exit 0
fi

mkdir -p "$DIARY_DIR"

# 调用 claude 生成日记
claude -p "请用简体中文写一篇今天（${DATE}）的日记，记录这一天的感受。格式以 '# ${DATE} 日记' 开头，内容真挚自然，300字左右。" > "$DIARY_FILE"

echo "日记已生成: $DIARY_FILE"
