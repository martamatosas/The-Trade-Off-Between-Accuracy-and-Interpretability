library(Metrics)
library(MASS)
library(BART)
library(MLmetrics)

# SOURCE: https://rdrr.io/cran/BART/man/lbart.html
# BART is a Bayesian “sum-of-trees” model.
# For numeric response y, we have y = f(x) + e, where e ~ Log(0, 1).
# For a binary response y, P(Y=1 | x) = F(f(x)), where F denotes the standard Logistic CDF (logit link).
# In both cases, f is the sum of many tree models. 
# lbart generate draws of f(x) for each x which is a row of x.test.

# -----------------------------------------
# Read the data
train_data = read.csv( file="df_train.csv" )
test_data = read.csv(file="df_test.csv")
yName = "diagnosis" ; xName = c( "texture_mean","area_worst","smoothness_worst","area_mean","concavity_mean" ) 
#print(dim(train_data))
#nsamples = dim(train_data)[1]
#nfeatures = dim(train_data)[2]
#num_run = 4

# -----------------------------------------
# prepare data for BART
colnames(train_data)
x.train = train_data[,!(colnames(train_data) %in% yName)]
x.test = test_data[,!(colnames(test_data) %in% yName)]
y.train = train_data[,c(yName)]
y.test = test_data[,c(yName)]

# -----------------------------------------
# Different models were tried
#num_model = "1" # lbart(x.train, y.train, x.test, ntree=100, ndpost=1000)
#num_model = "2" # lbart(x.train, y.train, x.test, ntree=200, ndpost=200)
num_model = "1" 
post <- lbart(x.train, y.train, x.test, ntree=100, ndpost=1000)
# -----------------------------------------
# A matrix with ndpost rows and nrow(x.test) columns.
# Each row corresponds to a draw f* from the posterior of f 
#and each column corresponds to a row of x.test 
## turn z-scores into probabilities
post$prob.test <- plogis(post$yhat.test)

# PRINT THIS TO DISPLAY THE MATRIX WITH PROBABILITIES
post$prob.test

## average over the posterior samples
post$prob.test.mean <- apply(post$prob.test, 2, mean)
# extract prediction
prediction <- post$prob.test.mean
comparison <- cbind(y.test, prediction)

# -----------------------------------------
# threshold 0.5 -> if prediction sample > 0.5, set value to 1
valuate_sample <- function(x){ifelse(x>0.5, 1, 0)}
library(dplyr)
df <- as.data.frame(prediction)
df2 <- df %>% mutate(prediction = valuate_sample(prediction))

# create final dataset 
final <- cbind(comparison,df2)
colnames(final) <- c("real", "model_prediction", "prediction")

# -----------------------------------------
# Metrics of model
# RMSE
RMSE(post$prob.test.mean,y.test)
# accuracy
accuracy(final$real, final$prediction)
# Var count
varCount =as.data.frame(post$varcount.mean)
colnames(varCount) <- c("Count")

# print varcount
varCount

# store results in csv and txt
address <- paste("./results_model_",num_model,sep = "")
write.csv(as.data.frame(final),file=paste(address, "/results.csv",sep = ""))
write.table(RMSE(post$prob.test.mean,y.test), paste(address, "/RMSE.txt",sep = ""), row.names=FALSE,col.names=FALSE)
write.table(accuracy(final$real, final$prediction), paste(address, "/accuracy.txt",sep = ""), row.names=FALSE,col.names=FALSE)
write.csv(varCount,file=paste(address,"/varCount.csv",sep = ""))
