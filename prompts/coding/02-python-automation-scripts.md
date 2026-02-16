# Python Automation Scripts - 50+ Ready-to-Use Scripts

## 📚 Contents

### 1. Web Scraping (10 Scripts)
### 2. File Management (10 Scripts)
### 3. Social Media Automation (10 Scripts)
### 4. Data Processing (10 Scripts)
### 5. Email Automation (5 Scripts)
### 6. Image Processing (5 Scripts)

---

# CHAPTER 1: WEB SCRAPING

## 1.1 Simple Web Scraper
```python
import requests
from bs4 import BeautifulSoup

url = "https://example.com"
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# Extract data - modify as needed
titles = soup.find_all('h1')
for title in titles:
    print(title.text)
```

## 1.2 JSON API Scraper
```python
import requests

url = "https://api.example.com/data"
response = requests.get(url)
data = response.json()

# Process data
for item in data:
    print(item['name'], item['value'])
```

## 1.3 Table to CSV
```python
import requests
from bs4 import BeautifulSoup
import csv

url = "https://example.com/table"
soup = BeautifulSoup(requests.get(url).text, 'html.parser')

table = soup.find('table')
rows = table.find_all('tr')

with open('output.csv', 'w', newline='') as f:
    writer = csv.writer(f)
    for row in rows:
        cols = row.find_all(['td', 'th'])
        writer.writerow([col.text.strip() for col in cols])
```

## 1.4 Image Downloader
```python
import requests
from bs4 import BeautifulSoup
import os

url = "https://example.com/images"
soup = BeautifulSoup(requests.get(url).text, 'html.parser')
images = soup.find_all('img')

os.makedirs('images', exist_ok=True)

for i, img in enumerate(images):
    img_url = img.get('src')
    if img_url:
        response = requests.get(img_url)
        with open(f'images/img_{i}.jpg', 'wb') as f:
            f.write(response.content)
```

## 1.5 News Scraper
```python
import requests
from bs4 import BeautifulSoup

url = "https://news.example.com"
soup = BeautifulSoup(requests.get(url).text, 'html.parser')

articles = soup.find_all('article')
for article in articles[:10]:
    title = article.find('h2')
    if title:
        print(title.text)
```

## 1.6 Product Price Tracker
```python
import requests
from bs4 import BeautifulSoup
import time

products = [
    "https://amazon.com/product1",
    "https://amazon.com/product2"
]

for url in products:
    soup = BeautifulSoup(requests.get(url).text, 'html.parser')
    price = soup.find('span', class_='price')
    print(f"Price: {price.text if price else 'Not found'}")
    time.sleep(2)
```

## 1.7 Email Extractor
```python
import requests
from bs4 import BeautifulSoup
import re

url = "https://example.com/contact"
soup = BeautifulSoup(requests.get(url).text, 'html.parser')

emails = re.findall(r'\b[\w.-]+@[\w.-]+\.\w+\b', soup.text)
for email in set(emails):
    print(email)
```

## 1.8 Link Checker
```python
import requests
from bs4 import BeautifulSoup

url = "https://example.com"
soup = BeautifulSoup(requests.get(url).text, 'html.parser')

links = soup.find_all('a')
for link in links[:20]:
    href = link.get('href')
    if href:
        try:
            r = requests.head(href, timeout=5)
            print(f"{href}: {r.status_code}")
        except:
            print(f"{href}: Error")
```

## 1.9 Google Search Results
```python
import requests
from bs4 import BeautifulSoup
import urllib.parse

query = "python automation"
url = f"https://www.google.com/search?q={urllib.parse.quote(query)}"

headers = {'User-Agent': 'Mozilla/5.0'}
soup = BeautifulSoup(requests.get(url, headers=headers).text, 'html.parser')

results = soup.find_all('h3')
for result in results[:10]:
    print(result.text)
```

## 1.10 Sitemap Parser
```python
import requests
import xml.etree.ElementTree as ET

url = "https://example.com/sitemap.xml"
response = requests.get(url)
root = ET.fromstring(response.content)

for url in root.findall('.//{http://www.sitemaps.org/schemas/sitemap/0.9}loc'):
    print(url.text)
```

---

# CHAPTER 2: FILE MANAGEMENT

## 2.1 Batch Rename Files
```python
import os
import glob

folder = "path/to/folder"
pattern = "*.txt"

for i, filepath in enumerate(glob.glob(f"{folder}/{pattern}"), 1):
    dirname = os.path.dirname(filepath)
    ext = os.path.splitext(filepath)[1]
    new_name = f"file_{i:03d}{ext}"
    os.rename(filepath, os.path.join(dirname, new_name))
```

## 2.2 Find Duplicate Files
```python
import os
import hashlib

def get_hash(filepath):
    with open(filepath, 'rb') as f:
        return hashlib.md5(f.read()).hexdigest()

folder = "path/to/folder"
hashes = {}

for root, dirs, files in os.walk(folder):
    for file in files:
        filepath = os.path.join(root, file)
        file_hash = get_hash(filepath)
        if file_hash in hashes:
            print(f"Duplicate: {filepath} = {hashes[file_hash]}")
        else:
            hashes[file_hash] = filepath
```

## 2.3 Organize Downloads
```python
import os
import shutil
from datetime import datetime

downloads = os.path.expanduser("~/Downloads")
extensions = {
    'Images': ['.jpg', '.png', '.gif'],
    'Documents': ['.pdf', '.doc', '.txt'],
    'Videos': ['.mp4', '.avi', '.mov'],
    'Archives': ['.zip', '.rar', '.7z']
}

for file in os.listdir(downloads):
    filepath = os.path.join(downloads, file)
    if os.path.isfile(filepath):
        ext = os.path.splitext(file)[1].lower()
        for folder, exts in extensions.items():
            if ext in exts:
                dest = os.path.join(downloads, folder)
                os.makedirs(dest, exist_ok=True)
                shutil.move(filepath, dest)
                break
```

## 2.4 Backup Files
```python
import os
import shutil
import tarfile
from datetime import datetime

source = "/path/to/source"
backup_dir = "/path/to/backups"
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

backup_file = os.path.join(backup_dir, f"backup_{timestamp}.tar.gz")

with tarfile.open(backup_file, "w:gz") as tar:
    tar.add(source, arcname=os.path.basename(source))

print(f"Backup created: {backup_file}")
```

## 2.5 File Search
```python
import os

def find_files(directory, extension):
    matches = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(extension):
                matches.append(os.path.join(root, file))
    return matches

# Usage
results = find_files("/path/to/search", ".pdf")
for f in results:
    print(f)
```

## 2.6 Count File Types
```python
import os
from collections import Counter

folder = "path/to/folder"
extensions = []

for root, dirs, files in os.walk(folder):
    for file in files:
        ext = os.path.splitext(file)[1].lower()
        if ext:
            extensions.append(ext)

for ext, count in Counter(extensions).most_common():
    print(f"{ext}: {count}")
```

## 2.7 Merge Text Files
```python
import os

files = ["file1.txt", "file2.txt", "file3.txt"]
output = "merged.txt"

with open(output, 'w') as outfile:
    for file in files:
        with open(file, 'r') as infile:
            outfile.write(infile.read() + "\n")

print("Merged!")
```

## 2.8 Split Large File
```python
import os

file = "largefile.txt"
chunk_size = 100000  # lines

with open(file, 'r') as f:
    for i, line in enumerate(f):
        if i % chunk_size == 0:
            chunk_file = open(f"chunk_{i//chunk_size}.txt", 'w')
        chunk_file.write(line)
    chunk_file.close()
```

## 2.9 Remove Empty Files
```python
import os

folder = "path/to/folder"

for root, dirs, files in os.walk(folder):
    for file in files:
        filepath = os.path.join(root, file)
        if os.path.getsize(filepath) == 0:
            os.remove(filepath)
            print(f"Removed: {filepath}")
```

## 2.10 Create Directory Tree
```python
import os

def tree(directory, prefix=""):
    entries = sorted(os.listdir(directory))
    dirs = [e for e in entries if os.path.isdir(os.path.join(directory, e))]
    files = [e for e in entries if os.path.isfile(os.path.join(directory, e))]
    
    for f in files:
        print(prefix + "├── " + f)
    for i, d in enumerate(dirs):
        print(prefix + "└── " + d + "/")
        new_prefix = prefix + ("    " if i == len(dirs)-1 else "│   ")
        tree(os.path.join(directory, d), new_prefix)

tree("path/to/folder")
```

---

# CHAPTER 3: SOCIAL MEDIA AUTOMATION

## 3.1 Twitter Post Scheduler
```python
import tweepy
from datetime import datetime

# Setup - replace with your keys
auth = tweepy.OAuthHandler(API_KEY, API_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_SECRET)
api = tweepy.API(auth)

def post_tweet(text, schedule_time):
    # Schedule for later
    api.update_status(text)
    print(f"Posted: {text}")

# Usage
post_tweet("Hello from Python!", datetime.now())
```

## 3.2 Instagram Caption Generator
```python
import random

captions = [
    "✨ {topic} ✨",
    "{topic} is everything 💫",
    "Life is better with {topic} 🌟",
    "{topic} 🌈",
    "Obsessed with {topic} 😍"
]

def generate_caption(topic):
    template = random.choice(captions)
    return template.format(topic=topic)

# Usage
print(generate_caption("coffee"))
```

## 3.3 YouTube Thumbnail Downloader
```python
import requests
from bs4 import BeautifulSoup

video_id = "dQw4w9WgXcQ"
url = f"https://youtube.com/watch?v={video_id}"

# Get thumbnail URL
thumbnail_url = f"https://img.youtube.com/vi/{video_id}/maxresdefault.jpg"

# Download
response = requests.get(thumbnail_url)
with open('thumbnail.jpg', 'wb') as f:
    f.write(response.content)

print("Downloaded!")
```

## 3.4 Social Media Analytics
```python
# Generic analytics tracker
data = {
    'instagram': {'followers': 1000, 'engagement': 5.2},
    'twitter': {'followers': 500, 'engagement': 3.1},
    'youtube': {'subscribers': 2000, 'views': 10000}
}

def print_stats(platform):
    if platform in data:
        stats = data[platform]
        print(f"{platform}: {stats}")

for p in data:
    print_stats(p)
```

## 3.5 Hashtag Generator
```python
import random

niche_hashtags = {
    'tech': ['#technology', '#innovation', '#tech', '#coding', '#programming'],
    'food': ['#foodie', '#foodporn', '#delicious', '#yummy', '#food'],
    'travel': ['#travel', '#wanderlust', '#adventure', '#explore', '#travelgram']
}

def generate_hashtags(niche, count=5):
    return ' '.join(random.sample(niche_hashtags.get(niche, []), min(count, len(niche_hashtags.get(niche, [])))))

# Usage
print(generate_hashtags('tech', 10))
```

## 3.6 Content Calendar
```python
from datetime import datetime, timedelta

content_calendar = []

def schedule_content(platform, topic, date):
    content_calendar.append({
        'platform': platform,
        'topic': topic,
        'date': date
    })

# Usage
today = datetime.now()
for i in range(7):
    schedule_content('instagram', f'Day {i+1} content', today + timedelta(days=i))

for item in content_calendar:
    print(f"{item['date'].strftime('%Y-%m-%d')}: {item['platform']} - {item['topic']}")
```

## 3.7 Auto-Reply Bot (Template)
```python
# Template for auto-reply
responses = {
    'hello': 'Hi there! Thanks for reaching out!',
    'price': 'Check our website for current pricing!',
    'default': 'Thanks for your message! We\'ll get back to soon.'
}

def get_response(message):
    message = message.lower()
    for key in responses:
        if key in message:
            return responses[key]
    return responses['default']

# Usage
print(get_response("Hello!"))
```

## 3.8 Engagement Tracker
```python
class EngagementTracker:
    def __init__(self):
        self.posts = []
    
    def add_post(self, likes, comments, shares):
        total = likes + (comments * 2) + (shares * 3)
        self.posts.append({
            'likes': likes,
            'comments': comments,
            'shares': shares,
            'engagement': total
        })
    
    def average_engagement(self):
        return sum(p['engagement'] for p in self.posts) / len(self.posts)

# Usage
tracker = EngagementTracker()
tracker.add_post(100, 20, 5)
tracker.add_post(150, 30, 10)
print(f"Average: {tracker.average_engagement()}")
```

## 3.9 Best Time to Post
```python
# Analyze best posting times
posting_times = {
    'Monday': {'9am': 50, '12pm': 80, '6pm': 100},
    'Tuesday': {'9am': 60, '12pm': 90, '6pm': 110},
    # ... more data
}

def best_time_to_post():
    best = {'day': '', 'time': '', 'score': 0}
    for day, times in posting_times.items():
        for time, score in times.items():
            if score > best['score']:
                best = {'day': day, 'time': time, 'score': score}
    return best

print(best_time_to_post())
```

## 3.10 Content Ideas Generator
```python
import random

content_types = ['video', 'carousel', 'story', 'reel', 'post']
topics = ['tutorial', 'behind scenes', 'tips', 'qa', 'collaboration']
hooks = ['Did you know?', 'Here\'s how...', '5 tips for...', 'The truth about...']

def generate_content_ideas(count=10):
    ideas = []
    for _ in range(count):
        idea = {
            'type': random.choice(content_types),
            'topic': random.choice(topics),
            'hook': random.choice(hooks)
        }
        ideas.append(idea)
    return ideas

for idea in generate_content_ideas(5):
    print(f"{idea['hook']} ({idea['type']})")
```

---

# CHAPTER 4: DATA PROCESSING

## 4.1 CSV to JSON
```python
import csv
import json

csv_file = 'data.csv'
json_file = 'data.json'

data = []
with open(csv_file, 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        data.append(row)

with open(json_file, 'w') as f:
    json.dump(data, f, indent=2)

print("Converted!")
```

## 4.2 Excel to CSV
```python
import pandas as pd

excel_file = 'data.xlsx'
csv_file = 'data.csv'

df = pd.read_excel(excel_file)
df.to_csv(csv_file, index=False)

print("Converted!")
```

## 4.3 Data Cleaning
```python
import pandas as pd

df = pd.read_csv('dirty_data.csv')

# Clean data
df['email'] = df['email'].str.lower().str.strip()
df['phone'] = df['phone'].str.replace(r'\D', '', regex=True)
df['name'] = df['name'].str.title()
df = df.dropna()

df.to_csv('clean_data.csv', index=False)
print("Cleaned!")
```

## 4.4 Duplicate Remover
```python
import pandas as pd

df = pd.read_csv('data.csv')
print(f"Before: {len(df)} rows")

df = df.drop_duplicates()
print(f"After: {len(df)} rows")

df.to_csv('unique_data.csv', index=False)
```

## 4.5 Data Aggregator
```python
import pandas as pd

df = pd.read_csv('sales.csv')

# Group and aggregate
summary = df.groupby('category').agg({
    'sales': 'sum',
    'quantity': 'mean',
    'customer': 'nunique'
}).reset_index()

summary.to_csv('summary.csv', index=False)
print("Aggregated!")
```

## 4.6 JSON to CSV
```python
import json
import csv

with open('data.json', 'r') as f:
    data = json.load(f)

if data:
    with open('data.csv', 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)

print("Converted!")
```

## 4.7 Filter Data
```python
import pandas as pd

df = pd.read_csv('data.csv')

# Filter by condition
filtered = df[df['age'] > 25]
filtered = filtered[filtered['city'] == 'Seoul']

filtered.to_csv('filtered.csv', index=False)
print(f"Filtered {len(filtered)} rows")
```

## 4.8 Merge DataFrames
```python
import pandas as pd

df1 = pd.read_csv('file1.csv')
df2 = pd.read_csv('file2.csv')

merged = pd.merge(df1, df2, on='id', how='inner')
merged.to_csv('merged.csv', index=False)

print(f"Merged {len(merged)} rows")
```

## 4.9 Statistical Analysis
```python
import pandas as pd
import numpy as np

df = pd.read_csv('data.csv')

stats = {
    'mean': df['value'].mean(),
    'median': df['value'].median(),
    'std': df['value'].std(),
    'min': df['value'].min(),
    'max': df['value'].max()
}

for k, v in stats.items():
    print(f"{k}: {v:.2f}")
```

## 4.10 Data Validation
```python
import pandas as pd

df = pd.read_csv('data.csv')

errors = []

# Check required columns
required = ['email', 'phone', 'name']
for col in required:
    if col not in df.columns:
        errors.append(f"Missing column: {col}")

# Check email format
if 'email' in df.columns:
    invalid_emails = df[~df['email'].str.contains('@', na=False)]
    if len(invalid_emails) > 0:
        errors.append(f"Invalid emails: {len(invalid_emails)}")

if errors:
    print("Errors found:", errors)
else:
    print("Data is valid!")
```

---

# CHAPTER 5: EMAIL AUTOMATION

## 5.1 Send Email
```python
import smtplib
from email.mime.text import MIMEText

msg = MIMEText("Hello from Python!")
msg['Subject'] = "Test Email"
msg['From'] = "your@email.com"
msg['To'] = "recipient@email.com"

with smtplib.SMTP('smtp.gmail.com', 587) as server:
    server.starttls()
    server.login("your@email.com", "password")
    server.send_message(msg)

print("Sent!")
```

## 5.2 Email Newsletter Template
```python
def create_newsletter(title, sections):
    html = f"""
    <html>
    <body>
        <h1>{title}</h1>
        {"".join(f"<h2>{s['title']}</h2><p>{s['content']}</p>" for s in sections)}
        <hr>
        <p>Thanks for reading!</p>
    </body>
    </html>
    """
    return html

# Usage
newsletter = create_newsletter("Weekly Update", [
    {'title': 'News', 'content': 'Something happened'},
    {'title': 'Tips', 'content': 'Do this thing'}
])
```

## 5.3 Auto-Response
```python
# Simple auto-responder
def auto_response(email):
    subject = email['subject'].lower()
    
    responses = {
        'support': 'We\'ll help you soon!',
        'sales': 'Thanks for your interest!',
        'default': 'Thanks for reaching out!'
    }
    
    for key in responses:
        if key in subject:
            return responses[key]
    return responses['default']
```

## 5.4 Email Parser
```python
import email

def parse_email(raw_email):
    msg = email.message_from_string(raw_email)
    return {
        'from': msg['from'],
        'to': msg['to'],
        'subject': msg['subject'],
        'body': msg.get_payload()
    }

# Usage
# parsed = parse_email(raw_email_string)
```

## 5.5 Bulk Email Sender (Template)
```python
import smtplib
from email.mime.text import MIMEText

def send_bulk_emails(recipients, subject, body):
    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()
        server.login("your@email.com", "password")
        
        for email in recipients:
            msg = MIMEText(body)
            msg['Subject'] = subject
            msg['From'] = "your@email.com"
            msg['To'] = email
            server.send_message(msg)
    
    print(f"Sent to {len(recipients)} recipients")

# Usage
# send_bulk_emails(['a@test.com', 'b@test.com'], "Hi", "Hello!")
```

---

# CHAPTER 6: IMAGE PROCESSING

## 6.1 Resize Images
```python
from PIL import Image
import os

def resize_images(folder, size=(800, 600)):
    for file in os.listdir(folder):
        if file.endswith(('.jpg', '.png')):
            img = Image.open(os.path.join(folder, file))
            img.thumbnail(size)
            img.save(f"resized_{file}")

resize_images('images/')
```

## 6.2 Convert to Grayscale
```python
from PIL import Image

img = Image.open('photo.jpg')
gray = img.convert('L')
gray.save('photo_gray.jpg')
```

## 6.3 Image Compression
```python
from PIL import Image

img = Image.open('photo.jpg')
img.save('photo_compressed.jpg', optimize=True, quality=60)
```

## 6.4 Create Thumbnail
```python
from PIL import Image

img = Image.open('photo.jpg')
img.thumbnail((200, 200))
img.save('thumbnail.jpg')
```

## 6.5 Watermark
```python
from PIL import Image, ImageDraw, ImageFont

img = Image.open('photo.jpg')
draw = ImageDraw.Draw(img)
draw.text((10, 10), "© Your Name", fill=(255, 255, 255))
img.save('watermarked.jpg')
```

---

💰 **Price**: Free (Support appreciated)
