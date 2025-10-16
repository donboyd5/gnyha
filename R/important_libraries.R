# --- Set display options ---
tprint <- 75 # default tibble print
options(tibble.print_max = tprint, tibble.print_min = tprint)

# --- Development tools ---
# install.packages("pak")
# pak::pak("r-lib/devtools")
# pak::pak("r-lib/usethis")
# pak::pak("r-lib/testthat")
# pak::pak("r-lib/rlang")
# pak::pak("r-lib/here")
# pak::pak("r-lib/rprojroot")
# remotes::install_github("ArcadeAntics/this.path")
library(rlang)
library(pak)
library(remotes)
library(devtools)
library(here)
library(rprojroot)
library(this.path)
library(usethis)
library(testthat)
library(pkgload)
library(lintr)
library(styler)

# --- Core tidyverse and data manipulation ---
library(tidyverse)
library(dplyr) # dplyr functions included with tidyverse, only if specifically loaded elsewhere
# remotes::install_github("JanMarvin/openxlsx2")
library(openxlsx2) # for writing xlsx files
library(readxl)
library(vroom)
library(fs)
library(skimr)
library(Hmisc)
library(lubridate)
library(formattable)
library(janitor)
library(vtable)
library(quarto)

# --- Time series and forecasting ---
# https://robjhyndman.com/software/](https://robjhyndman.com/software/
# https://tidyverts.org/
library(zoo)
library(forecast)
library(tsibble)
library(feasts)
library(fable)
library(fabletools)
library(RcppRoll)
library(slider)
library(tsibbledata)
library(fable.prophet)

# --- Graphics & visualization ---
library(RColorBrewer)
library(scales)
library(ggbeeswarm)
library(patchwork)
library(gridExtra)
library(ggrepel)
library(ggbreak)

# --- Tables ---
library(knitr)
library(kableExtra)
library(DT)
library(gt)
library(gtExtras)

# --- Mapping ---
library(maps)
# [https://cran.r-project.org/web/packages/usmap/vignettes/mapping.html](https://cran.r-project.org/web/packages/usmap/vignettes/mapping.html)
library(usmap)

# --- API and census ---
library(fredr)
library(tidycensus)

# --- Boyd libraries (install from github/donboyd5) ---
library(btools)
# library(bdata)
# library(bggtools)
# library(bmaps)

# --- Commented/optional packages ---
