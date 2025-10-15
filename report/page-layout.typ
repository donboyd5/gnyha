// page-layout.typ
#set page(
  margin: (x: 1.25in, y: 1.25in),  
  footer: context [
    #grid(
      columns: (auto, 1fr, auto),   
      gutter: 0pt,
      align: center + horizon,
      [
        #image("assets/boydLogo.svg", width: 2.3in)
      ],
      [ ],
      [
        #set text(10pt)
        #counter(page).display()     
      ]
    )
  ]
)

// Title page template
#let title-page(doc-title, doc-author, doc-affiliation) = {
  set page(columns: 1)
  set text(size: 20pt, weight: "bold")
  align(center)[#doc-title]
  
  v(0.5em)
  set text(size: 18pt, weight: "regular")
  align(center)[#doc-author]
  
  // Removed v() spacing here - author and affiliation will be adjacent
  set text(size: 14pt, weight: "regular")
  align(center)[#doc-affiliation]
  
  v(0.5em)
  set text(size: 12pt, weight: "regular")
  align(center)[#datetime.today().display("[month repr:long] [day], [year]")]
  
  pagebreak()
}


// Table of contents page template
#let toc-page() = {
  set page(columns: 1)
  set text(size: 18pt, weight: "bold")
  align(center)[Contents]
  
  v(1em)
  set text(size: 12pt, weight: "regular")
  outline(
    title: none,
    indent: 1.5em,
    depth: 3
  )
  
  pagebreak()
}