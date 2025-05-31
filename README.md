---
output: github_document
---

# Purpose

This is a package for UW BIOST 561 (Spring 2025), taught by Kevin Lin.
The package includes functions that is designed to generate partial cliques and determine partial clique size.

- The URL to the GitHub (i.e., the source code) is: https://github.com/Meng-Yung/UWBiost561
- The URL to the Pkgdown webpage is: https://meng-yung.github.io/UWBiost561/

# How to install
This package is called `UWBiost561`. To install, run the following code (in R):

```R
library(devtools)
devtools::install_github("Meng-Yung/UWBiost561")
```

Upon completion, you can run the following code (in R):
```R
library(UWBiost561)
```

# Dependencies

The package suggests on the following packages: "knitr", "rmarkdown", "bookdown", "tidyverse", "ggplot2", and "testthat".

# Session info

This package was developed in the following environment
```R
> devtools::session_info()
─ Session info ──────────────────────────
 setting  value
 version  R version 4.5.0 (2025-04-11 ucrt)
 os       Windows 11 x64 (build 26100)
 system   x86_64, mingw32
 ui       RStudio
 language (EN)
 collate  English_United States.utf8
 ctype    English_United States.utf8
 tz       America/Los_Angeles
 date     2025-05-30
 rstudio  2025.05.0+496 Mariposa Orchid (desktop)
 pandoc   3.4 @ D:/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown)
 quarto   ERROR: Unknown command "TMPDIR=C:/Users/Michael/AppData/Local/Temp/RtmpcliMgZ/file1edc3b3259fd". Did you mean command "create"? @ D:\\RStudio\\resources\\app\\bin\\quarto\\bin\\quarto.exe

─ Packages ──────────────────────────────
 package     * version date (UTC) lib source
 bookdown      0.43    2025-04-15 [1] CRAN (R 4.5.0)
 cachem        1.1.0   2024-05-16 [1] CRAN (R 4.5.0)
 callr         3.7.6   2024-03-25 [1] CRAN (R 4.5.0)
 cli           3.6.5   2025-04-23 [1] CRAN (R 4.5.0)
 desc          1.4.3   2023-12-10 [1] CRAN (R 4.5.0)
 devtools      2.4.5   2022-10-11 [1] CRAN (R 4.5.0)
 digest        0.6.37  2024-08-19 [1] CRAN (R 4.5.0)
 ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.5.0)
 evaluate      1.0.3   2025-01-10 [1] CRAN (R 4.5.0)
 fastmap       1.2.0   2024-05-15 [1] CRAN (R 4.5.0)
 fs            1.6.6   2025-04-12 [1] CRAN (R 4.5.0)
 glue          1.8.0   2024-09-30 [1] CRAN (R 4.5.0)
 htmltools     0.5.8.1 2024-04-04 [1] CRAN (R 4.5.0)
 htmlwidgets   1.6.4   2023-12-06 [1] CRAN (R 4.5.0)
 httpuv        1.6.16  2025-04-16 [1] CRAN (R 4.5.0)
 knitr         1.50    2025-03-16 [1] CRAN (R 4.5.0)
 later         1.4.2   2025-04-08 [1] CRAN (R 4.5.0)
 lifecycle     1.0.4   2023-11-07 [1] CRAN (R 4.5.0)
 magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.5.0)
 memoise       2.0.1   2021-11-26 [1] CRAN (R 4.5.0)
 mime          0.13    2025-03-17 [1] CRAN (R 4.5.0)
 miniUI        0.1.2   2025-04-17 [1] CRAN (R 4.5.0)
 pillar        1.10.2  2025-04-05 [1] CRAN (R 4.5.0)
 pkgbuild      1.4.8   2025-05-26 [1] CRAN (R 4.5.0)
 pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.5.0)
 pkgdown       2.1.3   2025-05-25 [1] CRAN (R 4.5.0)
 pkgload       1.4.0   2024-06-28 [1] CRAN (R 4.5.0)
 processx      3.8.6   2025-02-21 [1] CRAN (R 4.5.0)
 profvis       0.4.0   2024-09-20 [1] CRAN (R 4.5.0)
 promises      1.3.2   2024-11-28 [1] CRAN (R 4.5.0)
 ps            1.9.1   2025-04-12 [1] CRAN (R 4.5.0)
 purrr         1.0.4   2025-02-05 [1] CRAN (R 4.5.0)
 R6            2.6.1   2025-02-15 [1] CRAN (R 4.5.0)
 Rcpp          1.0.14  2025-01-12 [1] CRAN (R 4.5.0)
 remotes       2.5.0   2024-03-17 [1] CRAN (R 4.5.0)
 rlang         1.1.6   2025-04-11 [1] CRAN (R 4.5.0)
 rmarkdown     2.29    2024-11-04 [1] CRAN (R 4.5.0)
 rstudioapi    0.17.1  2024-10-22 [1] CRAN (R 4.5.0)
 sessioninfo   1.2.3   2025-02-05 [1] CRAN (R 4.5.0)
 shiny         1.10.0  2024-12-14 [1] CRAN (R 4.5.0)
 tibble        3.2.1   2023-03-20 [1] CRAN (R 4.5.0)
 urlchecker    1.0.1   2021-11-30 [1] CRAN (R 4.5.0)
 usethis       3.1.0   2024-11-26 [1] CRAN (R 4.5.0)
 vctrs         0.6.5   2023-12-01 [1] CRAN (R 4.5.0)
 withr         3.0.2   2024-10-28 [1] CRAN (R 4.5.0)
 xfun          0.52    2025-04-02 [1] CRAN (R 4.5.0)
 xtable        1.8-4   2019-04-21 [1] CRAN (R 4.5.0)
 yaml          2.3.10  2024-07-26 [1] CRAN (R 4.5.0)

 [1] D:/R-4.5.0/library
```