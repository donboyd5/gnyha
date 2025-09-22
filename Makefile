# Windows: install gnu make 
# not good for windows, maybe use with linux

render-prep:
	cd prepare && quarto render

render-report:
	cd report && quarto render

clean-prep:
# cd prepare && rm -rf results
	Rscript -e "unlink('prepare/results', recursive = TRUE)"

clean-report:
	cd report && rm -rf results

all: clean-prep render-prep clean-report render-report
