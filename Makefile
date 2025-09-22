# Windows: install gnu make 

render-prep:
	cd prepare && quarto render

render-report:
	cd report && quarto render

clean-prep:
	cd prepare && rm -rf results

clean-report:
	cd report && rm -rf results

all: clean-prep render-prep clean-report render-report
