midterm_report.html: midterm_report.Rmd code/04_render_report.R \
  output/graphical_analysis_fig1.png \
  output/graphical_analysis_fig2.png \
  output/graphical_analysis_fig3.png \
  output/demographic_table.rds \
  output/combined_table.rds \
  output/all_multinomial_tables_combined.rds \
  output/aic_results.rds 
	Rscript code/04_render_report.R

output/graphical_analysis_fig1.png: code/02_graphical_analysis.R
	Rscript code/02_graphical_analysis.R
	
output/graphical_analysis_fig2.png: code/02_graphical_analysis.R
	Rscript code/02_graphical_analysis.R
	
output/graphical_analysis_fig3.png: code/02_graphical_analysis.R
	Rscript code/02_graphical_analysis.R
	
output/demographic_table.rds: code/01_data_summary.R
	Rscript code/01_data_summary.R
 
output/combined_table.rds: code/03_modeling.R
	Rscript code/03_modeling.R

output/all_multinomial_tables_combined.rds: code/03_modeling.R
	Rscript code/03_modeling.R

output/aic_results.rds: code/03_modeling.R
	Rscript code/03_modeling.R

.PHONY: clean install
clean:
	rm -f final_report.html && rm -f output/*.png $$ rm -f output/*.rds
	
install:
  Rscript -e "renv::restore(prompt=FALSE)"