def create_scrape_time(source, last_scrape_at, inter_scrape_delay)
  ScrapeTime.create(source: source,
                    last_scrape_at: last_scrape_at,
                    inter_scrape_delay: inter_scrape_delay)
end
