#import "@preview/linguify:0.4.2": *

#let abstract-state = state("abstract", none)
#let abstract-foreign-state = state("abstract-foreign", none)
#let appendices-state = state("article-appendices", ())
#let annexes-state = state("article-annexes", ())

#let template(
  title: none,
  title-foreign: none,
  
  author: none,
  city: none,
  year: none,

  description: none,

  keywords: none,
  keywords-foreign: none,
  
  lang: "pt",
  lang-foreign: "en",

  outline-figure: false,
  outline-table: false,

  abbreviations: none,
  symbols: none,
  
  body,
) = {
  
// ===============================================
// Languages Settings
// ===============================================
let lang-data = toml("assets/lang.toml")
set-database(lang-data)
set text(lang: lang)

// ===============================================
// Page
// ===============================================
set page(
  margin: (left: 3cm, right: 2cm, top: 3cm, bottom: 2cm),
  number-align: top+right,
)

{// This stops the tcc formatting leaking to extra content

// ===============================================
// Normal Text
// ===============================================
set par(
  justify: true, 
  first-line-indent: (amount: 1.5cm, all: true),
  leading: 1.0em,
  spacing: 1.0em,
)
set text(size: 12pt)
set underline(offset: 0.2em, evade: false, extent: 0.08em)

// ===============================================
// Headings
// ===============================================
set heading(numbering: "1.1")
show heading : it =>{
  set text(
    size:12pt,
    weight: if it.level < 3 {700} else {0}
  )
  if it.level == 1 {pagebreak();upper(it)}
  else if it.level == 4 {underline(it)}
  else if it.level == 5 {emph(it)}
  else {it}
}

// ===============================================
// Figures
// ===============================================
set figure.caption(position: top,separator: " - ")
show figure: set text(size: 10pt)
show figure.caption: set text(size: 10pt, weight: 700)
show figure.caption: set par(spacing: 0.5em, leading: 0.5em)

show figure.where(kind: "photograph"): set figure(supplement: linguify("photograph"))
show figure.where(kind: "graph"): set figure(supplement: linguify("graph"))
show figure.where(kind: "frame"): set figure(supplement: linguify("frame"))


// ===============================================
// Tables
// ===============================================
set table(stroke: 0.5pt)
set table.header(repeat: true)

show figure.where(kind:table) : it => {
  set block(breakable: true)
  set table(
    stroke: (_, y) => (
       top: if y <= 1 { 0.5pt } else { 0pt },
       bottom: 0.5pt,
      ),
    align: (x, y) => (
      if y == 0 or x != 0 { center }
      else { left }
    )
  )
  let header-args(children, cols) = arguments(
    ..children.map(c => {
      let c_fields = c.fields()
      let body = c_fields.remove("body")
      table.cell(
        ..c_fields,
        body,
        stroke: ( bottom: 0.5pt),
      )
    }),
  )

  show table: it => {
    let fields = it.fields()
  
    if fields.at("label", default: none) == <table-show-recursion-stop> {
      it
    } else {
      let children = fields.remove("children")
      if children.at(0).func() == table.header {
        children.at(0) = table.header(
          ..header-args(children.at(0).children, fields.columns.len()),
        )
      }
      if children.at(-1).func() == table.footer {
        children.at(-1) = table.footer(
          ..header-args(children.at(-1).children, fields.columns.len()),
        )
      }
      [#table(..fields, ..children) <table-show-recursion-stop>]
    }
  }
  
  it
}
// ===============================================
// Outlines
// ===============================================

set outline(indent: 0cm)
show outline: it => {
  show heading: set align(center)
  it
}
show outline.entry: it => {
  if it.element.func() == heading{link(
    it.element.location(),
    grid(columns: (10%,auto), it.prefix(),it.inner()),
  )}
  else {link(
    it.element.location(),
    it.prefix()+[ \- ]+it.inner()+[\ ],
  )}
}
show outline.entry: it => {
  set text(weight: 700)
   if it.element.func() == heading {
      set text(
        size:12pt,
        weight: if it.level < 3 {700} else {0}
      )
      if it.level == 1 {upper(it)}
      else if it.level == 4 {underline(it)}
      else if it.level == 5 {emph(it)}
      else {it}
    }else {it}
}

// ===============================================
// Citations
// ===============================================

set cite(style: "associacao-brasileira-de-normas-tecnicas")
set bibliography(
  title: none, 
  style: "associacao-brasileira-de-normas-tecnicas",
)
show bibliography: it => {
  align(heading(linguify("bibliography")),center)
  linebreak()
  set par(leading: 0.5em)
  it
}

// ===============================================
// Quotation
// ===============================================

show quote.where(block: true): it => {
  set text(size: 10pt)
  set par(
    leading: 0.5em, 
    first-line-indent: (amount:4cm, all:true),
    hanging-indent: 4cm
  )

  if it.attribution == none {
    panic("Block quotes need attribution parameter to not be none")
  }
  par(it.body + [ ] + it.attribution + ".")
}

// ===============================================
// Lists
// ===============================================

set list(indent: 1.25cm)
set enum(indent: 1.25cm)

// ===============================================
// Project Content
// ===============================================
page(numbering: none)[
  #set align(center)
  
  #grid(
    rows: 1fr,

    strong(upper(linguify("university"))),
    
    strong(upper(author)),

    align(horizon, strong(upper(title))),
  
    [],
  
    align(bottom, strong(upper[#city \ #year])),
  )
]

page(numbering: none)[
  #set align(center)
  
  #grid(
    rows: 1fr,
  
    strong(upper(author)),
    [],
    grid(
      rows: 1fr,
      align: center,
      strong(upper(title)),
      strong(title-foreign),
    ),
    align(right, block(width: 50%)[
      #set  align(left)
      #set par(first-line-indent: 0cm, spacing: 0.5em,leading: 0.5em)
      \
      #text(size: 10pt, description)
    ]),
    align(bottom, strong(upper[#city \ #year])),
  )
]

context { 
page(numbering: none)[
  #align(center, strong(upper(linguify("abstract")))) \

  #set par(
    justify: true, 
    first-line-indent: 0cm,
    leading: 0.5em,
    spacing: 1.5em,
  )
  
  #if abstract-state.final() != none{
    abstract-state.final()
  } else {
    panic("Abstract was not found, please specify your abstract. Example: `#abstract[example...]`")
  }

  #if keywords != none {
    parbreak()
    linguify("keywords")+[: ]
    for keyword in keywords {
      if keyword != keywords.at(keywords.len()-1){
        keyword + [; ]
      } else{
        keyword + [.]
      }
    }
  } else {
    panic("Please specify keywords as template parameter. Example: `keywords: ([word 1], [word 2], [word 3]),`")
  }
]

page(numbering: none)[
  #align(center, strong(upper(
    linguify("abstract",lang: lang-foreign)
  ))) \
  
  #set par(
    justify: true, 
    first-line-indent: 0cm,
    leading: 0.5em,
    spacing: 1.5em,
  )

  #if abstract-foreign-state.final() != none {
    abstract-foreign-state.final()
  } else {
    panic("Foreign abstract was not found, please specify your abstract. Example: `#abstract-foreign[example...]`")
  }
  #if keywords-foreign != none {
    parbreak()
    linguify("keywords", lang: lang-foreign)+[: ]
    for keyword in keywords-foreign {
      if keyword != keywords-foreign.at(keywords-foreign.len()-1){
        keyword + [; ]
      } else{
        keyword + [.]
      }
    }
  } else {
    panic("Please specify foreign keywords as template parameter. Example: `keywords-foreign: ([word 1], [word 2], [word 3]),`")
  }
]
}

if outline-figure {
  set par(
    justify: true, 
    first-line-indent: 0cm,
    leading: 0.66em,
    spacing: 1.5em,
  )
      
  outline(
    title: [#linguify("outline-figure") \ \ \ ],
    target: figure.where(kind: image)
    .or(figure.where(kind: "photograph"))
    .or(figure.where(kind: "frame"))
    .or(figure.where(kind: "graph")),
  )

}

if outline-table {
  set par(
      justify: true, 
      first-line-indent: 0cm,
      leading: 0.66em,
      spacing: 1.5em,
  )
  outline(
    title: [#linguify("outline-table") \ \ \ ],
    target: figure.where(kind: table),
  )
}


if abbreviations != none {
  set align(left)
  align(center, heading(outlined: false, numbering: none)[
    #linguify("abbreviations") \ \
  ])
  
  grid(
    columns: (15.48%, 84.52%), 
    align: (auto, auto,), 
    row-gutter: 0.7776em,
    ..abbreviations
  )
}

if symbols != none {
  set align(left)
  align(center, heading(outlined: false, numbering: none)[
    #linguify("symbols") \ \
  ])
  
  grid(
    columns: (15.48%, 84.52%), 
    align: (auto, auto,), 
    row-gutter: 0.7776em,
    ..symbols
  )
}

outline(title: [#linguify("outline") \ \ ])

set page(numbering: "1")

body

}// This stops the tcc formatting leaking to extra content

context if appendices-state.final() != () {
  counter(heading).update(0)
  for (index,(appendix, name)) in (..appendices-state.final()).enumerate() {
    set page(numbering: "1",number-align: right+top)
    page(align(center+horizon, heading(level: 2, numbering: none)[
      #upper(linguify("appendix")) #numbering("A",(index+1)) - #name
    ]))
    set heading(outlined: false)
    set figure(outlined: false)
    appendix
  }
}

context if annexes-state.final() != () {
  counter(heading).update(0)

  for (index,(annex, name)) in (..annexes-state.final()).enumerate() {
    set page(numbering: "1",number-align: right+top)
    page(align(center+horizon, heading(level: 2, numbering: none)[
      #upper(linguify("annex")) #numbering("A",(index+1)) - #name
    ]))
    set heading(outlined: false)
    set figure(outlined: false)
    annex
  }
}

}

#let default_figure = figure
#let figure( 
  body,
  source: none,
  note: none,
  ..figure-arguments
) = default_figure(
    block(body + {
      set par(spacing: 0.5em, leading: 0.5em)
      pad(y:-0.5em)[]
      if note!=none{ 
        default_figure.caption(
          linguify("note") + ": " + note, 
          position: bottom
        )
      }
      if source!=none{
        default_figure.caption(
          linguify("source") + ": " + source, 
          position: bottom
        )
      } else {
        panic("Every figure needs a source. Try using `source: [your source (year)]` in the parameters")
      }
    }),
    ..figure-arguments
  )

#let abstract(content) = context {
  if abstract-state.get() != none {
    panic("Only one abstract can be defined by document")
  }
  abstract-state.update(content)
}

#let abstract-foreign(content) = context {
  if abstract-foreign-state.get() != none {
    panic("Only one abstract can be defined by document")
  }
  abstract-foreign-state.update(content)
}


#let appendix(appendix, name) = context {
  let current-appendices-state = appendices-state.get()
  current-appendices-state.push((appendix: appendix, name: name))
  appendices-state.update(current-appendices-state)
}

#let annex(annex, name) = context {
  let current-annexes-state = annexes-state.get()
  current-annexes-state.push((annex: annex, name: name))
  annexes-state.update(current-annexes-state)
}