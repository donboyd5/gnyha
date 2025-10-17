# install.packages(c("readr", "stringi"))

# usage:

# make_typst_table(
#   csv_path = "table.csv",
#   typ_path = "mytable.typ",
#   title = "Descriptive table title (optional)",
#   align = c("left","right","right","right","right") # or NULL to auto
# )

#  #include "mytable.typ"

make_typst_table <- function(
  # per chatGPT:
  # R function that reads a CSV (robust to quoted commas/quotes/newlines), escapes Typst-special characters, and writes a .typ include
  csv_path,
  typ_path = "table_from_csv.typ",
  title = NULL,
  align = NULL,
  header_bold = TRUE,
  inset_pt = 6,
  stroke = "0.6pt + luma(180)"
) {
  library(readr)
  library(stringi)

  df <- readr::read_csv(
    csv_path,
    col_types = readr::cols(.default = readr::col_character())
  )
  df[is.na(df)] <- ""

  # Escape content for Typst [ ... ] cells
  esc <- function(x) {
    x <- stri_replace_all_fixed(x, "\\", "\\\\")
    x <- stri_replace_all_fixed(x, "]", "\\]")
    x <- stri_replace_all_fixed(x, "[", "\\[")
    x <- stri_replace_all_fixed(x, "#", "\\#")
    x <- stri_replace_all_fixed(x, "&", "\\&")
    x
  }

  # Infer alignment if not supplied: left for first col, right for numeric-like others
  if (is.null(align)) {
    is_numeric_like <- function(v) {
      v <- trimws(v)
      v <- v[v != ""]
      if (!length(v)) {
        return(FALSE)
      }
      v <- gsub("[,%\\s()]", "", v)
      suppressWarnings(all(!is.na(as.numeric(v))))
    }
    align <- sapply(seq_along(df), function(i) {
      if (i == 1) {
        "left"
      } else if (is_numeric_like(df[[i]])) {
        "right"
      } else {
        "left"
      }
    })
  }
  stopifnot(length(align) == ncol(df))

  # Build Typst
  lines <- c()
  lines <- c(lines, "#table(")
  lines <- c(lines, sprintf("  columns: %d,", ncol(df)))
  lines <- c(lines, sprintf("  align: (%s),", paste(align, collapse = ", ")))
  lines <- c(lines, sprintf("  inset: %dpt,", inset_pt))
  lines <- c(lines, sprintf("  stroke: %s,", stroke))

  if (!is.null(title) && nzchar(title)) {
    lines <- c(
      lines,
      sprintf("  table.cell(colspan: %d)[#strong[%s]],", ncol(df), esc(title))
    )
  } else {
    lines <- c(
      lines,
      "  // table.cell(colspan: %d)[#strong[Your table title here]],"
    )
  }

  # Header row
  hdr <- names(df)
  if (header_bold) {
    hdr <- sprintf("#strong[%s]", esc(hdr))
  } else {
    hdr <- sprintf("%s", esc(hdr))
  }
  lines <- c(
    lines,
    paste0("  ", paste(sprintf("[%s]", hdr), collapse = " & "), ",")
  )

  # Data rows
  for (i in seq_len(nrow(df))) {
    row <- df[i, , drop = FALSE]
    cells <- sprintf("[%s]", esc(as.character(row[1, ])))
    lines <- c(lines, paste0("  ", paste(cells, collapse = " & "), ","))
  }

  lines <- c(lines, ")")
  writeLines(lines, typ_path, useBytes = TRUE)
  message("Wrote: ", normalizePath(typ_path))
}
