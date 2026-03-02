# Report: Monitoring Suspicious News on Social Media

Date:
Prepared By: Md. Saiful Islam, EIN-496, Senior Executive, MIS & Development

## Objective

Track suspicious news across social media platforms to ensure timely awareness and mitigation of misinformation/disinformation.

## Facebook and Instagram

- Monitor public posts on Facebook, Instagram, and Threads.

### Option 1: Facebook Graph API (Official)

- Official API provided by Meta.
- Requires a Meta Developer account and App review approval.
- Features: Retrieves posts, comments, reactions, and insights.
- Use Case: Monitoring your own organization’s or partner-managed content.
- Pricing: Free.
- Limitations:
  - Restricted scope; approval process can be strict.
  - Access limited to Pages and Groups you own or manage (no broad access to all public posts).

🔗 [Graph API Docs](https://developers.facebook.com/docs/graph-api)

### Option 2: Meta Content Library & API (Replaced CrowdTangle in 2024)

- Provides access to public content across Facebook, Instagram, and Threads.
- Advanced search (keywords, filters, OCR), trend analysis, CSV exports, and dashboards.
- Use Case: Large-scale research into misinformation/disinformation, social trends, and public discourse.
- Pricing: Free of charge.
- Limitations:
  - Data accessible only in secure environments (Meta’s Secure Research Environment or SOMAR enclave).
  - Access limited to approved academic/non-profit researchers (applications reviewed by ICPSR).
  - Not available for general developers; requires institutional approval.
  - Rate Limits: Up to 500,000 content items per week (includes CSV and UI exports).

🔗 [Meta Content Library](https://transparency.meta.com/en-gb/researchtools/meta-content-library/)

## Twitter (X)

- Collect tweets using keywords; track engagement metrics (likes, retweets, quotes, impressions).

### Option 1: Twitter API v2

- Official, reliable API provided by Twitter.
- Requires a Twitter Developer Account and API keys.
- Use Case: Best for production use where trusted engagement data and streaming access are essential.
- Pricing & Tiers:

  - Free – Highly limited (~100 posts/month).
  - Basic ($100/month) – ~10,000 reads + 50,000 writes/month.
  - Pro ($5,000/month) – Up to 1,000,000 reads/month, full-archive search, filtered streaming.
  - Enterprise ($42,000+/month) – High-volume, commercial/research-scale access.

- Limitations:
  - Free tier is very restricted; full archive requires Pro/Enterprise.

🔗 [Twitter API v2 Docs](https://developer.twitter.com/en/docs/twitter-api)

### Option 2: snscrape (Unofficial, Scraper)

- Open-source library; no API key required.
- Collects public tweets, including historical ones.
- Use Case: Best For quick prototyping, academic projects, or when API access is limited.
- Pricing: Free.
- Limitations:

  - Only works for public accounts (not protected).
  - Engagement metrics (likes/retweets) may lag behind real-time accuracy.
  - Can break if Twitter changes its frontend.


🔗 [snscrape GitHub](https://github.com/JustAnotherArchivist/snscrape)

## Google News & Fact-Checking

- Monitor news articles and fact-checks across trusted sources.

### Option 1: Google Trends

- Official Google tool to analyze search interest over time.
- Helps detect spikes in topics and track emerging narratives.
- Supports region-based and time-based filtering.
- Use Case: Identifying when misinformation/disinformation topics are trending.
- Pricing: Free.
- Limitations: Only shows search interest trends, not specific articles.

🔗 [Google Trends](https://trends.google.com)

### Option 2: Google Fact Check Tools / API

- Access to fact-check articles from verified fact-checking organizations.
- Fact Check Explorer lets you search claims and see published fact-checks.
- Fact Check Tools API enables integration into automated pipelines.
- Use Case: Validating claims and enriching misinformation/disinformation datasets with fact-check results.
- Pricing: Free.
- Limitations: Coverage limited to fact-checked claims available in Google’s database.

🔗 [Google Fact Check Explorer](https://toolbox.google.com/factcheck/explorer)

### Option 3: Google News RSS

- Provides RSS feeds for the latest articles on given keywords (e.g., “fake news”, “hoax”).
- Can be integrated into automated pipelines for content collection.
- Use Case: Real-time monitoring of news coverage across multiple outlets.
- Limitations: Only metadata and links are retrieved; article scraping may need additional steps.
- Pricing: Free.

🔗 [Google News RSS](https://news.google.com/rss)

## YouTube

- Monitor video content for misinformation/disinformation, authenticity, and virality.

### Option 1: YouTube Data API (Official)

- Official API provided by Google.
- Requires a Google Cloud project and API key.
- Retrieve video metadata, channel details, comments, and engagement (views, likes).
- Use Case: Analyzing how misinformation/disinformation videos spread and measuring engagement.
- Pricing: Free tier includes 10,000 units/day (basic requests = 1 unit; video searches = 100 units). Extra quota can be requested but may require justification.
- Limitations: 
   - Strict quota system; does not give full video transcripts or internal ranking signals.


🔗 [YouTube Data API Docs](https://developers.google.com/youtube/v3)

### Option 2: InVID Verification Plugin (Third-Party Tool)

- Browser plugin developed with EU funding to verify online videos.
- Features:
  - Keyframe analysis (breaks video into stills for reverse image search).
  - Metadata extraction (upload time, geolocation hints).
  - Forensic filters (detect tampering in images).
  - Integration with fact-checking databases.
- Use Case: Investigating potentially manipulated videos, verifying channel authenticity.
- Limitations: Manual tool, not API-based; best for journalistic workflows.
- Pricing: Free.

🔗 [InVID Verification Plugin](https://www.invid-project.eu/tools-and-services/invid-verification-plugin/)

## Proposed Process (Sample)

![alt text](image.png)

1. Data Collection:

   - Fetch posts from Google News, Twitter, Facebook/Instagram (CrowdTangle), and YouTube.
   - Filter using keywords like fake, hoax, misinformation,disinformation.
   - Collect metadata: platform, source, title/message, link, date, engagement.

2. Validation:

   - Check claims via Google Fact Check API or trusted fact-checking websites.
   - Use Google Trends to identify viral or emerging topics.

3. Storage:

   - Save data in CSV/JSON with key fields: platform, source, message, link, date, engagement, suspicious flag, fact-check flag.

4. Analysis & Reporting:

   - Flag suspicious posts; optionally apply NLP/ML for credibility scoring.
   - Generate daily/weekly reports highlighting top posts and high-engagement sources.

5. Automation:

   - Schedule pipeline using cron jobs or workflow schedulers.
   - Trigger alerts for posts exceeding engagement thresholds.

## Next Steps

- Continue monitoring top pages/channels with high engagement.
- Update keyword list weekly for emerging misinformation/disinformation trends.
- Integrate NLP or automated credibility scoring for faster analysis.
- Trigger alerts for viral posts flagged as suspicious.
