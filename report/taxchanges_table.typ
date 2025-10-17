#text(size: 1.5em)[#strong[The Impact of Post-2024 Federal Income Tax Changes on Hospital Workers in New York]]

#let row1 = ([#align(left)[Overtime pay]], [#align(left)[No special treatment]], [#align(left)[Deduct overtime premium (the \"half\" in time-and-a-half) up to \$25k married, \$12.5k single.

Phased out for modified AGI above \$300k married, \$150k single]], [#align(left)[Same as 2025 (not indexed)]], [#align(left)[Same

(Note: deduction expires after 2028)]])
#let row2 = ([#align(left)[Standard deduction]], [#align(left)[\$29.2k married, \$14.6k single]], [#align(left)[Bumped beyond inflation by OBBBA, to \$31.5k married, \$15.75k single]], [#align(left)[Indexed for inflation]], [#align(left)[Indexed for inflation]])
#let row3 = ([#align(left)[SALT deduction]], [#align(left)[\$10k cap for most taxpayers]], [#align(left)[\$40k cap for most taxpayers

Phased down to \$10k for modified AGI \$500k-\$600+k (different for married separate)]], [#align(left)[Cap and thresholds indexed by 1%]], [#align(left)[Indexed again

(Note: 2030+ cap reverts to \$10k)]])
#let row4 = ([#align(left)[Other deductions]], [#align(left)[Various]], [#align(left)[No material change but they affect itemizing/standard decision.]], [#align(left)[Same as 2025]], [#align(left)[Same as 2025]])
#let row5 = ([#align(left)[New senior deduction for taxpayers regardless of itemizing or standard status]], [#align(left)[No deduction

(note: 2024+ law allows an additional 65+ standard deduction, unchanged by OBBBA)]], [#align(left)[Additional \$6k per eligible 65+

Phased out for modified AGI over \$150k married, \$75k single, over the next \$100k]], [#align(left)[Amount and thresholds indexed for inflation]], [#align(left)[Indexed again

(Note: deduction expires after 2028)]])
#let row6 = ([#align(left)[Tax brackets]], [#align(left)[Progressive rate structure]], [#align(left)[OBBBA increased 2 lowest brackets beyond inflation, taxing more income at lower rates]], [#align(left)[Indexed for inflation]], [#align(left)[Indexed for inflation]])
#let row7 = ([#align(left)[Tax rates]], [#align(left)[Progressive rate structure]], [#align(left)[Same rates as 2024]], [#align(left)[Same rates as 2024]], [#align(left)[Same rates as 2024]])
#let row8 = ([#align(left)[Child tax credit]], [#align(left)[\$2,000 base credit per eligible child under age 17, refundable

Phases out for modified AGI above \$400k married, \$200k single]], [#align(left)[OBBA increased base credit to \$2,200]], [#align(left)[Indexed for inflation]], [#align(left)[Indexed for inflation]])
#let row9 = ([#align(left)[Child / dependent care credit]], [#align(left)[For qualifying child under age 13 or spouse/dependent unable to care for self:

35% of eligible expenses for AGI up to \$15k, phasing down to 20% by \$43k AGI

Maximum credit \$3k for one child/dependent, \$6k for 2+]], [#align(left)[50% for AGI up to \$15k, phasing down much more slowly]], [#align(left)[Thresholds indexed for inflation]], [#align(left)[Thresholds indexed for inflation]])
#let row10 = ([#align(left)[ACA Premium tax credit]], [#align(left)[Applies to ACA marketplace enrollees who are ineligible for Medicaid, CHIP, Medicare, or affordable employer coverage.

Credit designed so that beneficiaries pay no more than a sliding-scale capped percentage of income, based on \"silver\" plans.  

Credit was enhanced by 2021 American Rescue Plan Act so that it is available even to households with income above 400% of federal poverty limit. Enhancement extended by 2022 Inflation Reduction Act.]], [#align(left)[Same as 2025]], [#align(left)[ARPA/IRA enhancement expires, less-generous and expansive 2021 credit re-emerges]], [#align(left)[Same as 2026]])
#let row11 = ([#align(left)[EITC, education, energy, and other credits]], [#align(left)[Various]], [#align(left)[OBBBA made minor changes to some credits]], [#align(left)[Same]], [#align(left)[Same]])

#set par(justify: false)
#table(
  columns: 5,
  stroke: none,
  inset: 4pt,
  align: left,

  table.header(
    table.cell(colspan: 2)[],
    table.cell(colspan: 3, align: center, fill: rgb("#F2F2F2"))[Scheduled Law],
    [#align(left)[Item]], [#align(left)[2024 law]], [#align(left)[2025]], [#align(left)[2026]], [#align(left)[2027]],
    table.hline(stroke: 0.4pt + luma(180)),
  ),

  // Data rows
  ..row1,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row2,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row3,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row4,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row5,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row6,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row7,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row8,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row9,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row10,
  table.hline(stroke: 0.25pt + luma(200)),
  ..row11,
)