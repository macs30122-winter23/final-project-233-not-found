## MACS30122 Final Project Statistical Analysis 
# import dataset into the environment ->

# extract features we are interested in
library('dplyr')
df_feature <-  dplyr::select(all_data,-c('state'))

# calculate integrated gender gap index
# considering education, state_legislature, abortion_rate, labor_force_participation
# bachelor_wage_gap, life_exp_f_m
feature_sd <- apply(df_feature, 2, sd)
selected_index = c(1,3,4,5,7,9)
feature_sd <- feature_sd[selected_index]

weights = sapply(feature_sd, function(x) {0.01/x})
weights = sapply(weights, function(x){x/sum(weights)})
gap = rowSums(df_feature[,selected_index] * weights[col(df_feature[,selected_index])])
df_gap = df_feature
df_gap$gap = gap

# to compare effect size of coefficients, we need to scale our data first 
df_feature_scaled <- as.data.frame(scale(df_feature))


# apply multivariate regression model on scaled data
# dependent variable: rape_rate, independent variables: the rest
model = lm(rape_rate~., data=df_feature_scaled)
summary(model)

# visualize the results
library(jtools)
plot_summs(model)

# check normality of residuals using q-q plot
qqnorm(model$residuals)
qqline(model$residuals) 
# most residual points lay on the normal line, we can say that the residuals 
# roughly follow a normal distribution 

# results: 
# 1.significant and negative relationships with rape_rate, all else being equal:
# education
# 2. significant and positive relationships with rape_rate, all else being equal:
# year, life_exp_f_m

## control state_gov, female_gov vs. male_gov
df_f_gov = df_feature[df_feature$state_gov==1,]
df_m_gov = df_feature[df_feature$state_gov==0,]

df_f_gov <- dplyr::select(df_f_gov,-c('state_gov'))
df_f_gov_scaled <- as.data.frame(scale(df_f_gov))
df_m_gov <- dplyr::select(df_m_gov,-c('state_gov'))
df_m_gov_scaled <- as.data.frame(scale(df_m_gov))

# welch-test, compare rate_rate
t.test(df_f_gov$rape_rate, df_m_gov$rape_rate, 'less')
# p-value < 0.05, which indicates that rape rates of states governed by female
# are significantly less than the ones of states governed by male

# visualize the test results
library(ggplot2)
mean = c(mean(df_f_gov$rape_rate), mean(df_m_gov$rape_rate))
sd = c(sd(df_f_gov$rape_rate), sd(df_m_gov$rape_rate))
d = data.frame(state_gov=c('female governor', 'male governor'), mean=mean, 
               lower=mean-sd, upper=mean+sd)
ggplot(data=d, aes(x=state_gov, y=mean, group=1)) +
  geom_line()+
  geom_errorbar(aes(ymin=lower, ymax=upper), width=0.2, size=1, color="black") + 
  geom_point(data=d, mapping=aes(x=state_gov, y=mean), size=4, shape=21, fill="white")+
  xlab('gender of state governor') +
  ylab('rape rate')+
  ylim(0, 75)


# apply multivariate regression model to each 
model_f = lm(rape_rate~., data=df_f_gov_scaled)
model_m = lm(rape_rate~., data=df_m_gov_scaled)

# check normality of residuals 
qqnorm(model_f$residuals)
qqline(model_f$residuals) 

qqnorm(model_m$residuals)
qqline(model_m$residuals) 

# check the models
summary(model_f)
summary(model_m)

# visualize the results
plot_summs(model_f, model_m, model.names = c("female_gov", "male_gov"))

# It is interesting to see that the significance of labour_force_participation and
# legality appear when only considering states governed by female, which implies that
# rape might not be well explained by gender inequality in the states governed 
# only by men
# we would like to also control legality 


# control abortion legality alone
legal = df_feature[df_feature$legality==1,]
illegal = df_feature[df_feature$legality==0,]

legal <- dplyr::select(legal,-c('legality'))
legal_scaled <- as.data.frame(scale(legal))
illegal <- dplyr::select(illegal,-c('legality'))
illegal_scaled <- as.data.frame(scale(illegal))

model_legal = lm(rape_rate~., data=legal_scaled)
model_illegal = lm(rape_rate~., data=illegal_scaled)

plot_summs(model_legal, model_illegal)

# despite the consistency of effect of education and year, it is interesting that
# state_legislature, life_exp_f_m, state_gov only show (marginally) significant and
# negative impact on rape_rate in the states with illegal abortion, which we assume 
# to be more conservative and less gender equal in general. However, 
# labour_force_participation shows significant and positive impact on rape_rate.
# one possible explanation is that here labour_force_participation does not 
# reflect economic gender gap, but economy in general. Women in places that have 
# slack economy might have to work to feed family, even though the culture there
# does not encourage and support career women. 


# control both state_gov and legality 
# f_gov
legal_f_gov = df_f_gov[df_f_gov$legality == 1,]
illegal_f_gov = df_f_gov[df_f_gov$legality == 0,]
legal_f_gov = legal_f_gov %>% select(-c('legality'))
illegal_f_gov = illegal_f_gov %>% select(-c('legality'))

legal_f_gov_scaled = as.data.frame(scale(legal_f_gov))
illegal_f_gov_scaled = as.data.frame(scale(illegal_f_gov))


model_legal_f = lm(rape_rate~., data=legal_f_gov_scaled)
summary(model_legal_f)

model_illegal_f = lm(rape_rate~., data=illegal_f_gov_scaled)
summary(model_illegal_f)


# m_gov
legal_m_gov = df_m_gov[df_m_gov$legality == 1,]
illegal_m_gov = df_m_gov[df_m_gov$legality == 0,]
legal_m_gov = legal_m_gov %>% select(-c('legality'))
illegal_m_gov = illegal_m_gov %>% select(-c('legality'))

legal_m_gov_scaled = as.data.frame(scale(legal_m_gov))
illegal_m_gov_scaled = as.data.frame(scale(illegal_m_gov))

model_legal_m = lm(rape_rate~., data=legal_m_gov_scaled)
summary(model_legal_m)

model_illegal_m = lm(rape_rate~., data=illegal_m_gov_scaled)
summary(model_illegal_m)


# visualize the results from the four models
plot_summs(model_legal_f, model_illegal_f, model_legal_m, model_illegal_m,
           model.names = c('female_legal','female_illegal','male_legal','male_illegal'))


# check equal varience and normality of residuals
qqnorm(model_legal_f$residuals)
qqline(model_legal_f$residuals) 

qqnorm(model_illegal_f$residuals)
qqline(model_illegal_f$residuals) 

qqnorm(model_legal_m$residuals)
qqline(model_legal_m$residuals) 

qqnorm(model_illegal_m$residuals)
qqline(model_illegal_m$residuals) 


# some interesting findings:
# 1. consistency of effect of education and year 
# 2. only in female_illegal model, state_legislature, bachelor_wage_gap, and 
# life_exp_f_m show significant and negative impact on rape_rate. 




## check any significant difference in gender gap among the four groups
group <- ifelse(df_feature$state_gov == 1 & df_feature$legality == 1, "female_legal",
                ifelse(df_feature$state_gov == 1 & df_feature$legality == 0, "female_illegal",
                       ifelse(df_feature$state_gov == 0 & df_feature$legality == 1, "male_legal",
                              "male_illegal")))
# CI plots
ggplot(df_gap, aes(x=group, y = gap)) +
  #draws the means
  stat_summary(fun.data = "mean_cl_normal",geom = "point") + 
  #draws the CI error bars
  stat_summary(fun.data = "mean_cl_normal", geom = "errorbar", width=0.5)+
  xlab('state_gov x legality')+
  ylab('gender gap index')

## female_legal has the highest index, indicating the highest level of gender 
# equality. Male-legal is the second highest, and male-illegal the third. All have
# significance. 
# Surprisingly, female-illegal has the lowest level of gender equality.
# However, according to a comment from the discussion panel, it is reasonable to
# see the results. If a state prohibits abortion, then it should be a more 
# conservative state. And if a woman can be elected as governor or lt-governor
# in such state, it is likely that she is more conservative than the average
# and may not bring attention to gender-related issues to canvass for votes.


## 



