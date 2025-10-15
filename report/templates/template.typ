// Set default text appearance (use Typst default if custom font is not needed)
#set text(12pt)

// Global page setup with footer
#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
  footer: context {
    line(length: 100%, stroke: 0.5pt + gray)
    grid(
      columns: (25%, 50%, 25%),
      align: (left + horizon, center + horizon, right + horizon),
      gutter: 1em,
      [Left text],
      [Center text],
      [#image("boydLogo.jpg", width: 80pt)]
    )
  }
)
