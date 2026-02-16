#!/bin/bash
# AI Products Auto-Poster - Twitter Automation

# This script posts to Twitter (requires Twitter API setup)
# For now, it generates ready-to-post content

AI_PRODUCTS=(
  "🚀 Free ChatGPT Prompts! 130+ prompts for business & life. Download now: https://github.com/CandyBoy79/ai-products-store"
  "🎨 Midjourney V6 Prompts - 250+ ready-to-use image prompts! #AI #Art #Midjourney"
  "🐍 Python Automation Scripts - 50+ scripts for web scraping & more! #Python #Automation"
  "📝 Notion Templates - Life OS, Business & Creative templates! #Notion #Productivity"
  "💡 AI Tip: Use specific details in your prompts for better results!"
  "🎯 Want to monetize AI skills? Check out our free prompts bundle!"
)

# Pick random post
random_index=$((RANDOM % ${#AI_PRODUCTS[@]}))
POST_CONTENT="${AI_PRODUCTS[$random_index]}"

echo "📝 Generated Post:"
echo "$POST_CONTENT"
echo ""
echo "To auto-post, set up Twitter API credentials in config.json"

# Save to queue for manual review
echo "$POST_CONTENT" >> ~/Desktop/ai-products/social-posts queue.txt
echo "✅ Post saved to queue. Ready for publishing!"
