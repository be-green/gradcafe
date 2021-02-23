# generate links

library(rvest)
library(magrittr)
library(purrr)
library(data.table)

# following suggestions here:
# https://stackoverflow.com/questions/56118999/issue-scraping-page-with-load-more-button-with-rvest

# Download binaries, start driver, and get client object.
rd <- rsDriver(browser = "firefox", port = 3333L)
ffd <- rd$client

site <- "https://www.thegradcafe.com/"

all_tables <- list()

for(i in 1:1830) {

  page <- paste0(site, "/survey/index.php?q=Economics&t=a&o=&p=", i)

  all_tables[[i]] <- read_html(page) %>%
    html_table() %>%
    .[[1]]

}

rbindlist(all_tables) %>%
  fwrite("data/gradcafe-data.csv")



