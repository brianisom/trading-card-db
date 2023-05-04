#####################################
# Build individual card set databases
#####################################

# add packages
library(data.table)
library(tidyverse)
library(readxl)
library(openxlsx2)

# load checklist
doc <-  # .xlsx document name
sub_f <- # subfolder where .xlsx file is stored
doc_path <- paste0(sport,doc) # combine to create the file path
db <- read_xlsx(doc_path)

# add additional data columns
db_mod <- cbind(year = "2021-22",
                company = "Panini",
                set = "Illusions",
                sport = "basketball",
                db,
                own = 0)

# generate a link to completed eBay listings for each card
db_mod$url <- gsub(" ","+",paste0(
  "https://www.ebay.com/sch/i.html?_from=R40&_nkw=",
  db_mod$year,"+",
  db_mod$company,"+",
  db_mod$set,"+",
  db_mod$variation,"+",
  db_mod$name,
  "&_sacat=0&LH_TitleDesc=0&LH_Complete=1&LH_Sold=1&rt=nc&LH_Auction=1"
  )
)

# replace the .xlsx file with the newly modified version
write_xlsx(db_mod,doc_path)
