// Some definitions presupposed by pandoc's typst output.
#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subrefnumbering: "1a",
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => numbering(subrefnumbering, n-super, quartosubfloatcounter.get().first() + 1))
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}

// Used to collect sidebar articles.
#let articles = state("articles", ())

// This function gets your whole document as its `body` and formats
// it as the fun newsletter of a college department.
#let dept-news(
  // The newsletter's title.
  title: "Newsletter title",

  // The edition, displayed at the top of the sidebar.
  edition: none,

  // A hero image at the start of the newsletter. If given, should be a
  // dictionary with two keys: A `path` to an image file and a `caption`
  // that is displayed to the right of the image.
  hero-image: none,

  // Details about the publication, displayed at the end of the document.
  publication-info: none,

  // The newsletter's content.
  body
) = {
  // Set document metadata.
  set document(title: title)

  // Configure pages. The background parameter is used to
  // add the right background to the pages.
  set page(
    margin: (left: 2.5cm, right: 1.6cm),
    background: place(right + top, rect(
      fill: red,
      height: 100%,
      width: 7.8cm,
    ))
  )

  // Set the body font.
  set text(12pt, font: "Barlow")

  // Configure headings.
  show heading: set text(font: "Syne")
  show heading.where(level: 1): set text(1.1em)
  show heading.where(level: 1): set par(leading: 0.4em)
  show heading.where(level: 1): set block(below: 0.8em)
  show heading: it => {
    set text(weight: 600) if it.level > 2
    it
  }

  // Links should be underlined.
  show link: underline

  // Configure figures.
  show figure: it => block({
    // Display a backdrop rectangle.
    move(dx: -3%, dy: 1.5%, rect(
      fill: rgb("FF7D79"),
      inset: 0pt,
      move(dx: 3%, dy: -1.5%, it.body)
    ))

    // Display caption.
    if it.has("caption") {
      set align(center)
      set text(font: "Syne")
      v(if it.has("gap") { it.gap } else { 24pt }, weak: true)
      if it.supplement != none and it.numbering != none {
        [#it.supplement #counter(figure).display(it.numbering): ]
      }
      it.caption
    }

    v(48pt, weak: true)
  })

  // The document is split in two with a grid. A left column for the main
  // flow and a right column for the sidebar articles.
  grid(
    columns: (1fr, 7.8cm - 1.6cm - 18pt),
    column-gutter: 36pt,
    row-gutter: 32pt,

    // Title.
    text(font: "Syne", 23pt, weight: 800, upper(title)),

    // Edition.
    text(fill: white, weight: "medium", 14pt, align(right + bottom, edition)),

    // Hero image.
    style(styles => {
      if hero-image == none {
        return
      }

      // Measure the image and text to find out the correct line width.
      // The line should always fill the remaining space next to the image.
      let img = image(hero-image.path, width: 14cm)
      let text = text(size: 25pt, fill: white, font: "Syne Tactile", hero-image.caption)
      let img-size = measure(img, styles)
      let text-width = measure(text, styles).width + 12pt
      let line-length = img-size.height - text-width

      grid(
        columns: (img-size.width, 1cm),
        column-gutter: 16pt,
        rows: img-size.height,
        img,
        grid(
          rows: (text-width, 1fr),
          move(dx: 11pt, rotate(
            90deg,
            origin: top + left,
            box(width: text-width, text)
          )),
          line(angle: 90deg, length: line-length, stroke: 3pt + white),
        ),
      )
    }),

    // Nothing next to the hero image.
    none,

    // The main flow with body and publication info.
    {
      set par(justify: true)
      body
      v(1fr)
      set text(0.7em)
      publication-info
    },

    // The sidebar with articles.
    locate(loc => {
      set text(fill: white, weight: 500)
      show heading: underline.with(stroke: 2pt, offset: 4pt)
      v(44pt)
      for element in articles.final(loc) {
        element
        v(24pt, weak: true)
      }
    }),
  )
}

// A stylized block with a quote and its author.
#let blockquote(body) = box(inset: (x: 0.4em, y: 12pt), width: 100%, {
  set text(font: "Syne")
  grid(
    columns: (1em, auto, 1em),
    column-gutter: 12pt,
    rows: (1em, auto),
    row-gutter: 8pt,
    text(5em)["],
    line(start: (0pt, 0.45em), length: 100%),
    none, none,
    text(1.4em, align(center, body)),
    none, none
  )
})


// An article that is displayed in the sidebar. Can be added
// anywhere in the document. All articles are collected automatically.
#let article(body) = articles.update(it => it + (body,))

#set page(
  paper: "us-letter",
  margin: (x: 1.25in, y: 1.25in),
  numbering: "1",
)

#show: dept-news.with(
  title: "Chemistry Department",
  edition: [March 18th, 2023 \
Purview College

],
  hero-image: (
    path: "newsletter-cover.jpg",
    caption: [Award winning science]
  ), 
  publication-info: [The Dean of the Department of Chemistry. \
Purview College, 17 Earlmeyer D, Exampleville, TN 59341. \
#link("mailto:newsletter@chem.purview.edu")

],
)


= The Sixtus Award goes to Purview
<the-sixtus-award-goes-to-purview>
It's our pleasure to announce that our department has recently been awarded the highly-coveted Sixtus Award for Excellence in Chemical Research. This is a massive achievement for our department, and we couldn't be prouder.

#quote(block: true)[
Our Lab has synthesized the most elements of them all. \
--- Prof.~Herzog
]

The Sixtus Award is a prestigious recognition given to institutions that have demonstrated exceptional performance in chemical research. The award is named after the renowned chemist Sixtus Leung, who made significant contributions to the field of organic chemistry.

This achievement is a testament to the hard work, dedication, and passion of our faculty, students, and staff. Our department has consistently produced groundbreaking research that has contributed to the advancement of the field of chemistry, and we're honored to receive this recognition.

The award will be presented to our department in a formal ceremony that will take place on May 15th, 2023. We encourage all members of our department to join us in celebrating this achievement.

#article[
== Guest lecture from Dr.~Elizabeth Lee
<guest-lecture-from-dr.-elizabeth-lee>
Elizabeth Lee, a leading researcher in the field of biochemistry, spoke about her recent work on the development of new cancer treatments using small molecule inhibitors, and the lecture was very well-attended by both students and faculty.

In case you missed it, there's a recording on #link("http://purview.edu/lts/2023-lee%22")[EDGARP]

]
#article[
== Safety first
<safety-first>
Next Tuesday, there will be a Lab Safety Training.

These trainings are crucial for ensuring that all members of the department are equipped with the necessary knowledge and skills to work safely in the laboratory. #emph[Attendance is mandatory.]

]
== Another Success
<another-success>
Aliquam sit amet lectus ut libero congue viverra. Morbi quis diam ullamcorper, iaculis ex non, fermentum mauris. Aliquam consectetur vitae purus vitae laoreet. Sed elementum ligula et mauris eleifend dignissim.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultrices, dolor molestie viverra interdum, nibh urna dignissim nisi, et rhoncus libero nibh a nulla. Etiam ac augue vel leo vehicula finibus at non tortor.
