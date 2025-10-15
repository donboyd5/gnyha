// front-matter.typ
#let with_frontmatter(body) = [
  // ---- COVER (single column) ----
  #set page(columns: 1)

  #place(top + center, dy: 35%)[
    #align(center)[
      #text(size: 22pt, weight: "bold")[
        The Impact of Post-2024 Federal Income Tax Changes on Hospital Workers in New York
      ]
      #v(14pt)
      #text(size: 12pt)[Don Boyd]
      #v(4pt)
      #text(size: 12pt)[Boyd Research, LLC]
    ]
  ]

  #pagebreak()

  // ---- TOC (single column) ----
  #set page(columns: 1)

  #align(center)[#text(size: 16pt, weight: "semibold")[Contents]]
  #v(10pt)
  #outline(depth: 3)   // ← no target; uses document headings

  #pagebreak()

  // ---- BODY (restore two columns) ----
  #set page(columns: 2)

  // Emit the original document body
  body
]

// Apply at the document root (legal place for page config)
#show: document => with_frontmatter(document)
