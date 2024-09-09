#set text(
	font: "Latin Modern Roman",
	size: 11pt
)

#set page(
	paper: "a4",
	margin: (x: 3cm, y:2.5cm),
	footer: context[
		#line(length: 100%)
		#set align(right)
		#set text(10pt)
		#counter(page).display()
	]
)

#set par(
	justify:true,
	// first-line-indent: 1em,
	// leading: 0.5em
)

#show ref: it => {
  let eq = math.equation
  let el = it.element
  if el != none and el.func() == eq {
    // Override equation references.
    numbering(
      el.numbering,
      ..counter(eq).at(el.location())
    )
  } else {
    // Other references as usual.
    it
  }
}

#set math.equation(numbering: "(1)")
#let nonum(eq) = math.equation(block: true, numbering: none, eq)

#align(center, text(16pt)[**])
#line(length: 100%, stroke: 0.65pt)
