# Gender Inequality and Crime against Women
## Group 233 Not Found

### Project Goals

* Explore the relationships between crime against women and five of the following features by state: economic gender gap, education gender gap, health gender gap, political power, and each state’s ruling result on abortion.

* Use the five features above to predict rape rate.

### Research Question

* How does gender inequality, as measured by our 5 indicators (economic gender gap, education gender gap, health gender gap, political empowerment, and 
state-level abortion law), relate to the prevalence of crimes against women in the United States? 
* To what extent can the 5 key indicators be used as predictors of the prevalence of crimes against women in the United States?

### Overall findings

* Generally, higher gender inequality predicts lower rape rate.
* Specifically, higher proportion of women receiving degrees of or above high school, working, or having political power is associated with lower rape rate.
* We are not sure about why life expectancy of women positively predicts rape rate. We hypothesize that this positive correlation may due to a high mortality of young men caused by lower public safety. Future work is needed to substantiate this hypothesis.
* Machine Learning Model Performance：We used linear regression with PCA, linear regression without PCA, random forest regression, lasso regression, ridge regression and SVR to perform our prediction task, and we found that the random forest model and SVR model performed the best with R-squared scores around 0.60, as they are best for non-linear multivariate regression task. For the other models, although the R-squared is approximately 0.38, it is common that the R-squared is low for human behavior related research.

### Team Member
* Yingzi Jin
* April Wang
* Ruoyi Wu
* Guangjie Xu

### Data

* We gathered information of economic, education, health gender gap, political empowerment, rape rate, and ruling result of each state from multiple sources. 

1. Economic data from United States Census Bureau website. https://data.census.gov/table?q=earnings++by+sex+in+%09Virginia&tid=ACSST1Y2019.S2001 (Official data)
  
2. Education attainment data from SEX BY AGE BY EDUCATIONAL ATTAINMENT FOR THE POPULATION 18 YEARS AND OVER in United States Census Bureau website. https://data.census.gov/table?q=2021+SEX+BY+AGE+BY+EDUCATIONAL+ATTAINMENT+FOR+THE+POPULATION+18+YEARS+AND+OVER&t=Populations+and+People&g=0100000US$0400000 (Official data)

3. Sex ratio data from United States Census Bureau website and life expectancy data from both National Center for Disease Control and Prevention and United States Mortality Rates and Life Expectancy by State, Race, and Ethnicity.
https://ghdx.healthdata.org/us-data and
https://data.census.gov/ (Official data)

4. Political empowerment data from Center for American Women and Politics website. 
https://cawp.rutgers.edu/facts/levels-office/state-legislature (Official data)

5. Rape rate data from FBI Uniform Crime Report.
https://ucr.fbi.gov/crime-in-the-u.s/2019/crime-in-the-u.s.-2019/downloads/download-printable-files (Official data)

6. Abortion incidents from the CDC website. 
https://www.cdc.gov/mmwr/preview/mmwrhtml/ss6410a1.htm  (Official data)
 
7. Web scraped each state’s ruling result from Wikipedia page:
https://en.wikipedia.org/wiki/Abortion_law_in_the_United_States_by_state (Official data)

* We transformed the data from csv files, pdf files, and web scraped data to a final csv file of all 50 states in the U.S. from 2011-2020.

### Libraries

* Matplotlib version: 3.5.1
* Seaborn version: 0.11.2
* Pandas version: 1.4.2
* NumPy version: 1.22.4
* Scikit-learn version: 1.0.2
* re version: 2.2.1
* bs4 version: 4.11.1
* requests version: 2.27.1

### How to navigate the Github repo

* The first thing to note in github is the folder **data**, which contains several small folders, each containing the raw data for each variable and the corresponding data cleaning ipynb file.
* Next is the **cleaned_data** folder, which contains all the csv data after data cleaning, as well as all_data.ipynb that brings all the data together.
* When all the data is processed we generate the file **all_data.csv**.
* Next is **EDA.ipynb**, where we use this file for data exploration and visualization.
* In **pca_regress.ipynb**, we first applied PCA for dimensionality reduction, and then used multiple machine learning regression models to predict the data and analyze the performance of the models.

### Responsibilities

* Yingzi Jin: Collected and preprocessed political empowerment data and abortion rate data, conducted traditional statistical analysis, and developed interpretations and possible explanations 
* April Wang: Collected and preprocessed education gender gap data and state crime data, conducted exploratory data analysis, and produced the presentation slides 
* Ruoyi Wu: Collected and preprocessed health gender gap, web scraped each state’s abortion legality, and conducted data visualization and ML modeling  
* Guangjie Xu: Collected and preprocessed economic gender gap data, conducted data exploration and visualization, and conducted ML modeling

### Slides Link: https://drive.google.com/file/d/17v2EpZjToqs1shmj8NEBZ9niwyK1FeS-/view?usp=share_link
